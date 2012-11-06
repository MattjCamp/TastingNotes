//
//  NotebookView.m
//  TastingNotes
//
//  Created by Matthew Campbell on 9/13/12.
//
//

#import "NotebookView.h"
#import "NoteSummaryTableViewCell.h"
#import "NotebookSelectorView.h"
#import "Analytics.h"

@implementation NotebookView

-(void)viewDidLoad{
    [super viewDidLoad];
    self.addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                   target:self
                                                                   action:@selector(addNewNote)];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.editButtonItem.action = @selector(goToEditMode:);
    self.editButtonItem.target = self;
    
    CGRect bounds = self.tv.bounds;
    bounds.origin.y = bounds.origin.y + self.notesSearchBar.bounds.size.height;
    self.tv.bounds = bounds;
    [[Analytics sharedAnalytics] thisPageWasViewed:@"NotebookView"];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
	[label setFont:[UIFont boldSystemFontOfSize:16.0]];
    label.textAlignment = NSTextAlignmentCenter;
	[label setBackgroundColor:[UIColor clearColor]];
	[label setTextColor:[UIColor whiteColor]];
	[label setText:self.notebook.name];
	[self.navigationController.navigationBar.topItem setTitleView:label];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.notebook = [[AppContent sharedContent] activeNotebook];
    self.title = self.notebook.name;
    self.notesSearchBar.placeholder = [NSString stringWithFormat:@"Search %@", self.notebook.name];
    
    self.currentListOfNotes = [self.notebook listOfNotes];
    [self.tv reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.currentListOfNotes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Note *note = [self.currentListOfNotes objectAtIndex:indexPath.row];
    
    if(note.notebook.noteImageBadgeControl_fk){
        NoteSummaryTableViewCell *cell = (NoteSummaryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"notesummarycell"];
        cell.note = note;
        return cell;
    }
    else{
        NoteSummaryTableViewCell *cell = (NoteSummaryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"notesummarycellnoimage"];
        cell.note = note;
        return cell;
    }
}

- (void)viewDidUnload {
    [self setTv:nil];
    [self setNotesSearchBar:nil];
    [self setShowNotebooksSelectorButton:nil];
    [super viewDidUnload];
}

-(void)goToEditMode:(UIBarButtonItem *)button{
    if(self.tv.editing){
        [self.tv setEditing:NO animated:YES];
        button.title = @"Edit";
        button.style = UIBarButtonItemStylePlain;
		self.navigationItem.leftBarButtonItem = self.showNotebooksSelectorButton;
    }
    else{
        [self.tv setEditing:YES animated:YES];
        button.title = @"Done";
        button.style = UIBarButtonItemStyleDone;
		self.navigationItem.leftBarButtonItem = nil;
		self.navigationItem.leftBarButtonItem = self.addButton;
    }
}

-(IBAction)addNewNote{
	NSIndexPath *ip = [NSIndexPath indexPathForRow:[self.notebook.listOfNotes count]
										 inSection:0];
	[self.notebook addNoteToThisNotebook];
	[self.tv insertRowsAtIndexPaths:[NSArray arrayWithObject:ip]
                   withRowAnimation:UITableViewRowAnimationTop];
    [self.tv scrollToRowAtIndexPath:ip
                   atScrollPosition:UITableViewScrollPositionBottom
                           animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){
		Note *n = [self.currentListOfNotes objectAtIndex:indexPath.row];
		if(self.tv.editing){
			[self.currentListOfNotes removeObject:n];
		}
		[self.notebook removeThisNote:n];
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
	}
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
	[self.notebook moveNoteAtThisIndex:fromIndexPath.row
                           toThisIndex:toIndexPath.row];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
	searchBar.showsCancelButton = YES;
    self.navigationItem.leftBarButtonItem.enabled = NO;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"titleText contains[cd] %@ OR detailText contains[cd] %@", searchBar.text, searchBar.text];
	self.currentListOfNotes = [NSMutableArray arrayWithArray:[self.notebook.listOfNotes filteredArrayUsingPredicate:predicate]];
	[self.tv reloadData];
	self.notesSearchBar.showsCancelButton = NO;
	[searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"titleText contains[cd] %@ OR detailText contains[cd] %@", searchText, searchText];
    
	self.currentListOfNotes = [NSMutableArray arrayWithArray:[self.notebook.listOfNotes filteredArrayUsingPredicate:predicate]];
	[self.tv reloadData];
	if([searchText length] == 0){
		self.currentListOfNotes = self.notebook.listOfNotes;
		[self.tv reloadData];
	}
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar{
	self.currentListOfNotes = self.notebook.listOfNotes;
	[self.tv reloadData];
	self.notesSearchBar.showsCancelButton = NO;
    self.navigationItem.leftBarButtonItem.enabled = YES;
	[searchBar resignFirstResponder];
}

-(void)lockEditingWhileDoingDatabaseRestore{
    NSLog(@"Locking down Notebook View for a database restore");
    [self.tv setEditing:NO animated:YES];
    self.editButtonItem.enabled = NO;
    self.editButtonItem.title = @"Edit";
    self.editButtonItem.style = UIBarButtonItemStylePlain;
    self.navigationItem.leftBarButtonItem = self.showNotebooksSelectorButton;
    
    for(UIViewController *vc in self.childViewControllers){
        if([vc canPerformAction:@selector(lockEditingWhileDoingDatabaseRestore) withSender:nil]){
            NSLog(@"- Locking vc %@", vc.title);
            [vc performSelector:@selector(lockEditingWhileDoingDatabaseRestore)];
        }
    }
}

-(void)unlockEditingAfterDoingDatabaseRestore{
    NSLog(@"Unlocking Notebook View for after a database restore");
    
    [UIView animateWithDuration:1.0 animations:^{
        self.tv.alpha = 0.0;
    }];
    
    for(UIViewController *vc in self.childViewControllers){
        if([vc canPerformAction:@selector(unlockEditingAfterDoingDatabaseRestore) withSender:nil]){
            NSLog(@"- Locking vc %@", vc.title);
            [vc performSelector:@selector(unlockEditingAfterDoingDatabaseRestore)];
        }
    }
    
    self.currentListOfNotes = nil;
    self.notebook = [[AppContent sharedContent] activeNotebook];
    self.currentListOfNotes = [self.notebook listOfNotes];
    self.title = self.notebook.name;
    self.navigationItem.leftBarButtonItem = self.showNotebooksSelectorButton;
    self.editButtonItem.enabled = YES;
    self.notesSearchBar.placeholder = [NSString stringWithFormat:@"Search %@", self.notebook.name];
    [self.tv reloadData];
    [UIView animateWithDuration:1.0 animations:^{
        self.tv.alpha = 1.0;
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"NotebookToNote"]||[[segue identifier] isEqualToString:@"NotebookToNote2"]) {
        NSIndexPath *indexPath = [self.tv indexPathForSelectedRow];
        Note *note = [self.currentListOfNotes objectAtIndex:indexPath.row];
        [[segue destinationViewController] setNote:note];
        NoteSummaryTableViewCell *customCell =(NoteSummaryTableViewCell *) [self.tv cellForRowAtIndexPath:indexPath];
        [customCell setNeedsDisplay];
    }
    if ([[segue identifier] isEqualToString:@"ToNotebookSelector"]) {
        UINavigationController *nc = [segue destinationViewController];
        NotebookSelectorView *dvc = (NotebookSelectorView *)[[nc viewControllers] lastObject];
        [dvc addUpdateBlock:^{
            [UIView animateWithDuration:.5 animations:^{
                self.notebook = [[AppContent sharedContent] activeNotebook];
                self.currentListOfNotes = [self.notebook listOfNotes];
                self.title = self.notebook.name;
                self.notesSearchBar.placeholder = [NSString stringWithFormat:@"Search %@", self.notebook.name];
                [self.tv reloadData];
            }];
        }];
    }
}

@end