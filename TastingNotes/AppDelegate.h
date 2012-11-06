//
//  TastingNotesAppDelegate.h
//  TastingNotes
//
//  Created by Matthew Campbell on 11/14/08.
//  Copyright App Shop, LLC 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;

-(void)lockEditingWhileDoingDatabaseRestore;
-(void)unlockEditingAfterDoingDatabaseRestore;

@end