//
//  ListItem.h
//  TastingNotes
//
//  Created by Matthew Campbell on 3/10/11.
//  Copyright 2011 App Shop LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLiteDB.h"
#import "Note.h"

@class Note, Content;
@interface ListItem : NSObject {
	NSNumber *fk_ToControlTable;
	NSString *text;
	NSNumber *numeric;
	NSNumber *order;
}

@property(nonatomic, strong) NSNumber *pk;
@property(nonatomic, strong) NSNumber *fk_ToControlTable;
@property(nonatomic, strong) NSString *text;
@property(nonatomic, strong) NSNumber *numeric;
@property(nonatomic, strong) NSNumber *order;

-(id)initWithPrimaryKey:(NSNumber *) primaryKey;

-(BOOL)listItemCheckedInThisNote:(Note *)note andThisContent:(Content *)content;
-(void)ToogleListItemStatusInThisNote:(Note *)note andThisContent:(Content *)content;

@end
