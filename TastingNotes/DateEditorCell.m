//
//  DateEditorCell.m
//  TastingNotes
//
//  Created by Matthew Campbell on 9/21/12.
//
//

#import "DateEditorCell.h"

@implementation DateEditorCell

-(void)displayDate{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateStyle = NSDateFormatterLongStyle;
    NSDate *date;
    
    if([self.content.numeric intValue] == 0){
        date = [NSDate date];
        self.content.numeric = [NSNumber numberWithFloat:[date timeIntervalSinceReferenceDate]];
    }
	else
		date =[[NSDate alloc] initWithTimeIntervalSinceReferenceDate:[self.content.numeric doubleValue]];
    
    self.dataDisplay.text = [df stringFromDate:date];
    self.controlLabel.text = self.content.control.title;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    [[self.dataDisplay layer] setCornerRadius:8.0f];
    [[self.dataDisplay layer] setMasksToBounds:YES];
    
    [self displayDate];
}

- (void)updateDateContent:(id)sender{
    UIDatePicker *dp = (UIDatePicker *)sender;
    self.content.numeric = [NSNumber numberWithFloat:[dp.date timeIntervalSinceReferenceDate]];
    [self displayDate];
    
    [UIView beginAnimations:@"slideOut" context:nil];
    [dp setCenter:CGPointMake(dp.center.x, dp.center.y + dp.frame.size.height)];
    [UIView commitAnimations];
}

@end