//
//  NotebookSelectorView.m
//  TastingNotes
//
//  Created by Matthew Campbell on 9/13/12.
//
//

#import "NotebookSelectorView.h"
#import "NotebookView.h"
#import "Analytics.h"

@implementation NotebookSelectorView
Notebook *tempNotebook = nil;

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tv reloadData];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
	[label setFont:[UIFont boldSystemFontOfSize:16.0]];
    label.textAlignment = NSTextAlignmentCenter;
	[label setBackgroundColor:[UIColor clearColor]];
	[label setTextColor:[UIColor whiteColor]];
	[label setText:@"Select Notebook"];
	[self.navigationController.navigationBar.topItem setTitleView:label];
}

-(void)addUpdateBlock:(void (^)())updateBlock{
    _updateBlock = updateBlock;
}

-(IBAction)cancelButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)editButtonAction:(id)sender {
    [self.tv setEditing:YES animated:YES];
    self.navigationItem.rightBarButtonItem = self.doneButton;
}

-(IBAction)addButtonAction:(id)sender {
    [self.content.notebooks addNewNotebookWithThisName:@"Notebook"];
    tempNotebook = [self.content.notebooks.listOfNotebooks lastObject];
    [self performSegueWithIdentifier:@"tonotebookeditor" sender:nil];
}

- (IBAction)doneButtonAction:(id)sender {
    [self.tv setEditing:NO animated:YES];
    self.navigationItem.rightBarButtonItem = self.editButton;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    tempNotebook = [self.content.notebooks.listOfNotebooks objectAtIndex:indexPath.row];
    [[self.tv cellForRowAtIndexPath:indexPath] setNeedsDisplay];
    [self performSegueWithIdentifier:@"tonotebookeditor" sender:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"tonotebookeditor"]) {
        [[segue destinationViewController] setNotebook:tempNotebook];
    }
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.content = [AppContent sharedContent];
    [[Analytics sharedAnalytics] thisPageWasViewed:NSStringFromClass([self class])];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.content.notebooks.listOfNotebooks count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"notebookpickertvc"];
    
    Notebook *notebook = [self.content.notebooks.listOfNotebooks objectAtIndex:indexPath.row];
    
    cell.textLabel.text = notebook.name;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.content.activeNotebook = [self.content.notebooks.listOfNotebooks objectAtIndex:indexPath.row];
    _updateBlock();
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    Notebook *notebook = [self.content.notebooks.listOfNotebooks objectAtIndex:indexPath.row];
    [self.content.notebooks removeThisNotebook:notebook];
    [self.tv deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

-(void)lockEditingWhileDoingDatabaseRestore{
    [self.tv setEditing:NO animated:YES];
    [self.navigationController popToRootViewControllerAnimated:NO];
}

-(void)unlockEditingAfterDoingDatabaseRestore{    
    [UIView animateWithDuration:1.0 animations:^{
        self.tv.alpha = 0.0;
    }];
    self.editButtonItem.enabled = YES;
    [self.tv reloadData];
    [UIView animateWithDuration:1.0 animations:^{
        self.tv.alpha = 1.0;
    }];
}

@end