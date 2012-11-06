//
//  ContentTableViewCell.m
//  TastingNotes
//
//  Created by Matthew Campbell on 9/20/12.
//
//

#import "ContentTableViewCell.h"

@implementation ContentTableViewCell

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    self.isFreshContent = NO;
}

@end
