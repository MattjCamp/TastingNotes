//
//  PlacardContentChooser.m
//  TastingNotes
//
//  Created by Matthew Campbell on 2/21/11.
//  Copyright 2011 App Shop LLC. All rights reserved.
//

#import "PlacardContentChooser.h"

@implementation PlacardContentChooser

- (void)viewDidLoad{
	[super viewDidLoad];

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
	[label setFont:[UIFont boldSystemFontOfSize:16.0]];
    label.textAlignment = NSTextAlignmentCenter;
	[label setBackgroundColor:[UIColor clearColor]];
	[label setTextColor:[UIColor whiteColor]];
	switch (self.inputType) {
		case Title:
			label.text = @"Title";
			break;
		case Detail1:
			label.text = @"Detail 1st Row";
			break;
		case Detail2:
			label.text = @"Detail 2nd Row";
			break;
		case Detail3:
			label.text = @"Detail 3rd Row";
			break;
		case Image:
			label.text = @"Thumbnail Image";
			break;
		default:
			break;
	}
	[self.navigationController.navigationBar.topItem setTitleView:label];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 30)];
    l.backgroundColor = [UIColor darkGrayColor];
    l.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    l.textColor = [UIColor lightGrayColor];
    l.textAlignment = NSTextAlignmentCenter;
    Section *s = [self.notebook.listOfSections objectAtIndex:section];
    l.text = s.name;
    
    return l;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [[self.notebook listOfSections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    Section *s = [self.notebook.listOfSections objectAtIndex:section];
    return [s.listOfControls count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
	}
    
    Section *s = [self.notebook.listOfSections objectAtIndex:indexPath.section];
    Control *control = [s.listOfControls objectAtIndex:indexPath.row];
    
    cell.textLabel.text = control.title;
    cell.detailTextLabel.text = control.type;
	switch (self.inputType) {
		case Title:
			if([self.notebook.noteBadge1Control_fk intValue] == [control.pk intValue])
				cell.accessoryType = UITableViewCellAccessoryCheckmark;
			else
				cell.accessoryType = UITableViewCellAccessoryNone;
			break;
		case Image:
			if([self.notebook.noteImageBadgeControl_fk intValue] == [control.pk intValue])
				cell.accessoryType = UITableViewCellAccessoryCheckmark;
			else
				cell.accessoryType = UITableViewCellAccessoryNone;
			break;
		case Detail1:
			if([self.notebook.noteBadge2Control_fk intValue] == [control.pk intValue])
				cell.accessoryType = UITableViewCellAccessoryCheckmark;
			else
				cell.accessoryType = UITableViewCellAccessoryNone;
			break;		
		case Detail2:
			if([self.notebook.noteBadge3Control_fk intValue] == [control.pk intValue])
				cell.accessoryType = UITableViewCellAccessoryCheckmark;
			else
				cell.accessoryType = UITableViewCellAccessoryNone;
			break;
		case Detail3:
			if([self.notebook.noteBadge4Control_fk intValue] == [control.pk intValue])
				cell.accessoryType = UITableViewCellAccessoryCheckmark;
			else
				cell.accessoryType = UITableViewCellAccessoryNone;
			break;
		default:
			cell.accessoryType = UITableViewCellAccessoryNone;
			break;
	}
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    Section *s = [self.notebook.listOfSections objectAtIndex:section];
    return s.name;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *tvc = [tableView cellForRowAtIndexPath:indexPath];
	if(tvc.accessoryType == UITableViewCellAccessoryCheckmark){
		tvc.accessoryType = UITableViewCellAccessoryNone;
		switch (self.inputType) {
			case Title:
				self.notebook.noteBadge1Control_fk = nil;
				break;
			case Image:
				self.notebook.noteImageBadgeControl_fk = nil;
				break;
			case Detail1:
				self.notebook.noteBadge2Control_fk = nil;
				break;
			case Detail2:
				self.notebook.noteBadge3Control_fk = nil;
				break;
			case Detail3:
				self.notebook.noteBadge4Control_fk = nil;
				break;
			default:
				break;
		}
	}
	else{
		for(UITableViewCell *t in [tableView visibleCells])
			t.accessoryType = UITableViewCellAccessoryNone;
		tvc.accessoryType = UITableViewCellAccessoryCheckmark;
		switch (self.inputType) {
			case Title:{
				Section *s = [self.notebook.listOfSections objectAtIndex:indexPath.section];
				Control *control = [s.listOfControls objectAtIndex:indexPath.row];
				self.notebook.noteBadge1Control_fk = control.pk;
			}
				break;
			case Image:{
				Section *s = [self.notebook.listOfSections objectAtIndex:indexPath.section];
				Control *control = [s.listOfControls objectAtIndex:indexPath.row];
				self.notebook.noteImageBadgeControl_fk = control.pk;
			}
				break;
			case Detail1:{
				Section *s = [self.notebook.listOfSections objectAtIndex:indexPath.section];
				Control *control = [s.listOfControls objectAtIndex:indexPath.row];
				self.notebook.noteBadge2Control_fk = control.pk;
			}
				break;
			case Detail2:{
				Section *s = [self.notebook.listOfSections objectAtIndex:indexPath.section];
				Control *control = [s.listOfControls objectAtIndex:indexPath.row];
				self.notebook.noteBadge3Control_fk = control.pk;
			}
				break;
			case Detail3:{
				Section *s = [self.notebook.listOfSections objectAtIndex:indexPath.section];
				Control *control = [s.listOfControls objectAtIndex:indexPath.row];
				self.notebook.noteBadge4Control_fk = control.pk;
			}
				break;
			default:
				break;
		}
	}
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end