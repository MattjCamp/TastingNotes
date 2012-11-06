//
//  ControlsVC.h
//  TastingNotes
//
//  Created by Matthew Campbell on 2/6/11.
//  Copyright 2011 App Shop LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Notebook.h"
#import "Section.h"
#import "ControlOverviewEditor.h"

@interface ControlsVC : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) Notebook *notebook;
@property(nonatomic, strong) IBOutlet UITableView *tv;

-(IBAction)addControl;
-(IBAction)showHelp;

@end