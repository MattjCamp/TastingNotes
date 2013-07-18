//
//  PlacardContentRowChooser.m
//  TastingNotes
//
//  Created by Matthew Campbell on 2/21/11.
//  Copyright 2011 App Shop LLC. All rights reserved.
//

#import "PlacardTopLevelEditor.h"
#import "PlacardNoteSummaryView.h"
#import "PlacardContentChooser.h"

@implementation PlacardTopLevelEditor

- (void)viewDidLoad {
	[super viewDidLoad];
	[self.notebook setAllNotesPlacardInfoToNil];
	self.title = @"Select Placard Content";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 3)
        return 3;
    else
        return 1;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
    [super viewWillAppear:animated];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	if(section == 0)
		return @"Example Note Placard";
	else return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:{
            if(self.notebook.noteImageBadgeControl_fk){
                PlacardNoteSummaryView *cell = (PlacardNoteSummaryView *)[tableView dequeueReusableCellWithIdentifier:@"demonotesummarycell"];
                [cell setNotebook:self.notebook];
                return cell;
            }
            else{
                PlacardNoteSummaryView *cell = (PlacardNoteSummaryView *)[tableView dequeueReusableCellWithIdentifier:@"demonotesummarycell2"];
                [cell setNotebook:self.notebook];
                return cell;
            }
        }
        case 1:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
            cell.textLabel.text = @"Title";
            cell.detailTextLabel.text = [[self.notebook placardDetail1Control] title];
            return cell;
        }
        case 2:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
            cell.textLabel.text = @"Thumbnail";
            cell.detailTextLabel.text = [[self.notebook placardImageThumbnailControl] title];
            return cell;
        }
        case 3:{
            switch (indexPath.row) {
                case 0:{
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
                    cell.textLabel.text = @"Detail 1st row";
                    cell.detailTextLabel.text = [[self.notebook placardDetail1Control] title];
                    return cell;
                }
                case 1:{
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
                    cell.textLabel.text = @"Detail 2nd row";
                    cell.detailTextLabel.text = [[self.notebook placardDetail2Control] title];
                    return cell;
                }
                case 2:{
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
                    cell.textLabel.text = @"Detail 3rd row";
                    cell.detailTextLabel.text = [[self.notebook placardDetail3Control] title];
                    return cell;
                }
                default:
                    break;
            }
        }
        default:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
            return cell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	if(indexPath.section == 0)
		return 75.0;
	else
		return 45.0;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"ToPlacardDetailEditor"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        [[segue destinationViewController] setNotebook:self.notebook];
        switch (indexPath.section) {
            case 1:
                [[segue destinationViewController] setInputType:Title];
                break;
            case 2:
                [[segue destinationViewController] setInputType:Image];
                break;
            case 3:{
                switch (indexPath.row) {
                    case 0:
                        [[segue destinationViewController] setInputType:Detail1];
                        break;
                    case 1:
                        [[segue destinationViewController] setInputType:Detail2];
                        break;
                    case 2:
                        [[segue destinationViewController] setInputType:Detail3];
                        break;
                    default:
                        break;
                }
            }
            default:
                break;
        }
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
	[self performSegueWithIdentifier:@"ToPlacardDetailEditor" sender:nil];
}

@end