//
//  AppDelegate.m
//  CommanderData
//
//  Created by Matthew Campbell on 11/15/12.
//  Copyright (c) 2012 Mobile App Mastery. All rights reserved.
//

#import "AppDelegate.h"
#import "Analytics.h"
#import "DropboxBackup.h"

@implementation AppDelegate

-(void)startTracker{
    [[Analytics sharedAnalytics] setWebPropertyID:@"UA-35331153-3"];
    [[Analytics sharedAnalytics] startTracking];
}

-(void)setUpAppContent{
    self.content = [AppContent sharedContent];
    self.content.noteBookType = GeneralNote;
}

-(void)startDropbox{
    DropboxBackup *db = [DropboxBackup sharedDropbox];
    db.appKey = @"f8uopf1ydhoaxt0";
    db.appSecret = @"t8oq8j41090sj2v";
    db.root = kDBRootAppFolder;
    db.dropboxDBFilePathName = @"/paddb.sql";
    db.dropboxFolderPathName = @"/";
}

@end