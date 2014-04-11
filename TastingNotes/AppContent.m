//
//  RootModel.m
//  TastingNotes
//
//  Created by Matthew Campbell on 2/3/11.
//  Copyright 2011 App Shop LLC. All rights reserved.
//

#import "AppContent.h"

@implementation AppContent
NSString *userSettingsFilename;

static AppContent *sharedObject = nil;

+(id)sharedContent {
    @synchronized(self) {
        if(sharedObject == nil)
            sharedObject = [[super allocWithZone:NULL] init];
    }
    return sharedObject;
}

-(id)init {
    if ((self = [super init])) {
        if(![[NSFileManager defaultManager] fileExistsAtPath:[self cacheDirectory] isDirectory:nil])
            [[NSFileManager defaultManager] createDirectoryAtPath:[self cacheDirectory] withIntermediateDirectories:NO attributes:nil error:nil];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        userSettingsFilename = [NSString stringWithFormat:@"%@/UserSettings.plist", [paths lastObject]];
        if([[NSFileManager defaultManager] fileExistsAtPath:userSettingsFilename])
            self.userSettings =  [NSMutableDictionary dictionaryWithContentsOfFile:userSettingsFilename];
        else
            self.userSettings =  [NSMutableDictionary dictionaryWithContentsOfFile:[NSString stringWithFormat:@"%@/UserSettings.plist", [[NSBundle mainBundle] resourcePath]]];
        
		databaseVersion = nil;
		appType = nil;
		self.notebooks = [[Notebooks alloc] init];
        
    }
    
    return self;
}

-(void)setUpInititalNotebook{
    if(!self.databaseIsInitialized){
        [self.notebooks addNewNotebookWithThisType:self.noteBookType];
        self.databaseIsInitialized = YES;
    }
    else{
        //upgrade procedure
    }
    NSNumber *an = [self.userSettings objectForKey:@"ActiveNotebook"];
    
    @try {
        _activeNotebook = [self.notebooks.listOfNotebooks objectAtIndex:[an intValue]];
    }
    @catch (NSException *exception) {
        NSLog(@"exception = %@", exception);
        _activeNotebook = [self.notebooks.listOfNotebooks lastObject];
    }
}

#pragma mark Properties

-(void)dealloc {
	databaseVersion = nil;
}

-(BOOL)databaseIsInitialized {
	NSString *status = [[SQLiteDB sharedDatabase]
						getValueFromThisTable:@"MetaTable"
						usingThisSelectStatement:@"SELECT DatabaseStatus FROM MetaTable WHERE pk = 1"];
	
	if([status isEqualToString:@"YES"])
		return YES;
	else
		return NO;
}

-(void)setDatabaseIsInitialized:(BOOL)aBOOL {
	if (databaseIsInitialized == aBOOL) return;
	
	if(aBOOL == YES)
		[[SQLiteDB sharedDatabase] updateStringInThisTable:@"MetaTable"
											  inThisColumn:@"DatabaseStatus"
											 withThisValue:@"YES"
								   usingThisWhereStatement:@"WHERE pk = 1"];
	else
		[[SQLiteDB sharedDatabase] updateStringInThisTable:@"MetaTable"
											  inThisColumn:@"DatabaseStatus"
											 withThisValue:@"NO"
								   usingThisWhereStatement:@"WHERE pk = 1"];
    databaseIsInitialized = aBOOL;
}

-(NSNumber *)databaseVersion {
	if(databaseVersion == nil){
		NSString *temp = [[SQLiteDB sharedDatabase]
                          getValueFromThisTable:@"MetaTable"
                          usingThisSelectStatement:@"SELECT DatabaseVersion FROM MetaTable WHERE pk = 1;"];
		
        if((NSNull *)temp == [NSNull null])
            return nil;
        
        databaseVersion = [NSNumber numberWithDouble:[temp doubleValue]];
        
		
		return databaseVersion;
	}
	else
		return databaseVersion;
}
-(void)setDatabaseVersion:(NSNumber *)aNumber {
	if (!databaseVersion && !aNumber) return;
	[[SQLiteDB sharedDatabase] updateNumberInThisTable:@"MetaTable"
										  inThisColumn:@"DatabaseVersion"
										 withThisValue:aNumber
							   usingThisWhereStatement:@"WHERE pk = 1"];
	
	databaseVersion = nil;
    databaseVersion = aNumber;
}

-(NSString *)appType {
	if(appType == nil){
		appType = [[SQLiteDB sharedDatabase]
                   getValueFromThisTable:@"MetaTable"
                   usingThisSelectStatement:@"SELECT AppType FROM MetaTable WHERE pk = 1;"];
        if((NSNull *)appType == [NSNull null])
            appType = nil;
		return appType;
	}
	else
		return appType;
}

-(void)setAppType:(NSString *)aString {
	if ((!appType && !aString) || (appType && aString && [appType isEqualToString:aString])) return;
	[[SQLiteDB sharedDatabase] updateStringInThisTable:@"MetaTable"
										  inThisColumn:@"AppType"
										 withThisValue:aString
							   usingThisWhereStatement:@"WHERE pk = 1"];
    
	appType = nil;
    appType = aString;
}

Notebook *_activeNotebook;

-(Notebook *)activeNotebook{
    if(!_activeNotebook)
        _activeNotebook = [self.notebooks.listOfNotebooks objectAtIndex:0];
    return _activeNotebook;
}

-(void)setActiveNotebook:(Notebook *)activeNotebook{
    _activeNotebook = activeNotebook;
    int i = [self.notebooks.listOfNotebooks indexOfObject:activeNotebook];
    [self.userSettings setObject:[NSNumber numberWithInt:i] forKey:@"ActiveNotebook"];
    [self.userSettings writeToFile:userSettingsFilename atomically:YES];
}

-(void)resetNotebookData{
    NSFileManager *fm = [NSFileManager defaultManager];
    [fm removeItemAtPath:[self cacheDirectory] error:nil];
    _activeNotebook = nil;
    databaseVersion = nil;
    appType = nil;
    [self.notebooks resetData];
    [[SQLiteDB sharedDatabase] restartDatabase];
    [[SQLiteDB sharedDatabase] copyDatabaseIfAbsent];
    [[SQLiteDB sharedDatabase] initializeDatabase];
    [self.delegate notebookDataJustReset];
}

-(NSString *)cacheDirectory{
    if(!_cacheDirectory)
        _cacheDirectory = [NSTemporaryDirectory() stringByAppendingPathComponent:@"appcontentcache"];
    return _cacheDirectory;
}

-(NSString *)cssFileCache{
    NSString *cssFileBundle = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"tastingnotesnotestyledefault.css"];
    NSString *cssFileCache = [[[AppContent sharedContent] cacheDirectory] stringByAppendingPathComponent:@"tastingnotesnotestyledefault.css"];
    if(![[NSFileManager defaultManager] fileExistsAtPath:cssFileCache])
        [[NSFileManager defaultManager] copyItemAtPath:cssFileBundle toPath:cssFileCache error:nil];
    
    return cssFileCache;
}

@end