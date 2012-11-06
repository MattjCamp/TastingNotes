//
//  NoteAdder.h
//  TastingNotes
//
//  Created by Matthew Campbell on 9/28/12.
//
//

#import <Foundation/Foundation.h>
#import "AppContent.h"

@interface NoteAdder : UIViewController<UITableViewDataSource, UITableViewDelegate, UIWebViewDelegate>

@property(nonatomic, strong) Note *note;
@property (weak, nonatomic) IBOutlet UITableView *tv;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *addButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UIView *vc;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIButton *tapToAddButton;

- (IBAction)doneButtonAction:(id)sender;
- (IBAction)addButtonAction:(id)sender;
- (IBAction)socialButtonAction:(id)sender;

@end