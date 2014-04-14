//
//  Notebook.h
//  TastingNotes
//
//  Created by Matthew Campbell on 2/3/11.
//  Copyright 2011 App Shop LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLiteDB.h"
#import "Section.h"
#import "Control.h"
#import "Note.h"
  

@class Section, Control, Note;
@interface Notebook : NSObject {
	NSString *name;
	NSNumber *order;
	BOOL isPopulated;
	NSNumber *noteImageBadgeControl_fk;
	NSNumber *noteBadge1Control_fk;
	NSNumber *noteBadge2Control_fk;
	NSNumber *noteBadge3Control_fk;
	NSNumber *noteBadge4Control_fk;
	NSNumber *noteBadge5Control_fk;
    NSMutableArray *listOfSections;
	NSMutableArray *listOfControls;
	NSMutableArray *listOfNotes;
}

@property (nonatomic, strong) NSNumber *pk;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *order;
@property (nonatomic, assign) BOOL isPopulated;
@property (nonatomic, strong) NSNumber *noteImageBadgeControl_fk;
@property (nonatomic, strong) NSNumber *noteBadge1Control_fk;
@property (nonatomic, strong) NSNumber *noteBadge2Control_fk;
@property (nonatomic, strong) NSNumber *noteBadge3Control_fk;
@property (nonatomic, strong) NSNumber *noteBadge4Control_fk;
@property (nonatomic, strong) NSNumber *noteBadge5Control_fk;
@property(nonatomic, strong, readonly) NSMutableArray *listOfSections;
@property(nonatomic, strong, readonly) NSMutableArray *listOfControls;
@property(nonatomic, strong, readonly) NSMutableArray *listOfNotes;

-(id)initWithPrimaryKey:(NSNumber *) primaryKey;

-(void)createImageDirectory;
-(void)moveControlAtThisIndex:(NSInteger)fromControlIndex atThisSectionIndex:(NSInteger)fromSectionIndex
           toThisSectionIndex:(NSInteger)toSectionIndex andThisControlIndex:(NSInteger) toControlIndex;
-(void)moveSectionAtThisIndex:(NSInteger)fromIndex toThisIndex:(NSInteger)toIndex;
-(void)addSectionToThisNotebook;
-(void)addControlToThisNotebook;
-(void)addNoteToThisNotebook;
-(void)removeThisNote:(Note *)noteToRemove;
-(void)removeThisSection:(Section *)sectionToRemove;
-(void)removeThisControl:(Control *)controlToRemove fromThisSection:(Section *) section;
-(Control *)placardTitleControl;
-(Control *)placardImageThumbnailControl;
-(Control *)placardDetail1Control;
-(Control *)placardDetail2Control;
-(Control *)placardDetail3Control;
-(void)setAllNotesPlacardInfoToNil;
-(NSString *)toString;
-(void)moveNoteAtThisIndex:(NSInteger)fromIndex toThisIndex:(NSInteger)toIndex;

@end