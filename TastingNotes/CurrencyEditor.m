//
//  CurrencyEditor.m
//  TastingNotes
//
//  Created by Matthew Campbell on 9/25/12.
//
//

#import "CurrencyEditor.h"

@implementation CurrencyEditor

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if(self.content.numeric){
        self.noteTextView.text = self.content.toString;
        self.isFreshContent = NO;
    }
    else{
        self.noteTextView.text = [NSString stringWithFormat:@"Tap to enter %@ here", [self.content.control.title lowercaseString]];
        self.isFreshContent = YES;
    }
    self.noteControlTitle.text = self.content.control.title;
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    NSNumberFormatter *numfor = [[NSNumberFormatter alloc] init];
    [numfor setNumberStyle:NSNumberFormatterCurrencyStyle];
    self.content.numeric = [numfor numberFromString:self.noteTextView.text];
    [self.content.note setPlacardInfoToNilWithThisControlPKValue:self.content.control.pk];
}

@end