//
//  NumberEditor.m
//  TastingNotes
//
//  Created by Matthew Campbell on 9/25/12.
//
//

#import "NumberEditor.h"

@implementation NumberEditor

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if(self.content.numeric){
        self.noteTextView.text = [self.content.numeric stringValue];
        self.isFreshContent = NO;
    }
    else{
        self.noteTextView.text = [NSString stringWithFormat:@"Tap to enter %@ here", [self.content.control.title lowercaseString]];
        self.isFreshContent = YES;
    }
    self.noteControlTitle.text = self.content.control.title;
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    double d = [self.noteTextView.text doubleValue];
    self.content.numeric = [NSNumber numberWithDouble:d];
    [self.content.note setPlacardInfoToNilWithThisControlPKValue:self.content.control.pk];
}

@end