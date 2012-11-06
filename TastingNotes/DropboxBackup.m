//
//  DropboxBackup.m
//  TastingNotes
//
//  Created by Matthew Campbell on 9/12/12.
//
//

#import "DropboxBackup.h"
#import "Analytics.h"

@implementation DropboxBackup

NSString *relinkUserId;
static DropboxBackup *singletonInstance = nil;

+ (DropboxBackup *)sharedDropbox{
    @synchronized(self){
        if (singletonInstance == nil)
            singletonInstance = [[self alloc] init];
        
        return singletonInstance;
    }
}

-(void)startSessionThenDoThisWhenReady:(void(^)())finishingLoadingBlock{
    NSString* appKey = @"70m5g2c6cyr0pfw";
	NSString* appSecret = @"rnpfck1mkyqbi4p";
	NSString *root = kDBRootDropbox; //kDBRootAppFolder or kDBRootDropbox
	NSString* errorMsg = nil;
	if ([appKey rangeOfCharacterFromSet:[[NSCharacterSet alphanumericCharacterSet] invertedSet]].location != NSNotFound) {
		errorMsg = @"Make sure you set the app key correctly in AppDelegate.m";
	} else if ([appSecret rangeOfCharacterFromSet:[[NSCharacterSet alphanumericCharacterSet] invertedSet]].location != NSNotFound) {
		errorMsg = @"Make sure you set the app secret correctly in AppDelegate.m";
	} else if ([root length] == 0) {
		errorMsg = @"Set your root to use either App Folder of full Dropbox";
	} else {
		NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
		NSData *plistData = [NSData dataWithContentsOfFile:plistPath];
		NSDictionary *loadedPlist =
        [NSPropertyListSerialization
         propertyListFromData:plistData mutabilityOption:0 format:NULL errorDescription:NULL];
		NSString *scheme = [[[[loadedPlist objectForKey:@"CFBundleURLTypes"] objectAtIndex:0] objectForKey:@"CFBundleURLSchemes"] objectAtIndex:0];
		if ([scheme isEqual:@"db-APP_KEY"]) {
			errorMsg = @"Set your URL scheme correctly in Info.plist (db-APP_KEY)";
		}
	}
	DBSession* session = [[DBSession alloc] initWithAppKey:appKey
                                                 appSecret:appSecret
                                                      root:root];
	[DBSession setSharedSession:session];
	finishingLoadingBlock();
}

-(void)linkFromViewController:(UIViewController *)vc
           thenDoThisWhenDone:(void (^)())doneLinkingBlock{
    if (![[DBSession sharedSession] isLinked]){
		[[DBSession sharedSession] linkFromController:vc];
        _doneLinkingBlock = doneLinkingBlock;
    }
    else{
        [[DBSession sharedSession] unlinkAll];
        doneLinkingBlock();
    }
    
}

-(void)finishLinking{
    _doneLinkingBlock();
    _doneLinkingBlock = nil;
}

-(NSString *)localDBFilePathName{
    NSFileManager *fileManager = [NSFileManager defaultManager];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *userDirectory = [[paths objectAtIndex:0] stringByAppendingFormat:@"/User/"];
	BOOL directoryExists = [fileManager fileExistsAtPath:userDirectory];
	NSError *err = nil;
	if(directoryExists == NO)
		[fileManager createDirectoryAtPath:userDirectory
			   withIntermediateDirectories:NO
								attributes:nil error:&err];
    
    NSString *databaseFileName = @"/paddb.sql";
    NSString *localDB = [userDirectory stringByAppendingString:databaseFileName];
    
    return localDB;
}

-(NSString *)dropboxDBFilePathName{
    return @"/tastingnotesappbackup/paddb.sql";
}

-(void)restoreDatabaseAndDoThisWhileWorking:(void (^)(float progress))downloadProgressBlock
                         thenDoThisWhenDone:(void (^)())fileDownloadedCompletionBlock{
    _downloadProgressBlock = downloadProgressBlock;
    _fileDownloadedCompletionBlock = fileDownloadedCompletionBlock;
    self.restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
    self.restClient.delegate = self;
    [self.restClient loadFile:[self dropboxDBFilePathName]
                     intoPath:[self localDBFilePathName]];
    [[Analytics sharedAnalytics]thisUserActionOccured:@"Database Restored"
                                      forThisCategory:@"Utilities"
                                            thisValue:-1];
}

-(void)backupDatabaseAndDoThisWhileWorking:(void (^)(float progress))uploadProgressBlock
                        thenDoThisWhenDone:(void (^)())fileUploadedCompletionBlock{
    _uploadProgressBlock = uploadProgressBlock;
    _fileUploadedCompletionBlock = fileUploadedCompletionBlock;
    
    self.restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
    self.restClient.delegate = self;
    [self.restClient loadMetadata:[self dropboxDBFilePathName]];
    
    [[Analytics sharedAnalytics]thisUserActionOccured:@"Database Backed Up"
                                      forThisCategory:@"Utilities"
                                            thisValue:-1];
    
}

#pragma mark DBNetworkRequestDelegate methods

static int outstandingRequests;

- (void)networkRequestStarted {
	outstandingRequests++;
	if (outstandingRequests == 1) {
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	}
}

- (void)networkRequestStopped {
	outstandingRequests--;
	if (outstandingRequests == 0) {
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	}
}

#pragma mark DBSessionDelegate methods

- (void)sessionDidReceiveAuthorizationFailure:(DBSession*)session userId:(NSString *)userId {
	relinkUserId = userId;
    NSLog(@"sessionDidReceiveAuthorizationFailure:%@", userId);
}

#pragma mark DBRestClientDelegate methods

- (void)restClient:(DBRestClient*)client loadedFile:(NSString*)destPath{
    _fileDownloadedCompletionBlock();
    _fileDownloadedCompletionBlock = nil;
    _downloadProgressBlock = nil;
}
-(void)restClient:(DBRestClient*)client loadProgress:(CGFloat)progress forFile:(NSString*)destPath{
    _downloadProgressBlock(progress);
}

-(void)restClient:(DBRestClient*)client loadFileFailedWithError:(NSError*)error{
    NSLog(@"loadFileFailedWithError:%@", error);
}

-(void)restClient:(DBRestClient*)client uploadedFile:(NSString*)destPath from:(NSString*)srcPath metadata:(DBMetadata*)metadata{
    _fileUploadedCompletionBlock();
    _fileUploadedCompletionBlock = nil;
    _uploadProgressBlock = nil;
}

-(void)restClient:(DBRestClient*)client uploadProgress:(CGFloat)progress forFile:(NSString*)destPath from:(NSString*)srcPath{
    _uploadProgressBlock(progress);
}

-(void)restClient:(DBRestClient*)client uploadFileFailedWithError:(NSError*)error{
    NSLog(@"uploadFileFailedWithError:%@", error);
}

-(void)restClient:(DBRestClient*)client loadedMetadata:(DBMetadata*)metadata{
    self.databaseMetadata = metadata;
    
    [self.restClient uploadFile:@"/paddb.sql"
                         toPath:@"/tastingnotesappbackup"
                  withParentRev:self.databaseMetadata.rev
                       fromPath:[self localDBFilePathName]];
}

-(void)restClient:(DBRestClient*)client loadMetadataFailedWithError:(NSError*)error{
    NSLog(@"loadMetadataFailedWithError:%@", error);
}

-(void)dealloc{
    _fileUploadedCompletionBlock = nil;
    _fileDownloadedCompletionBlock = nil;
    _downloadProgressBlock = nil;
    _uploadProgressBlock = nil;
    _retrievedMetaDataAction = nil;
    _doneLinkingBlock = nil;
}

@end
