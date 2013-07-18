//
//  Control.m
//  TastingNotes
//
//  Created by Matthew Campbell on 2/3/11.
//  Copyright 2011 App Shop LLC. All rights reserved.
//

#import "Control.h"

@implementation Control

-(id)initWithPrimaryKey:(NSNumber *) primaryKey inThisSection:(Section *)parentSection{
	if ((self = [self init])){
		self.section = parentSection;
		title = nil;
		description = nil;
		type = nil;
		order = nil;
		self.pk = primaryKey;
	}
	return self;
}

#pragma mark Properties

-(NSString *)title {
	if(title == nil){
		title = [[SQLiteDB sharedDatabase]
				 getValueFromThisTable:@"ControlTable" 
				 usingThisSelectStatement:[NSString stringWithFormat:@"SELECT ControlTitle FROM ControlTable WHERE pk = %@", self.pk]];
        if((NSNull *)title == [NSNull null])
            title = nil;
		return title;
	}
	else
		return title;
}

-(void)setTitle:(NSString *)aString {
	if ((!title && !aString) || (title && aString && [title isEqualToString:aString])) return;
	[[SQLiteDB sharedDatabase] updateStringInThisTable:@"ControlTable"
										  inThisColumn:@"ControlTitle"
										 withThisValue:aString
							   usingThisWhereStatement:[NSString stringWithFormat:@"WHERE pk = %@", self.pk]];
	
	title = nil;
	title = aString;
}

-(BOOL)pushesToScreen {
	NSString *tempBool = [[SQLiteDB sharedDatabase]
						  getValueFromThisTable:@"ControlTable" 
						  usingThisSelectStatement:[NSString stringWithFormat:@"SELECT ControlPushesToScreen FROM ControlTable WHERE pk = %@", self.pk]];
	
	if([tempBool isEqualToString:@"YES"])
		return YES;
	else
		return NO;
}

-(void)setPushesToScreen:(BOOL)aBOOL {
	if (pushesToScreen == aBOOL) return;
	
	if(aBOOL == YES)
		[[SQLiteDB sharedDatabase] updateStringInThisTable:@"ControlTable" 
											  inThisColumn:@"ControlPushesToScreen" 
											 withThisValue:@"YES" 
								   usingThisWhereStatement:[NSString stringWithFormat:@"WHERE pk = %@", self.pk]];
	else 
		[[SQLiteDB sharedDatabase] updateStringInThisTable:@"ControlTable" 
											  inThisColumn:@"ControlPushesToScreen" 
											 withThisValue:@"NO" 
								   usingThisWhereStatement:[NSString stringWithFormat:@"WHERE pk = %@", self.pk]];
    pushesToScreen = aBOOL;
}

-(BOOL)allowsMultipleSelections {
	NSString *tempBool = [[SQLiteDB sharedDatabase]
						  getValueFromThisTable:@"ControlTable" 
						  usingThisSelectStatement:[NSString stringWithFormat:@"SELECT AllowsMultipleSelections FROM ControlTable WHERE pk = %@", self.pk]];
	
	if([tempBool isEqualToString:@"YES"])
		return YES;
	else
		return NO;
}

-(void)setAllowsMultipleSelections:(BOOL)aBOOL {
	if (allowsMultipleSelections == aBOOL) return;
	
	if(aBOOL == YES)
		[[SQLiteDB sharedDatabase] updateStringInThisTable:@"ControlTable" 
											  inThisColumn:@"AllowsMultipleSelections" 
											 withThisValue:@"YES" 
								   usingThisWhereStatement:[NSString stringWithFormat:@"WHERE pk = %@", self.pk]];
	else 
		[[SQLiteDB sharedDatabase] updateStringInThisTable:@"ControlTable" 
											  inThisColumn:@"AllowsMultipleSelections" 
											 withThisValue:@"NO" 
								   usingThisWhereStatement:[NSString stringWithFormat:@"WHERE pk = %@", self.pk]];
    allowsMultipleSelections = aBOOL;
}

-(BOOL)canEdit {
	NSString *tempBool = [[SQLiteDB sharedDatabase]
						  getValueFromThisTable:@"ControlTable" 
						  usingThisSelectStatement:[NSString stringWithFormat:@"SELECT CanEdit FROM ControlTable WHERE pk = %@", self.pk]];
	
	if([tempBool isEqualToString:@"YES"])
		return YES;
	else
		return NO;
}

-(void)setCanEdit:(BOOL)aBOOL {
	if (canEdit == aBOOL) return;
	
	if(aBOOL == YES)
		[[SQLiteDB sharedDatabase] updateStringInThisTable:@"ControlTable" 
											  inThisColumn:@"CanEdit" 
											 withThisValue:@"YES" 
								   usingThisWhereStatement:[NSString stringWithFormat:@"WHERE pk = %@", self.pk]];
	else 
		[[SQLiteDB sharedDatabase] updateStringInThisTable:@"ControlTable" 
											  inThisColumn:@"CanEdit" 
											 withThisValue:@"NO" 
								   usingThisWhereStatement:[NSString stringWithFormat:@"WHERE pk = %@", self.pk]];
    canEdit = aBOOL;
}

-(NSString *)description {
	if(description == nil){
		description = [[SQLiteDB sharedDatabase]
					   getValueFromThisTable:@"ControlTable" 
					   usingThisSelectStatement:[NSString stringWithFormat:@"SELECT ControlDescription FROM ControlTable WHERE pk = %@", self.pk]];
        if((NSNull *)description == [NSNull null])
            description = nil;
		return description;
	}
	else
		return description;
}

-(void)setDescription:(NSString *)aString {
	if ((!description && !aString) || (description && aString && [description isEqualToString:aString])) return;
	[[SQLiteDB sharedDatabase] updateStringInThisTable:@"ControlTable"
										  inThisColumn:@"ControlDescription"
										 withThisValue:aString
							   usingThisWhereStatement:[NSString stringWithFormat:@"WHERE pk = %@", self.pk]];
	
	description = nil;
	description = aString;
}

-(NSString *)type {
	if(type == nil){
		type = [[SQLiteDB sharedDatabase]
				getValueFromThisTable:@"ControlTable" 
				usingThisSelectStatement:[NSString stringWithFormat:@"SELECT ControlType FROM ControlTable WHERE pk = %@", self.pk]];
        if((NSNull *)type == [NSNull null])
            type = nil;
		return type;
	}
	else
		return type;
}

-(void)setType:(NSString *)aString {
	if ((!type && !aString) || (type && aString && [type isEqualToString:aString])) return;
	[[SQLiteDB sharedDatabase] updateStringInThisTable:@"ControlTable"
										  inThisColumn:@"ControlType"
										 withThisValue:aString
							   usingThisWhereStatement:[NSString stringWithFormat:@"WHERE pk = %@", self.pk]];
	
	type = nil;
	type = aString;
}

-(NSNumber *)order {
	if(order == nil){
		order  = [[SQLiteDB sharedDatabase]
				  getValueFromThisTable:@"ControlTable" 
				  usingThisSelectStatement:[NSString stringWithFormat:@"SELECT ControlOrder FROM ControlTable WHERE pk = %@", self.pk]];
        if((NSNull *)order == [NSNull null])
            order = nil;
		
		return order;
	}
	else
		return order;
}

-(void)setOrder:(NSNumber *)aNumber {
	if (!order && !aNumber) return;
	[[SQLiteDB sharedDatabase] updateNumberInThisTable:@"ControlTable" 
										  inThisColumn:@"ControlOrder" 
										 withThisValue:aNumber 
							   usingThisWhereStatement:[NSString stringWithFormat:@"WHERE pk = %@", self.pk]];
	
	order = nil;
	order = aNumber;
}

-(NSNumber *)fk_ToSectionTable {
	if(fk_ToSectionTable == nil){
		fk_ToSectionTable  = [[SQLiteDB sharedDatabase]
							  getValueFromThisTable:@"ControlTable" 
							  usingThisSelectStatement:[NSString stringWithFormat:@"SELECT fk_ToSectionTable FROM ControlTable WHERE pk = %@", self.pk]];
        if((NSNull *)fk_ToSectionTable == [NSNull null])
            fk_ToSectionTable = nil;
		
		return fk_ToSectionTable;
	}
	else
		return fk_ToSectionTable;
}

-(void)setFk_ToSectionTable:(NSNumber *)aNumber {
	if (!fk_ToSectionTable && !aNumber) return;
	[[SQLiteDB sharedDatabase] updateNumberInThisTable:@"ControlTable" 
										  inThisColumn:@"fk_ToSectionTable" 
										 withThisValue:aNumber 
							   usingThisWhereStatement:[NSString stringWithFormat:@"WHERE pk = %@", self.pk]];
	
	fk_ToSectionTable = nil;
	fk_ToSectionTable = aNumber;
}

@end
