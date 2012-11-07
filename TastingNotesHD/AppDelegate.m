//
//  AppDelegate.m
//  TastingNotesHD
//
//  Created by Matthew Campbell on 11/6/12.
//  Copyright (c) 2012 Mobile App Mastery. All rights reserved.
//

#import "AppDelegate.h"
#import "Analytics.h"

@implementation AppDelegate

-(void)startTracker{
    //[[Analytics sharedAnalytics] setWebPropertyID:@"UA-35331153-1"];
    [[Analytics sharedAnalytics] startTracking];
}

-(void)setUpAppContent{
    self.content = [AppContent sharedContent];
    self.content.noteBookType = Wine;
}

@end