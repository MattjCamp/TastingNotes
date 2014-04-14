//
//  ListEditorFullScreen.m
//  TastingNotes
//
//  Created by Matthew Campbell on 9/25/12.
//
//

#import "ListEditorFullScreen.h"
#import "ListEditorListItemCell.h"

@implementation ListEditorFullScreen

-(void)viewDidLoad{
    [super viewDidLoad];
    self.listItemsToToggle = [[NSMutableArray alloc] init];
    self.listControl = (ListControl *)self.content.control;
}

-(IBAction)doneButtonAction:(id)sender {
    for(ListItem *li in self.listItemsToToggle)
		[li ToogleListItemStatusInThisNote:self.content.note andThisContent:self.content];
	[self.content.note setPlacardInfoToNilWithThisControlPKValue:self.listControl.pk];
    _updateBlock();
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)addButtonAction:(id)sender {
    [self.listControl addListItemToThisListControl];
	NSIndexPath *lastRowInLastSection = [NSIndexPath indexPathForRow:self.listControl.listItems.count-1
														   inSection:0];
	[self.tv insertRowsAtIndexPaths:[NSArray arrayWithObject:lastRowInLastSection]
                   withRowAnimation:UITableViewRowAnimationBottom];
	[self.tv scrollToRowAtIndexPath:lastRowInLastSection
                   atScrollPosition:UITableViewScrollPositionMiddle
                           animated:YES];
    
    ListEditorListItemCell *listCell =(ListEditorListItemCell *) [self.tv cellForRowAtIndexPath:lastRowInLastSection];
    [listCell.noteTextField becomeFirstResponder];
}

-(IBAction)editButtonAction:(id)sender {
    [self toogleEditMode:sender];
}

-(IBAction)doneEditingButtonAction:(id)sender {
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.listControl.listItems count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row >= self.listControl.listItems.count){
        UITableViewCell *spacerCell = [tableView dequeueReusableCellWithIdentifier:@"SpacerCell"];
        return spacerCell;
    }
    else{
        ListEditorListItemCell *cell = (ListEditorListItemCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
        cell.li = [self.listControl.listItems objectAtIndex:indexPath.row];
        cell.content = self.content;
        [cell setNeedsDisplay];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row >= self.listControl.listItems.count)
        return 180;
    else
        return 45;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if(indexPath.row < self.listControl.listItems.count){
        if(!self.isEditingListControl){
            ListItem *li = [self.listControl.listItems objectAtIndex:indexPath.row];
            [self.listItemsToToggle addObject:li];
            UITableViewCell *tc = [tableView cellForRowAtIndexPath:indexPath];
            if(tc.accessoryType == UITableViewCellAccessoryCheckmark)
                tc.accessoryType = UITableViewCellAccessoryNone;
            else
                tc.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)toogleEditMode:(UIBarButtonItem *)button{
    if(self.isEditingListControl){
		[self.tv setEditing:NO animated:YES];
        self.editButton.title = @"Edit";
        self.editButton.style = UIBarButtonItemStyleBordered;
		self.isEditingListControl = NO;
		for(NSIndexPath *ip in [self.tv indexPathsForVisibleRows]){
			ListItem *li = [self.listControl.listItems objectAtIndex:ip.row];
			UITableViewCell *t = [self.tv cellForRowAtIndexPath:ip];
			if(self.content.note){
				if([li listItemCheckedInThisNote:self.content.note andThisContent:self.content])
					t.accessoryType = UITableViewCellAccessoryCheckmark;
				else
					t.accessoryType = UITableViewCellAccessoryNone;
			}
		}
		[self.listItemsToToggle removeAllObjects];
    }
    else{
		[self.tv setEditing:YES animated:YES];
        self.editButton.title = @"Done";
        self.editButton.style = UIBarButtonItemStyleDone;
		self.isEditingListControl = YES;
    }
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		ListItem *li = [self.listControl.listItems objectAtIndex:indexPath.row];
		[self.listControl removeThisListItem:li];
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
	}
}

@end