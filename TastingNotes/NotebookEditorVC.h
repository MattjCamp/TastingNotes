//
//  NotebookEditorVC.h
//  TastingNotes
//
//  Created by Matthew Campbell on 2/5/11.
//  Copyright 2011 App Shop LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Notebook.h"

@interface NotebookEditorVC : UITableViewController

@property(nonatomic, strong) Notebook *notebook;

@end