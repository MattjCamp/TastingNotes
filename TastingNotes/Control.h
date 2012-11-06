//
//  Control.h
//  TastingNotes
//
//  Created by Matthew Campbell on 2/3/11.
//  Copyright 2011 App Shop LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLiteDB.h"

@class Section;
@interface Control : NSObject {
	NSString *title;
	BOOL pushesToScreen;
	BOOL allowsMultipleSelections;
	BOOL canEdit;
	NSString *description;
	NSString *type;
	NSNumber *order;
    NSNumber *fk_ToSectionTable;
}

@property (nonatomic, strong) NSNumber *pk;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL pushesToScreen;
@property (nonatomic, assign) BOOL allowsMultipleSelections;
@property (nonatomic, assign) BOOL canEdit;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSNumber *order;
@property (nonatomic, strong) NSNumber *fk_ToSectionTable;
@property (nonatomic, strong) Section *section;

-(id)initWithPrimaryKey:(NSNumber *) primaryKey inThisSection:(Section *)parentSection;

@end
