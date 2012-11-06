//
//  DateEditorCell.m
//  TastingNotes
//
//  Created by Matthew Campbell on 9/21/12.
//
//

#import "DateEditorCell.h"

@implementation DateEditorCell

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    if([self.content.numeric intValue] == 0){
		self.datePicker.date = [NSDate date];
        self.content.numeric = [NSNumber numberWithFloat:[self.datePicker.date timeIntervalSinceReferenceDate]];
    }
	else{
		NSDate *date =[[NSDate alloc] initWithTimeIntervalSinceReferenceDate:[self.content.numeric doubleValue]];
		self.datePicker.date = date;
	}
    self.controlLabel.text = self.content.control.title;
}

- (IBAction)updateDateContent:(id)sender{
    self.content.numeric = [NSNumber numberWithFloat:[self.datePicker.date timeIntervalSinceReferenceDate]];
}

@end