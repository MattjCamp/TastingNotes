//
//  Content.h
//  TastingNotes
//
//  Created by Matthew Campbell on 2/3/11.
//  Copyright 2011 App Shop LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLiteDB.h"
#import "Notebook.h"
#import "ListControl.h"

@class Note, Control, ListControl;
@interface Content : NSObject {
	NSNumber *fk_ToNotesInListTable;
	NSNumber *fk_ToControlTable;
	NSString *text;
	NSNumber *numeric;
	UIImage *_image;
	Control *control;
}

@property(nonatomic, strong) NSNumber *pk;
@property(nonatomic, strong) NSNumber *fk_ToNotesInListTable;
@property(nonatomic, strong) NSNumber *fk_ToControlTable;
@property(nonatomic, strong) NSString *text;
@property(nonatomic, strong) NSNumber *numeric;
@property(nonatomic, strong) UIImage *image;
@property(nonatomic, strong) Note *note;
@property(nonatomic, strong, readonly) Control *control;

-(id)initWithPrimaryKey:(NSNumber *) primaryKey;

-(NSString *)toString;
-(NSString *)toHTML;

@end
