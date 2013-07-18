//
//  ContentFullScreen.m
//  TastingNotes
//
//  Created by Matthew Campbell on 9/20/12.
//
//

#import "ContentFullScreen.h"

@implementation ContentFullScreen

-(void)addUpdateBlock:(void (^)())updateBlock{
    _updateBlock = updateBlock;
}

@end
