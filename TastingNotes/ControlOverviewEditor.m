//
//  ControlOverviewEditor.m
//  TastingNotes
//
//  Created by Matthew Campbell on 3/7/11.
//  Copyright 2011 App Shop LLC. All rights reserved.
//

#import "ControlOverviewEditor.h"

@implementation ControlOverviewEditor

-(void)viewDidLoad{
	self.title = @"Set Up Data Entry Control";
	[super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
	[self.tableView reloadData];
	[super viewWillAppear:animated];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if(section == 0)
		return 1;
	else
		return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
		case 0:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ControlNameCell"];
			cell.textLabel.text = @"Control Name";
			cell.detailTextLabel.text = self.control.title;
            return cell;
		}
		case 1:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ControlTypePickerCell"];
			cell.accessoryType = UITableViewCellAccessoryNone;
            
			switch (indexPath.row) {
				case 0:{
					cell.textLabel.text = @"Single Line Text";
					if([self.control.type isEqualToString:@"SmallText"])
						cell.accessoryType = UITableViewCellAccessoryCheckmark;
				}
					break;
				case 1:{
					cell.textLabel.text = @"Multiple Lines Of Text";
					if([self.control.type isEqualToString:@"MultiText"])
						cell.accessoryType = UITableViewCellAccessoryCheckmark;
				}
					break;
				case 2:{
					cell.textLabel.text = @"Number";
					if([self.control.type isEqualToString:@"Numeric"])
						cell.accessoryType = UITableViewCellAccessoryCheckmark;
				}
					break;
				case 3:{
					cell.textLabel.text = @"Currency";
					if([self.control.type isEqualToString:@"Currency"])
						cell.accessoryType = UITableViewCellAccessoryCheckmark;
				}
					break;
				case 4:{
					cell.textLabel.text = @"Five Star Rating";
					if([self.control.type isEqualToString:@"5StarRating"])
						cell.accessoryType = UITableViewCellAccessoryCheckmark;
				}
					break;
				case 5:{
					cell.textLabel.text = @"100 Point Slider";
					if([self.control.type isEqualToString:@"100PointScale"])
						cell.accessoryType = UITableViewCellAccessoryCheckmark;
				}
					break;
				case 6:{
					cell.textLabel.text = @"List";
					if([self.control.type isEqualToString:@"List"])
						cell.accessoryType = UITableViewCellAccessoryCheckmark;
				}
					break;
				case 7:{
					cell.textLabel.text = @"Picture";
					if([self.control.type isEqualToString:@"Picture"])
						cell.accessoryType = UITableViewCellAccessoryCheckmark;
				}
					break;
				case 8:{
					cell.textLabel.text = @"Web Page Link";
					if([self.control.type isEqualToString:@"WebView"])
						cell.accessoryType = UITableViewCellAccessoryCheckmark;
				}
					break;
				case 9:{
					cell.textLabel.text = @"Date";
					if([self.control.type isEqualToString:@"Date"])
						cell.accessoryType = UITableViewCellAccessoryCheckmark;
				}
					break;
				default:
					break;
			}
            return cell;
		}
		default:
			return nil;
    }
    return nil;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	if(section == 1)
		return @"Pick Data Input Control Type";
	else
        return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 30)];
    l.backgroundColor = [UIColor darkGrayColor];
    l.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    l.textColor = [UIColor lightGrayColor];
    if(section == 1)
		l.text = @"Pick Data Input Control Type";
	else
        l.text = nil;
    
    return l;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	if(!indexPath.section == 0){
		UITableViewCell *tvc = [tableView cellForRowAtIndexPath:indexPath];
		for(UITableViewCell *t in [tableView visibleCells])
			t.accessoryType = UITableViewCellAccessoryNone;
		tvc.accessoryType = UITableViewCellAccessoryCheckmark;
		switch (indexPath.row) {
			case 0:
				self.control.type = @"SmallText";
				break;
			case 1:
				self.control.type = @"MultiText";
				break;
			case 2:
				self.control.type = @"Numeric";
				break;
			case 3:
				self.control.type = @"Currency";
				break;
			case 4:
				self.control.type = @"5StarRating";
				break;
			case 5:
				self.control.type = @"100PointScale";
				break;
			case 6:{
				self.control.type = @"List";
				ListControl *lc = [[ListControl alloc] initWithPrimaryKey:self.control.pk
															inThisSection:self.control.section];
				NSInteger i = [self.control.section.listOfControls indexOfObjectIdenticalTo:self.control];
				[lc.section.listOfControls replaceObjectAtIndex:i
													 withObject:lc];
				
			}
				break;
			case 7:
				self.control.type = @"Picture";
				break;
			case 8:
				self.control.type = @"WebView";
				break;
			case 9:
				self.control.type = @"Date";
				break;
			default:
				break;
		}
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
	}
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"ToControlNameEditor" sender:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ControlNameEditor *detailViewController = [segue destinationViewController];
    detailViewController.control  = self.control;
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:nil
                                                                  action:nil];
    self.navigationItem.backBarButtonItem = backButton;
}

@end