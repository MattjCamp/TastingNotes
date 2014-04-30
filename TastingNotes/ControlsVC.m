//
//  ControlsVC.m
//  TastingNotes
//
//  Created by Matthew Campbell on 2/6/11.
//  Copyright 2011 App Shop LLC. All rights reserved.
//

#import "ControlsVC.h"

@implementation ControlsVC
UIBarButtonItem *backButton;

-(void)viewDidLoad {
	[super viewDidLoad];
	self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.editButtonItem.action = @selector(goToEditMode:);
    self.editButtonItem.target = self;
    self.title = @"Input Controls";
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 30)];
    l.backgroundColor = [UIColor darkGrayColor];
    l.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    l.textColor = [UIColor lightGrayColor];
    l.textAlignment = NSTextAlignmentCenter;
    Section *s = [self.notebook.listOfSections objectAtIndex:section];
    l.text = [NSString stringWithFormat:@"%@", s.name];
    
    return l;
}

-(void)goToEditMode:(UIBarButtonItem *)button{
    if(self.tv.editing){
        [self.tv setEditing:NO animated:YES];
        button.title = @"Edit";
        button.style = UIBarButtonItemStylePlain;
		self.navigationItem.leftBarButtonItem = backButton;
		backButton = nil;
    }
    else{
        [self.tv setEditing:YES animated:YES];
        button.title = @"Done";
        button.style = UIBarButtonItemStyleDone;
		backButton = self.navigationItem.leftBarButtonItem;
		self.navigationItem.leftBarButtonItem = nil;
		UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
																				   target:self
																				   action:@selector(addControl)];
		self.navigationItem.leftBarButtonItem = addButton;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tv reloadData];
    [super viewWillAppear:animated];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [[self.notebook listOfSections] count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    Section *s = [self.notebook.listOfSections objectAtIndex:section];
    return [s.listOfControls count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    Section *s = [self.notebook.listOfSections objectAtIndex:indexPath.section];
    Control *control = [s.listOfControls objectAtIndex:indexPath.row];
    cell.textLabel.text = control.title;
    cell.detailTextLabel.text = control.type;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    [self.notebook moveControlAtThisIndex:fromIndexPath.row
                       atThisSectionIndex:fromIndexPath.section
                       toThisSectionIndex:toIndexPath.section
                      andThisControlIndex:toIndexPath.row];
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    Section *s = [self.notebook.listOfSections objectAtIndex:section];
    return s.name;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"ToControlOverviewEditor" sender:nil];
}

-(IBAction)addControl{
	if([self.notebook.listOfSections count] == 0){
		[self.notebook addControlToThisNotebook];
		NSIndexSet *slist = [NSIndexSet indexSetWithIndex:0];
		[self.tv insertSections:slist withRowAnimation:UITableViewRowAnimationTop];
	}
	else{
		[self.notebook addControlToThisNotebook];
		Section *section = [self.notebook.listOfSections lastObject];
		NSIndexPath *lastRowInLastSection = [NSIndexPath indexPathForRow:[section.listOfControls count] - 1
															   inSection:[self.notebook.listOfSections count] - 1];
		[self.tv insertRowsAtIndexPaths:[NSArray arrayWithObject:lastRowInLastSection]
				  withRowAnimation:UITableViewRowAnimationTop];
		[self.tv scrollToRowAtIndexPath:lastRowInLastSection
				  atScrollPosition:UITableViewScrollPositionMiddle
						  animated:YES];
		
	}
    
    Control *c = [[self.notebook listOfControls] lastObject];
    if(!c.type)
        c.type = @"SmallText";
}

-(IBAction)showHelp{
	UIAlertView *helpAlert = [[UIAlertView alloc] initWithTitle:@"Input Control Editor Help"
														message:@"This is how to customize your notebook.\nUse this form to add, remove and reorder controls by touching the Edit button.\n Touch the blue arrows to change the names and types of input controls.\nYou may also add and edit sections (groupings for controls) by pressing the sections button"
													   delegate:self
											  cancelButtonTitle:@"Got It"
											  otherButtonTitles:nil];
	[helpAlert show];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		Section *s = [self.notebook.listOfSections objectAtIndex:indexPath.section];
		Control *control = [s.listOfControls objectAtIndex:indexPath.row];
		[self.notebook removeThisControl:control fromThisSection:s];
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
	}
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if (![[segue identifier] isEqualToString:@"ToSectionsEditor"]) {
        NSIndexPath *indexPath = [self.tv indexPathForSelectedRow];
        Section *s = [self.notebook.listOfSections objectAtIndex:indexPath.section];
        Control *control = [s.listOfControls objectAtIndex:indexPath.row];
        [[segue destinationViewController] setControl:control];
    }
    else
        [[segue destinationViewController] setNotebook:self.notebook];
}

@end