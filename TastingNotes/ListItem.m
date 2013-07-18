//
//  ListItem.m
//  TastingNotes
//
//  Created by Matthew Campbell on 3/10/11.
//  Copyright 2011 App Shop LLC. All rights reserved.
//

#import "ListItem.h"

@implementation ListItem

-(void)dealloc{
	text = nil;
	numeric = nil;
	fk_ToControlTable = nil;
}

-(id)initWithPrimaryKey:(NSNumber *) primaryKey{
	if ((self = [self init])){
		text = nil;
		numeric = nil;
		order = nil;
		fk_ToControlTable = nil;
		self.pk = primaryKey;
	}
	return self;
}

-(NSNumber *)fk_ToControlTable {
	if(fk_ToControlTable == nil){
		fk_ToControlTable  = [[SQLiteDB sharedDatabase]
							  getValueFromThisTable:@"TagValues" 
							  usingThisSelectStatement:[NSString stringWithFormat:@"SELECT fk_ToControlTable FROM TagValues WHERE pk = %@", self.pk]];
        if((NSNull *)fk_ToControlTable == [NSNull null])
            fk_ToControlTable = nil;
		
		return fk_ToControlTable;
	}
	else
		return fk_ToControlTable;
}

-(void)setFk_ToControlTable:(NSNumber *)aNumber {
	if (!fk_ToControlTable && !aNumber) return;
	[[SQLiteDB sharedDatabase] updateNumberInThisTable:@"TagValues" 
										  inThisColumn:@"fk_ToControlTable" 
										 withThisValue:aNumber 
							   usingThisWhereStatement:[NSString stringWithFormat:@"WHERE pk = %@", self.pk]];
	
	fk_ToControlTable = nil;
	fk_ToControlTable = aNumber;
}

-(NSString *)text {
	if(text == nil){
		text = [[SQLiteDB sharedDatabase]
				getValueFromThisTable:@"TagValues" 
				usingThisSelectStatement:[NSString stringWithFormat:@"SELECT TagValueText FROM TagValues WHERE pk = %@", self.pk]];
        if((NSNull *)text == [NSNull null])
            text = nil;
		return text;
	}
	else
		return text;
}

-(void)setText:(NSString *)aString {
	if ((!text && !aString) || (text && aString && [text isEqualToString:aString])) return;
	[[SQLiteDB sharedDatabase] updateStringInThisTable:@"TagValues"
										  inThisColumn:@"TagValueText"
										 withThisValue:aString
							   usingThisWhereStatement:[NSString stringWithFormat:@"WHERE pk = %@", self.pk]];
	
	text = nil;
	text = aString;
}

-(NSNumber *)numeric {
	if(numeric == nil){
		numeric  = [[SQLiteDB sharedDatabase]
					getValueFromThisTable:@"TagValues" 
					usingThisSelectStatement:[NSString stringWithFormat:@"SELECT TagValueNum FROM TagValues WHERE pk = %@", self.pk]];
        if((NSNull *)numeric == [NSNull null])
            numeric = nil;
		
		return numeric;
	}
	else
		return numeric;
}

-(void)setNumeric:(NSNumber *)aNumber {
	if (!numeric && !aNumber) return;
	[[SQLiteDB sharedDatabase] updateNumberInThisTable:@"TagValues" 
										  inThisColumn:@"TagValueNum" 
										 withThisValue:aNumber 
							   usingThisWhereStatement:[NSString stringWithFormat:@"WHERE pk = %@", self.pk]];
	
	numeric = nil;
	numeric = aNumber;
}

-(NSNumber *)order {
	if(order == nil){
		order  = [[SQLiteDB sharedDatabase]
				  getValueFromThisTable:@"TagValues" 
				  usingThisSelectStatement:[NSString stringWithFormat:@"SELECT TagValueOrder FROM TagValues WHERE pk = %@", self.pk]];
        if((NSNull *)order == [NSNull null])
            order = nil;
		
		return order;
	}
	else
		return order;
}

-(void)setOrder:(NSNumber *)aNumber {
	if (!order && !aNumber) return;
	[[SQLiteDB sharedDatabase] updateNumberInThisTable:@"TagValues" 
										  inThisColumn:@"TagValueOrder" 
										 withThisValue:aNumber 
							   usingThisWhereStatement:[NSString stringWithFormat:@"WHERE pk = %@", self.pk]];
	
	order = nil;
	order = aNumber;
}



-(BOOL)listItemCheckedInThisNote:(Note *)note andThisContent:(Content *)content{
	NSNumber *numRows = [[SQLiteDB sharedDatabase] getValueFromThisTable:@"TagValuesInContent"
												usingThisSelectStatement:[NSString stringWithFormat:
																		  @"SELECT COUNT(pk) AS N FROM TagValuesInContent WHERE fk_To_ContentInNoteAndControl = %@ AND fk_To_TagValues = %@", 
																		  content.pk, self.pk]];
	
	if([numRows intValue] > 0)
		return YES;
	else
		return NO;
}

-(void)ToogleListItemStatusInThisNote:(Note *)note andThisContent:(Content *)content{
	if(![self listItemCheckedInThisNote:note andThisContent:content]){
		NSNumber *listContent_pk = [[SQLiteDB sharedDatabase] addRowToThisTable:@"TagValuesInContent"
															 withThisColumnName:@"fk_To_TagValues"
																  withThisValue:[self.pk stringValue]];
		[[SQLiteDB sharedDatabase] updateNumberInThisTable:@"TagValuesInContent" 
											  inThisColumn:@"fk_To_ContentInNoteAndControl" 
											 withThisValue:content.pk 
								   usingThisWhereStatement:[NSString stringWithFormat:@"WHERE pk = %@", listContent_pk]];
	}
	else{
		[[SQLiteDB sharedDatabase] executeThisSQLStatement:[NSString stringWithFormat:@"DELETE FROM TagValuesInContent WHERE fk_To_ContentInNoteAndControl = %@ AND fk_To_TagValues = %@",
															content.pk, self.pk]];
	}
}

@end
