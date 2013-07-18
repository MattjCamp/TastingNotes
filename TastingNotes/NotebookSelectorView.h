//
//  NotebookSelectorView.h
//  TastingNotes
//
//  Created by Matthew Campbell on 9/13/12.
//
//

#import <Foundation/Foundation.h>
#import "AppContent.h"

@interface NotebookSelectorView : UIViewController<UITableViewDataSource, UITableViewDelegate>{
@public
    void (^_updateBlock)();
}

@property(assign) AppContent *content;
@property (weak, nonatomic) IBOutlet UITableView *tv;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *editButton;

-(void)addUpdateBlock:(void (^)())updateBlock;
- (IBAction)cancelButtonAction:(id)sender;
- (IBAction)editButtonAction:(id)sender;
- (IBAction)addButtonAction:(id)sender;
- (IBAction)doneButtonAction:(id)sender;

@end