//
//  NotebookEditorVC.m
//  TastingNotes
//
//  Created by Matthew Campbell on 2/5/11.
//  Copyright 2011 App Shop LLC. All rights reserved.
//

#import "NotebookEditorVC.h"

@implementation NotebookEditorVC

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

-(void)viewDidLoad{
    [super viewDidLoad];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0)
        return 1;
    else
        return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0)
        return 70;
    else
        switch (indexPath.row) {
            case 0:
                return 50;
                break;
            case 1:
                return 70;
                break;
			case 2:
                return 70;
                break;
            default:
                return 50;
                break;
        }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell;
    if(indexPath.section == 0){
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        cell.textLabel.text = @"Notebook Schema Editor";
        cell.detailTextLabel.text = @"Here is where you can customize your notebook";
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.detailTextLabel.numberOfLines = 0;
    }
    else{
        switch (indexPath.row) {
            case 0:
                cell = [tableView dequeueReusableCellWithIdentifier:@"notebooknamecell"];
                cell.textLabel.text = self.notebook.name;
                cell.detailTextLabel.text = @"Touch to edit your notebook name";
                break;
            case 1:
                cell = [tableView dequeueReusableCellWithIdentifier:@"sectioneditorcell"];
                cell.textLabel.text = @"Edit Data Entry Controls";
                cell.detailTextLabel.text = @"Touch to edit the controls you can use to put in information to your notebook";
                break;
			case 2:
                cell = [tableView dequeueReusableCellWithIdentifier:@"placardeditorcell"];
                cell.textLabel.text = @"Select Placard Content";
                cell.detailTextLabel.text = @"Touch to edit what content appears in lists and search results";
                break;
            default:
                break;
        }
    }
	return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [[segue destinationViewController] setNotebook:self.notebook];
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section != 0){
        switch (indexPath.row) {
            case 0:
                [self performSegueWithIdentifier:@"ToNotebookNameEditor" sender:nil];
                break;
            case 1:
                [self performSegueWithIdentifier:@"ToNotebookControlEditor" sender:nil];
                break;
            case 2:
                [self performSegueWithIdentifier:@"ToPlacardEditor" sender:nil];
                break;
            default:
                break;
        }
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
    [super viewWillAppear:animated];
}

@end