//
//  TastingNotesAppDelegate.m
//  TastingNotes
//
//  Created by Matthew Campbell on 11/14/08.
//  Copyright App Shop, LLC 2008. All rights reserved.
//  Testing GitHub connections

#import "TNAppDelegate.h"

@implementation TNAppDelegate

-(void)setUpAppContent{
    self.content = [AppContent sharedContent];
    self.content.noteBookType = Wine;
}

-(void)applicationDidFinishLaunching:(UIApplication *)application{
    [self setUpAppContent];
    [self.content setUpInititalNotebook];
    UITabBarController *tbc = (UITabBarController *)self.window.rootViewController;
    UINavigationController *nc1 = [[tbc viewControllers] objectAtIndex:1];
    nc1.tabBarItem.title = self.content.activeNotebook.name;
    self.window.tintColor = [UIColor redColor];
}

@end