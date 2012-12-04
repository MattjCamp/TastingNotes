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
    self.content.noteBookType = Beer;
}

-(void)startDropbox{
    DropboxBackup *db = [DropboxBackup sharedDropbox];
    db.appKey = @"oovx72dm7b1yfgy";
    db.appSecret = @"99m7vpzorb1qsmd";
    db.root = kDBRootAppFolder;
    db.dropboxDBFilePathName = @"/paddb.sql";
    db.dropboxFolderPathName = @"/";
}

@end