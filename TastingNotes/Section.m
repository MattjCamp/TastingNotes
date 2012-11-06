//
//  Section.m
//  TastingNotes
//
//  Created by Matthew Campbell on 2/3/11.
//  Copyright 2011 App Shop LLC. All rights reserved.
//

#import "Section.h"

@implementation Section

-(id)initWithPrimaryKey:(NSNumber *) primaryKey{
	if ((self = [self init])){
		name = nil;
		order = nil;
		self.pk = primaryKey;
	}
	return self;
}

#pragma mark Properties

-(void)dealloc{
	name = nil;
	order = nil;
    listOfControls = nil;
}

-(NSString *)name {
	if(name == nil){
		name = [[SQLiteDB sharedDatabase]
				getValueFromThisTable:@"SectionTable" 
				usingThisSelectStatement:[NSString stringWithFormat:@"SELECT SectionName FROM SectionTable WHERE pk = %@", self.pk]];
        if((NSNull *)name == [NSNull null])
            name = nil;
		return name;
	}
	else
		return name;
}

-(void)setName:(NSString *)aString {
	if ((!name && !aString) || (name && aString && [name isEqualToString:aString])) return;
	[[SQLiteDB sharedDatabase] updateStringInThisTable:@"SectionTable"
										  inThisColumn:@"SectionName"
										 withThisValue:aString
							   usingThisWhereStatement:[NSString stringWithFormat:@"WHERE pk = %@", self.pk]];
	
	name = nil;
	name = aString;
}

-(NSNumber *)order {
	if(order == nil){
		order  = [[SQLiteDB sharedDatabase]
				  getValueFromThisTable:@"SectionTable" 
				  usingThisSelectStatement:[NSString stringWithFormat:@"SELECT SectionOrder FROM SectionTable WHERE pk = %@", self.pk]];
        if((NSNull *)order == [NSNull null])
            order = nil;
		
		return order;
	}
	else
		return order;
}

-(void)setOrder:(NSNumber *)aNumber {
	if (!order && !aNumber) return;
	[[SQLiteDB sharedDatabase] updateNumberInThisTable:@"SectionTable" 
										  inThisColumn:@"SectionOrder" 
										 withThisValue:aNumber 
							   usingThisWhereStatement:[NSString stringWithFormat:@"WHERE pk = %@", self.pk]];
	
	order = nil;
	order = aNumber;
}

-(NSMutableArray *) listOfControls{
    if(listOfControls == nil){
        Control *control;
        NSArray *pklist = [[SQLiteDB sharedDatabase] getColumnValuesFromThisTable:@"ControlTable"
                                                         usingThisSelectStatement:[NSString stringWithFormat:@"SELECT pk FROM ControlTable WHERE fk_ToSectionTable = %@ ORDER BY ControlOrder", self.pk]
                                                                   fromThisColumn:0];	
        listOfControls = [[NSMutableArray alloc] init];
        int i = 0;
        for(NSNumber *local_pk in pklist){
            control = [[Control alloc] initWithPrimaryKey:local_pk inThisSection:self];
            if(!control.order)
                control.order = [NSNumber numberWithInt:i];
			if([control.type isEqualToString:@"List"]){
				ListControl *listControl = [[ListControl alloc] initWithPrimaryKey:control.pk inThisSection:self];
				[listOfControls addObject:listControl];
			}
			else{
				[listOfControls addObject:control];
			}
            i++;
        } 
        
        return listOfControls;
    }
    else
        return listOfControls;
}


@end