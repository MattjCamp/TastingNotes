//
//  ControlOverviewEditor.h
//  TastingNotes
//
//  Created by Matthew Campbell on 3/7/11.
//  Copyright 2011 App Shop LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Control.h"
#import "ControlNameEditor.h"
#import "ListControl.h"

@interface ControlOverviewEditor : UITableViewController

@property(nonatomic, strong) Control *control;

@end