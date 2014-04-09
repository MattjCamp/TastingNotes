//
//  List.m
//  TastingNotes
//
//  Created by Matthew Campbell on 3/10/11.
//  Copyright 2011 App Shop LLC. All rights reserved.
//

#import "ListControl.h"
#import "AppContent.h"

@implementation ListControl

-(id)initWithPrimaryKey:(NSNumber *) primaryKey inThisSection:(Section *)parentSection{
	if ((self = [super initWithPrimaryKey:primaryKey inThisSection:parentSection])){
        
	}
	return self;
}

-(NSMutableArray *) listItems{
    if(_listItems == nil){
        ListItem *listItem;
        NSArray *pklist = [[SQLiteDB sharedDatabase] getColumnValuesFromThisTable:@"TagValues"
                                                         usingThisSelectStatement:[NSString stringWithFormat:@"SELECT pk FROM TagValues WHERE fk_ToControlTable = %@ ORDER BY TagValueOrder", self.pk]
                                                                   fromThisColumn:0];
        if(pklist.count==0){
            NSLog(@"Trying to populate list control %@", self.title);
            AppContent *rm = [AppContent sharedContent];
            [rm.notebooks populateThisListControl:self];
            pklist = [[SQLiteDB sharedDatabase] getColumnValuesFromThisTable:@"TagValues"
                                                    usingThisSelectStatement:[NSString stringWithFormat:@"SELECT pk FROM TagValues WHERE fk_ToControlTable = %@ ORDER BY TagValueOrder", self.pk]
                                                              fromThisColumn:0];
        }
        _listItems = [[NSMutableArray alloc] init];
        int i = 0;
        for(NSNumber *local_pk in pklist){
            listItem = [[ListItem alloc] initWithPrimaryKey:local_pk];
            if(!listItem.order)
                listItem.order = [NSNumber numberWithInt:i];
			[_listItems addObject:listItem];
			i++;
		}
        NSLog(@"_listItems.count = %li", (long)_listItems.count);
        return _listItems;
	}
    else{
        return _listItems;
        NSLog(@"_listItems.count = %li", (long)_listItems.count);
    }
}

-(void)addListItemToThisListControl{
	SQLiteDB *database = [SQLiteDB sharedDatabase];
	NSNumber *listItem_pk = [database addRowToThisTable:@"TagValues"
									 withThisColumnName:@"fk_ToControlTable"
										  withThisValue:[self.pk stringValue]];
	ListItem *listItem = [[ListItem alloc] initWithPrimaryKey:listItem_pk];
	
	NSNumber *listItemOrder = [database getValueFromThisTable:@"TagValues"
									 usingThisSelectStatement:@"SELECT Max(TagValueOrder) + 1 AS N FROM TagValues"];
	
	if((NSNull *)listItemOrder == [NSNull null])
		listItemOrder = [NSNumber numberWithInt:0];
	listItem.order = listItemOrder;
	[self.listItems addObject:listItem];
}

-(void)removeThisListItem:(ListItem *)listItem;{
	[[SQLiteDB sharedDatabase] executeThisSQLStatement:[NSString stringWithFormat:@"DELETE FROM TagValues WHERE pk = %@",
														listItem.pk]];
	[self.listItems removeObject:listItem];
}

-(NSString *)toStringFromThisContent:(Content *)content{
	NSArray *listOfSelectedListItems = [[SQLiteDB sharedDatabase] getColumnValuesFromThisTable:@"TagValues"
																	  usingThisSelectStatement:[NSString stringWithFormat:@"SELECT TagValueText FROM TagValues, TagValuesInContent WHERE TagValues.pk = TagValuesInContent.fk_To_TagValues AND TagValuesInContent.fk_To_ContentInNoteAndControl = %@ ORDER BY TagValues.TagValueOrder", content.pk]
																				fromThisColumn:0];
	
	
	NSMutableString *selectedItems = [[NSMutableString alloc] init];
	for (NSString *s in listOfSelectedListItems) {
		if((NSNull *)s != [NSNull null]){
			if([listOfSelectedListItems lastObject] == s)
				[selectedItems appendString:s];
			else{
				[selectedItems appendString:s];
				[selectedItems appendString:@", "];
			}
		}
	}
	return selectedItems;
}

@end