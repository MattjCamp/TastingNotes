//
//  HundredPointRatingsEditor.m
//  TastingNotes
//
//  Created by Matthew Campbell on 9/20/12.
//
//

#import "HundredPointRatingsEditor.h"

@implementation HundredPointRatingsEditor

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [self updateUI];
}

- (IBAction)ratingSliderAction:(id)sender {
	self.content.numeric = [NSNumber numberWithInt:(int)(roundf(self.ratingSlider.value))];
	[self.content.note setPlacardInfoToNilWithThisControlPKValue:self.content.control.pk];
    self.contentLabel.text = [self.content.numeric stringValue];
}

-(void)updateUI{
    self.ratingSlider.value = 0;
    self.contentLabel.text = nil;
    self.controlLabel.text = nil;
    
    if(self.content.numeric)
        self.ratingSlider.value = [self.content.numeric doubleValue];
    if(self.content.numeric)
        self.contentLabel.text = [self.content.numeric stringValue];
    else
        self.contentLabel.text = nil;
    self.controlLabel.text = self.content.control.title;
}

@end