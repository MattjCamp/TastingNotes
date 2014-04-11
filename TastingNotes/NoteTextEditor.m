//
//  NoteTextEditor.m
//  TastingNotes
//
//  Created by Matthew Campbell on 9/19/12.
//
//

#import "NoteTextEditor.h"

@implementation NoteTextEditor
@synthesize noteTextView;
@synthesize noteControlTitle;

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [[self.noteTextView layer] setCornerRadius:8.0f];
    [[self.noteTextView layer] setMasksToBounds:YES];
    if(self.content.text){
        self.noteTextView.text = self.content.text;
        self.isFreshContent = NO;
    }
    else{
        self.noteTextView.text = [NSString stringWithFormat:@"Tap to enter %@ here", [self.content.control.title lowercaseString]];
        self.isFreshContent = YES;
    }
    self.noteControlTitle.text = self.content.control.title;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    if(self.isFreshContent)
        textView.text = nil;
    self.isFreshContent = NO;
    UITableView *tv = (UITableView *)self.superview.superview;
    NSIndexPath *indexPath = [tv indexPathForCell:self];
    [tv scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    self.content.text = textView.text;
    [self.content.note setPlacardInfoToNilWithThisControlPKValue:self.content.control.pk];
}

@end