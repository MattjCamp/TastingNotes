//
//  SimpleContentPresenter.m
//  TastingNotes
//
//  Created by Matthew Campbell on 9/21/12.
//
//

#import "SimpleContentPresenter.h"

@implementation SimpleContentPresenter

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    self.contentLabel.text = self.content.toString;
    self.controlLabel.text = self.content.control.title;
}

@end