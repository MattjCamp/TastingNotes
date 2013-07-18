//
//  SectionsVC.m
//  TastingNotes
//
//  Created by Matthew Campbell on 2/7/11.
//  Copyright 2011 App Shop LLC. All rights reserved.
//

#import "SectionsVC.h"

@implementation SectionsVC
UIBarButtonItem *backButton;

- (void)viewDidLoad {
	[super viewDidLoad];
	self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.editButtonItem.action = @selector(goToEditMode:);
    self.editButtonItem.target = self;
    self.title = @"Sections";
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
																				   action:@selector(addSection)];
		self.navigationItem.leftBarButtonItem = addButton;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [self.tv reloadData];
    [super viewWillAppear:animated];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.notebook listOfSections] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    Section *s = [self.notebook.listOfSections objectAtIndex:indexPath.row];
    cell.textLabel.text = s.name;
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    [self.notebook moveSectionAtThisIndex:fromIndexPath.row toThisIndex:toIndexPath.row];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"ToSectionNameEditor" sender:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"ToSectionNameEditor"]) {
        NSIndexPath *indexPath = [self.tv indexPathForSelectedRow];
        Section *s = [self.notebook.listOfSections objectAtIndex:indexPath.row];
        [[segue destinationViewController] setSection:s];
    }
}

-(IBAction)addSection{
	[self.notebook addSectionToThisNotebook];
	NSIndexPath *lastRowInLastSection = [NSIndexPath indexPathForRow:[self.notebook.listOfSections count] - 1
														   inSection:0];
	[self.tv insertRowsAtIndexPaths:[NSArray arrayWithObject:lastRowInLastSection]
			  withRowAnimation:UITableViewRowAnimationTop];
	[self.tv scrollToRowAtIndexPath:lastRowInLastSection 
			  atScrollPosition:UITableViewScrollPositionMiddle 
					  animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		[self.notebook removeThisSection:[self.notebook.listOfSections objectAtIndex:indexPath.row]];
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
	}
}

@end