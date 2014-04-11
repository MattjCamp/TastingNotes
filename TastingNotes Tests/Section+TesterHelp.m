//
//  Section+TesterHelp.m
//  TastingNotes
//
//  Created by Matt on 4/10/14.
//  Copyright (c) 2014 Mobile App Mastery. All rights reserved.
//

#import "Section+TesterHelp.h"

@implementation Section (TesterHelp)

-(void)logStateToThisString:(NSMutableString *)log{
    [log appendFormat:@"self = %@\n", self];
    [log appendFormat:@"name = %@\n", self.name];
}

@end