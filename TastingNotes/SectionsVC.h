//
//  SectionsVC.h
//  TastingNotes
//
//  Created by Matthew Campbell on 2/7/11.
//  Copyright 2011 App Shop LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Notebook.h"
#import "Section.h"
#import "SectionNameEditor.h"

@interface SectionsVC : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) Notebook *notebook;
@property(nonatomic, strong) IBOutlet UITableView *tv;

-(IBAction)addSection;

@end
