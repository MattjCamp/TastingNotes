//
//  ListEditorListItemCell.m
//  TastingNotes
//
//  Created by Matthew Campbell on 9/25/12.
//
//

#import "ListEditorListItemCell.h"

@implementation ListEditorListItemCell

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [[self.checkboxView layer] setCornerRadius:8.0f];
    [[self.checkboxView layer] setMasksToBounds:YES];
    if(self.li.text)
		self.noteTextField.text = self.li.text;
	else
		self.noteTextField.text = [self.li.numeric stringValue];
    
	if(self.content.note){
		if([self.li listItemCheckedInThisNote:self.content.note andThisContent:self.content])
			self.accessoryType = UITableViewCellAccessoryCheckmark;
		else
			self.accessoryType = UITableViewCellAccessoryNone;
	}
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    UITableView *tv = (UITableView *)self.superview;
    NSIndexPath *indexPath = [tv indexPathForCell:self];
    [tv scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    self.li.text = textField.text;
    [textField resignFirstResponder];
    
    return YES;
}

@end
