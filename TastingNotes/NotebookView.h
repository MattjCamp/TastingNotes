//
//  NotebookView.h
//  TastingNotes
//
//  Created by Matthew Campbell on 9/13/12.
//
//

#import <Foundation/Foundation.h>
#import "AppContent.h"

@interface NotebookView : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property(strong) Notebook *notebook;
@property(nonatomic, strong) NSMutableArray *currentListOfNotes;
@property (weak, nonatomic) IBOutlet UITableView *tv;
@property (weak, nonatomic) IBOutlet UISearchBar *notesSearchBar;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *showNotebooksSelectorButton;
@property (strong, nonatomic) UIBarButtonItem *addButton;

@end