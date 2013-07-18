//
//  Note.h
//  TastingNotes
//
//  Created by Matthew Campbell on 2/3/11.
//  Copyright 2011 App Shop LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLiteDB.h"
#import "Control.h"
#import "Content.h"
#import "Notebook.h"
#import "ListControl.h"

@class Notebook, Content;

@interface Note : NSObject {
	NSNumber *order;
	NSNumber *fk_ToListsTable;
	NSString *_titleText;
	NSString *_detailText;
	UIImage *_thumbnail;
    NSString *_htmlViewString;
}

@property (nonatomic, strong) NSNumber *pk;
@property (nonatomic, strong) NSNumber *order;
@property (nonatomic, strong) NSNumber *fk_ToListsTable;
@property (nonatomic, strong, readonly) NSString *titleText;
@property (nonatomic, strong, readonly) NSString *detailText;
@property (nonatomic, strong, readonly) UIImage *thumbnail;
@property (nonatomic, strong) Notebook *notebook;
@property (nonatomic, strong) NSString *htmlViewString;

-(id)initWithPrimaryKey:(NSNumber *) primaryKey inThisNotebook:(Notebook *) nb;

-(Content *)contentInThisControl:(Control *) control;
-(void)addContentToThisControl:(Control *) control;
-(void)setPlacardInfoToNilWithThisControlPKValue:(NSNumber *)controlPK;
-(void)setPlacardInfoToNil;
-(NSString *)toString;
-(NSString *)socialString;
-(NSString *)thumbnailCacheFilename;

@end
