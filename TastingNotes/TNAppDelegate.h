//
//  TastingNotesAppDelegate.h
//  TastingNotes
//
//  Created by Matthew Campbell on 11/14/08.
//  Copyright App Shop, LLC 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppContent.h"

@interface TNAppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong)AppContent *content;

@end