//
//  DropboxBackup.h
//  TastingNotes
//
//  Created by Matthew Campbell on 9/12/12.
//
//

#import <Foundation/Foundation.h>
#import <DropboxSDK/DropboxSDK.h>

@interface DropboxBackup : NSObject<DBSessionDelegate, DBNetworkRequestDelegate, DBRestClientDelegate>{
@private
    void (^_uploadProgressBlock)(float progress);
    void (^_downloadProgressBlock)(float progress);
    void (^_fileUploadedCompletionBlock)();
    void (^_fileDownloadedCompletionBlock)();
    void (^_doneLinkingBlock)();
    void (^_retrievedMetaDataAction)(DBMetadata *meta);
}

+(DropboxBackup *)sharedDropbox;

@property (nonatomic) DBRestClient* restClient;
@property (strong) DBMetadata *databaseMetadata;

-(NSString *)localDBFilePathName;
-(NSString *)dropboxDBFilePathName;

-(void)startSessionThenDoThisWhenReady:(void(^)())finishingLoadingBlock;
-(void)linkFromViewController:(UIViewController *)vc
           thenDoThisWhenDone:(void (^)())doneLinkingBlock;
-(void)finishLinking;
-(void)restoreDatabaseAndDoThisWhileWorking:(void (^)(float progress))downloadProgressBlock
                         thenDoThisWhenDone:(void (^)())fileDownloadedCompletionBlock;
-(void)backupDatabaseAndDoThisWhileWorking:(void (^)(float progress))uploadProgressBlock
                        thenDoThisWhenDone:(void (^)())fileUploadedCompletionBlock;

@end