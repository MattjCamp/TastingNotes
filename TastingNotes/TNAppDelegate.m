//
//  TastingNotesAppDelegate.m
//  TastingNotes
//
//  Created by Matthew Campbell on 11/14/08.
//  Copyright App Shop, LLC 2008. All rights reserved.
//

#import "TNAppDelegate.h"
#import "DropboxBackup.h"
#import "Analytics.h"

@implementation TNAppDelegate

-(void)startTracker{
    [[Analytics sharedAnalytics] setWebPropertyID:@"UA-35331153-1"];
    [[Analytics sharedAnalytics] startTracking];
}

-(void)setUpAppContent{
    self.content = [AppContent sharedContent];
    self.content.noteBookType = Wine;
}

-(void)startDropbox{
    DropboxBackup *db = [DropboxBackup sharedDropbox];
    db.appKey = @"70m5g2c6cyr0pfw";
    db.appSecret = @"rnpfck1mkyqbi4p";
    db.root = kDBRootDropbox;
    db.dropboxDBFilePathName = @"/tastingnotesappbackup/paddb.sql";
    db.dropboxFolderPathName = @"/tastingnotesappbackup";
}

-(void)applicationDidFinishLaunching:(UIApplication *)application{
    [self startTracker];
    [self setUpAppContent];
    [self startDropbox];
    [self.content setUpInititalNotebook];
    UITabBarController *tbc = (UITabBarController *)self.window.rootViewController;
    UINavigationController *nc1 = [[tbc viewControllers] objectAtIndex:1];
    nc1.tabBarItem.title = self.content.activeNotebook.name;
    [self skinApp];
}

-(void)skinApp{
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:10];
    UIColor *color = [UIColor darkGrayColor];
    [[UINavigationBar appearance] setTintColor:color];
    [[UILabel appearanceWhenContainedIn:[UITabBar class], nil] setFont:font];
    [[UIToolbar appearance] setTintColor:color];
    [[UISearchBar appearance] setTintColor:color];
}

- (void)applicationWillResignActive:(UIApplication *)application{
    //[[Analytics sharedAnalytics] dispatchSynchronously];
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
	if ([[DBSession sharedSession] handleOpenURL:url]) {
		if ([[DBSession sharedSession] isLinked]) {
            NSLog(@"handleOpenURL: Tasting Notes is linked to Dropbox");
            [[DropboxBackup sharedDropbox] finishLinking];
		}
		return YES;
	}
	
	return NO;
}

-(void)lockEditingWhileDoingDatabaseRestore{
    NSLog(@"Locking down the UI for a database restore");
    UITabBarController *tbc = (UITabBarController *)self.window.rootViewController;
    
    UIViewController *noteAdder = [tbc.viewControllers objectAtIndex:0];
    if([noteAdder canPerformAction:@selector(lockEditingWhileDoingDatabaseRestore) withSender:nil]){
        NSLog(@"- Locking vc %@", noteAdder.title);
        [noteAdder performSelector:@selector(lockEditingWhileDoingDatabaseRestore)];
    }
    
    UINavigationController *notebook = [tbc.viewControllers objectAtIndex:1];
    for (UIViewController *vc in notebook.viewControllers){
        if([vc canPerformAction:@selector(lockEditingWhileDoingDatabaseRestore) withSender:nil]){
            NSLog(@"- Locking vc %@", vc.title);
            [vc performSelector:@selector(lockEditingWhileDoingDatabaseRestore)];
        }
    }
}

-(void)unlockEditingAfterDoingDatabaseRestore{
    
    AppContent *content = [AppContent sharedContent];
    [content resetNotebookData];
    content.activeNotebook = [content.notebooks.listOfNotebooks lastObject];
    
    NSLog(@"Unlocking the UI for a database restore");
    UITabBarController *tbc = (UITabBarController *)self.window.rootViewController;
    
    UIViewController *noteAdder = [tbc.viewControllers objectAtIndex:0];
    if([noteAdder canPerformAction:@selector(unlockEditingAfterDoingDatabaseRestore) withSender:nil]){
        NSLog(@"- Unlocking vc %@", noteAdder.title);
        [noteAdder performSelector:@selector(unlockEditingAfterDoingDatabaseRestore)];
    }
    
    UINavigationController *notebook = [tbc.viewControllers objectAtIndex:1];
    for (UIViewController *vc in notebook.viewControllers){
        if([vc canPerformAction:@selector(unlockEditingAfterDoingDatabaseRestore) withSender:nil]){
            NSLog(@"- Unlocking vc %@", vc.title);
            [vc performSelector:@selector(unlockEditingAfterDoingDatabaseRestore)];
        }
    }
}

@end