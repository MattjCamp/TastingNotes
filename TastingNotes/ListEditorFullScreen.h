//
//  ListEditorFullScreen.h
//  TastingNotes
//
//  Created by Matthew Campbell on 9/25/12.
//
//

#import "ContentFullScreen.h"

@interface ListEditorFullScreen : ContentFullScreen<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property(nonatomic, strong) ListControl *listControl;
@property(nonatomic, assign) BOOL isEditingListControl;
@property(nonatomic, strong) NSMutableArray *listItemsToToggle;
@property (weak, nonatomic) IBOutlet UITableView *tv;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

- (IBAction)doneButtonAction:(id)sender;
- (IBAction)addButtonAction:(id)sender;
- (IBAction)editButtonAction:(id)sender;
- (IBAction)doneEditingButtonAction:(id)sender;


@end