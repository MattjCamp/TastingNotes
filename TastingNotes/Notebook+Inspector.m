//
//  Notebook+Inspector.m
//  TastingNotes
//
//  Created by Matt on 4/14/14.
//  Copyright (c) 2014 Mobile App Mastery. All rights reserved.
//

#import "Notebook+Inspector.h"

@implementation Notebook (Inspector)

-(void)logStateToThisString:(NSMutableString *)log{
    [log appendFormat:@"self = %@\n", self];
    [log appendFormat:@"name = %@\n", self.name];
    
    [self.listOfNotes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Note *n = (Note *)obj;
        [log appendFormat:@"   %@\n", n.titleText];
    }];
    
}

@end
