//
//  Notebook.m
//  TastingNotes
//
//  Created by Matthew Campbell on 2/3/11.
//  Copyright 2011 App Shop LLC. All rights reserved.
//

#import "Notebook.h"

@implementation Notebook

-(id)initWithPrimaryKey:(NSNumber *) primaryKey{
	if ((self = [self init])){
		name = nil;
		order = nil;
		noteImageBadgeControl_fk = nil;
		noteBadge1Control_fk = nil;
		noteBadge2Control_fk = nil;
		noteBadge3Control_fk = nil;
		noteBadge4Control_fk = nil;
		noteBadge5Control_fk = nil;
        listOfSections = nil;
		listOfControls = nil;
		listOfNotes = nil;
		self.pk = primaryKey;
		[self createImageDirectory];
	}
	return self;
}

#pragma mark Properties

-(void)dealloc{
	name = nil;
	order = nil;
	noteImageBadgeControl_fk = nil;
	noteBadge1Control_fk = nil;
	noteBadge2Control_fk = nil;
	noteBadge3Control_fk = nil;
	noteBadge4Control_fk = nil;
	noteBadge5Control_fk = nil;
    listOfSections = nil;
	listOfControls = nil;
    listOfNotes = nil;
}

-(void)createImageDirectory{
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *userDirectory = [[paths objectAtIndex:0] stringByAppendingFormat:@"/User/"];
	BOOL directoryExists = [fileManager fileExistsAtPath:userDirectory];
	NSError *err;
	if(directoryExists == NO)
		[fileManager createDirectoryAtPath:userDirectory
			   withIntermediateDirectories:NO
								attributes:nil error:&err];
    
	NSString *notebookDirectory = [NSString stringWithFormat:@"%@/%@/", userDirectory, self.pk];
	BOOL notebookDirectoryExists = [fileManager fileExistsAtPath:notebookDirectory];
	
	if(!notebookDirectoryExists)
		[fileManager createDirectoryAtPath:notebookDirectory
			   withIntermediateDirectories:NO
								attributes:nil error:nil];
	
	NSString *imageDirectory = [NSString stringWithFormat:@"%@/ImageContent/", notebookDirectory];
	BOOL imageDirectoryExists = [fileManager fileExistsAtPath:imageDirectory];
	if(!imageDirectoryExists)
		[fileManager createDirectoryAtPath:imageDirectory
			   withIntermediateDirectories:NO
								attributes:nil error:nil];
	
}

-(NSString *)name {
	if(name == nil){
		name = [[SQLiteDB sharedDatabase]
				getValueFromThisTable:@"ListsTable"
				usingThisSelectStatement:[NSString stringWithFormat:@"SELECT ListName FROM ListsTable WHERE pk = %@", self.pk]];
        if((NSNull *)name == [NSNull null])
            name = nil;
		return name;
	}
	else
		return name;
}

-(void)setName:(NSString *)aString {
	if ((!name && !aString) || (name && aString && [name isEqualToString:aString])) return;
	[[SQLiteDB sharedDatabase] updateStringInThisTable:@"ListsTable"
										  inThisColumn:@"ListName"
										 withThisValue:aString
							   usingThisWhereStatement:[NSString stringWithFormat:@"WHERE pk = %@", self.pk]];
	
	name = nil;
	name = aString;
}

-(NSNumber *)order {
	if(order == nil){
		order = [[SQLiteDB sharedDatabase]
                 getValueFromThisTable:@"ListsTable"
                 usingThisSelectStatement:[NSString stringWithFormat:@"SELECT ListOrder FROM ListsTable WHERE pk = %@", self.pk]];
        if((NSNull *)order == [NSNull null])
            order = nil;
		
		return order;
	}
	else
		return order;
}

-(void)setOrder:(NSNumber *)aNumber {
	if (!order && !aNumber) return;
	[[SQLiteDB sharedDatabase] updateNumberInThisTable:@"ListsTable"
										  inThisColumn:@"ListOrder"
										 withThisValue:aNumber
							   usingThisWhereStatement:[NSString stringWithFormat:@"WHERE pk = %@", self.pk]];
	
	order = nil;
    order = aNumber;
}

-(BOOL)isPopulated {
	NSString *tempBool = [[SQLiteDB sharedDatabase]
						  getValueFromThisTable:@"ListsTable"
						  usingThisSelectStatement:[NSString stringWithFormat:@"SELECT isPopulated FROM ListsTable WHERE pk = %@", self.pk]];
	
	if([tempBool isEqualToString:@"YES"])
		return YES;
	else
		return NO;
}

-(void)setIsPopulated:(BOOL)aBOOL {
	if (isPopulated == aBOOL) return;
	
	if(aBOOL == YES)
		[[SQLiteDB sharedDatabase] updateStringInThisTable:@"ListsTable"
											  inThisColumn:@"isPopulated"
											 withThisValue:@"YES"
								   usingThisWhereStatement:[NSString stringWithFormat:@"WHERE pk = %@", self.pk]];
	else
		[[SQLiteDB sharedDatabase] updateStringInThisTable:@"ListsTable"
											  inThisColumn:@"isPopulated"
											 withThisValue:@"NO"
								   usingThisWhereStatement:[NSString stringWithFormat:@"WHERE pk = %@", self.pk]];
    isPopulated = aBOOL;
}

-(NSNumber *)noteImageBadgeControl_fk {
	if(noteImageBadgeControl_fk == nil){
		//Make this NSNumber since SQL schema left out the INTEGER specification:
		NSString *temp_noteImageBadgeControl_fk = [[SQLiteDB sharedDatabase]
												   getValueFromThisTable:@"ListsTable"
												   usingThisSelectStatement:[NSString stringWithFormat:@"SELECT NoteImageBadgeControl_fk FROM ListsTable WHERE pk = %@", self.pk]];
        if((NSNull *)temp_noteImageBadgeControl_fk == [NSNull null]){
			noteImageBadgeControl_fk = nil;
			return noteImageBadgeControl_fk;
		}
		else{
			noteImageBadgeControl_fk = [NSNumber numberWithInt:[temp_noteImageBadgeControl_fk intValue]];
			
			return noteImageBadgeControl_fk;
		}
	}
	else
		return noteImageBadgeControl_fk;
}

-(void)setNoteImageBadgeControl_fk:(NSNumber *)aNumber {
	if (!noteImageBadgeControl_fk && !aNumber) return;
	[[SQLiteDB sharedDatabase] updateNumberInThisTable:@"ListsTable"
										  inThisColumn:@"NoteImageBadgeControl_fk"
										 withThisValue:aNumber
							   usingThisWhereStatement:[NSString stringWithFormat:@"WHERE pk = %@", self.pk]];
	
	noteImageBadgeControl_fk = nil;
	noteImageBadgeControl_fk = aNumber;
}

-(NSNumber *)noteBadge1Control_fk {
	if(noteBadge1Control_fk == nil){
		//Make this NSNumber since SQL schema left out the INTEGER specification:
		NSString *temp_noteBadge1Control_fk = [[SQLiteDB sharedDatabase]
											   getValueFromThisTable:@"ListsTable"
											   usingThisSelectStatement:[NSString stringWithFormat:@"SELECT NoteBadge1Control_fk FROM ListsTable WHERE pk = %@", self.pk]];
        if((NSNull *)temp_noteBadge1Control_fk == [NSNull null]){
			noteBadge1Control_fk = nil;
			return noteBadge1Control_fk;
		}
		else{
			noteBadge1Control_fk = [NSNumber numberWithInt:[temp_noteBadge1Control_fk intValue]];
			
			return noteBadge1Control_fk;
		}
	}
	else
		return noteBadge1Control_fk;
}

-(void)setNoteBadge1Control_fk:(NSNumber *)aNumber {
	if (!noteBadge1Control_fk && !aNumber) return;
	[[SQLiteDB sharedDatabase] updateNumberInThisTable:@"ListsTable"
										  inThisColumn:@"NoteBadge1Control_fk"
										 withThisValue:aNumber
							   usingThisWhereStatement:[NSString stringWithFormat:@"WHERE pk = %@", self.pk]];
	
	noteBadge1Control_fk = nil;
	noteBadge1Control_fk = aNumber;
}

-(NSNumber *)noteBadge2Control_fk {
	if(noteBadge2Control_fk == nil){
		//Make this NSNumber since SQL schema left out the INTEGER specification:
		NSString *temp_noteBadge2Control_fk = [[SQLiteDB sharedDatabase]
											   getValueFromThisTable:@"ListsTable"
											   usingThisSelectStatement:[NSString stringWithFormat:@"SELECT NoteBadge2Control_fk FROM ListsTable WHERE pk = %@", self.pk]];
        if((NSNull *)temp_noteBadge2Control_fk == [NSNull null]){
			noteBadge2Control_fk = nil;
			return noteBadge2Control_fk;
		}
		else{
			noteBadge2Control_fk = [NSNumber numberWithInt:[temp_noteBadge2Control_fk intValue]];
			
			return noteBadge2Control_fk;
		}
	}
	else
		return noteBadge2Control_fk;
}

-(void)setNoteBadge2Control_fk:(NSNumber *)aNumber {
	if (!noteBadge2Control_fk && !aNumber) return;
	[[SQLiteDB sharedDatabase] updateNumberInThisTable:@"ListsTable"
										  inThisColumn:@"NoteBadge2Control_fk"
										 withThisValue:aNumber
							   usingThisWhereStatement:[NSString stringWithFormat:@"WHERE pk = %@", self.pk]];
	
	noteBadge2Control_fk = nil;
	noteBadge2Control_fk = aNumber;
}

-(NSNumber *)noteBadge3Control_fk {
	if(noteBadge3Control_fk == nil){
		//Make this NSNumber since SQL schema left out the INTEGER specification:
		NSString *temp_noteBadge3Control_fk = [[SQLiteDB sharedDatabase]
											   getValueFromThisTable:@"ListsTable"
											   usingThisSelectStatement:[NSString stringWithFormat:@"SELECT NoteBadge3Control_fk FROM ListsTable WHERE pk = %@", self.pk]];
        if((NSNull *)temp_noteBadge3Control_fk == [NSNull null]){
			noteBadge3Control_fk = nil;
			return noteBadge3Control_fk;
		}
		else{
			noteBadge3Control_fk = [NSNumber numberWithInt:[temp_noteBadge3Control_fk intValue]];
			
			return noteBadge3Control_fk;
		}
	}
	else
		return noteBadge3Control_fk;
}

-(void)setNoteBadge3Control_fk:(NSNumber *)aNumber {
	if (!noteBadge3Control_fk && !aNumber) return;
	[[SQLiteDB sharedDatabase] updateNumberInThisTable:@"ListsTable"
										  inThisColumn:@"NoteBadge3Control_fk"
										 withThisValue:aNumber
							   usingThisWhereStatement:[NSString stringWithFormat:@"WHERE pk = %@", self.pk]];
	
	noteBadge3Control_fk = nil;
	noteBadge3Control_fk = aNumber;
}

-(NSNumber *)noteBadge4Control_fk {
	if(noteBadge4Control_fk == nil){
		//Make this NSNumber since SQL schema left out the INTEGER specification:
		NSString *temp_noteBadge4Control_fk = [[SQLiteDB sharedDatabase]
											   getValueFromThisTable:@"ListsTable"
											   usingThisSelectStatement:[NSString stringWithFormat:@"SELECT NoteBadge4Control_fk FROM ListsTable WHERE pk = %@", self.pk]];
        if((NSNull *)temp_noteBadge4Control_fk == [NSNull null]){
			noteBadge4Control_fk = nil;
			return noteBadge4Control_fk;
		}
		else{
			noteBadge4Control_fk = [NSNumber numberWithInt:[temp_noteBadge4Control_fk intValue]];
			
			return noteBadge4Control_fk;
		}
	}
	else
		return noteBadge4Control_fk;
}

-(void)setNoteBadge4Control_fk:(NSNumber *)aNumber {
	if (!noteBadge4Control_fk && !aNumber) return;
	[[SQLiteDB sharedDatabase] updateNumberInThisTable:@"ListsTable"
										  inThisColumn:@"NoteBadge4Control_fk"
										 withThisValue:aNumber
							   usingThisWhereStatement:[NSString stringWithFormat:@"WHERE pk = %@", self.pk]];
	
	noteBadge4Control_fk = nil;
	noteBadge4Control_fk = aNumber;
}

-(NSNumber *)noteBadge5Control_fk {
	if(noteBadge5Control_fk == nil){
		//Make this NSNumber since SQL schema left out the INTEGER specification:
		NSString *temp_noteBadge5Control_fk = [[SQLiteDB sharedDatabase]
											   getValueFromThisTable:@"ListsTable"
											   usingThisSelectStatement:[NSString stringWithFormat:@"SELECT NoteBadge5Control_fk FROM ListsTable WHERE pk = %@", self.pk]];
        if((NSNull *)temp_noteBadge5Control_fk == [NSNull null]){
			noteBadge5Control_fk = nil;
			return noteBadge5Control_fk;
		}
		else{
			noteBadge5Control_fk = [NSNumber numberWithInt:[temp_noteBadge5Control_fk intValue]];
			
			return noteBadge5Control_fk;
		}
	}
	else
		return noteBadge5Control_fk;
}

-(void)setNoteBadge5Control_fk:(NSNumber *)aNumber {
	if (!noteBadge5Control_fk && !aNumber) return;
	[[SQLiteDB sharedDatabase] updateNumberInThisTable:@"ListsTable"
										  inThisColumn:@"NoteBadge5Control_fk"
										 withThisValue:aNumber
							   usingThisWhereStatement:[NSString stringWithFormat:@"WHERE pk = %@", self.pk]];
	
	noteBadge5Control_fk = nil;
	noteBadge5Control_fk = aNumber;
}

-(NSMutableArray *) listOfSections{
    if(listOfSections == nil){
        NSArray *pklist = [[SQLiteDB sharedDatabase] getColumnValuesFromThisTable:@"SectionTable"
                                                         usingThisSelectStatement:[NSString stringWithFormat:@"SELECT pk FROM SectionTable WHERE fk_ToListsTable = %@ ORDER BY SectionOrder", self.pk]
                                                                   fromThisColumn:0];
        Section *section;
        listOfSections = [[NSMutableArray alloc] init];
        int i = 0;
        for(NSNumber *local_pk in pklist){
            section = [[Section alloc] initWithPrimaryKey:local_pk];
            if(!section.order)
                section.order = [NSNumber numberWithInt:i];
            i++;
            [listOfSections addObject:section];
        }
        
        return listOfSections;
    }
    else
        return listOfSections;
}

-(NSMutableArray *) listOfControls{
	listOfControls = nil;
	listOfControls = [[NSMutableArray alloc] init];
	for (Section *s in self.listOfSections) {
		for(Control *c in s.listOfControls)
			[listOfControls addObject:c];
	}
	return listOfControls;
}

-(NSMutableArray *) listOfNotes{
    if(listOfNotes == nil){
        NSArray *pklist = [[SQLiteDB sharedDatabase] getColumnValuesFromThisTable:@"NotesInListTable"
                                                         usingThisSelectStatement:[NSString stringWithFormat:@"SELECT pk FROM NotesInListTable WHERE fk_ToListsTable = %@ ORDER BY NoteOrder", self.pk]
                                                                   fromThisColumn:0];
		Note *note;
        listOfNotes = [[NSMutableArray alloc] init];
        int i = 0;
        for(NSNumber *local_pk in pklist){
            note = [[Note alloc] initWithPrimaryKey:local_pk inThisNotebook:self];
            if(!note.order)
                note.order = [NSNumber numberWithInt:i];
            i++;
            [listOfNotes addObject:note];
        }
        
        return listOfNotes;
    }
    else
        return listOfNotes;
}

-(void)moveControlAtThisIndex:(NSInteger)fromControlIndex atThisSectionIndex:(NSInteger)fromSectionIndex
           toThisSectionIndex:(NSInteger)toSectionIndex andThisControlIndex:(NSInteger) toControlIndex;{
    
    Section *fromS = [self.listOfSections objectAtIndex:fromSectionIndex];
    Section *toS = [self.listOfSections objectAtIndex:toSectionIndex];
    
    if(fromS == toS){
        Control *fromC = [fromS.listOfControls objectAtIndex:fromControlIndex];
        Control *toC = [toS.listOfControls objectAtIndex:toControlIndex];
        
        
        [fromS.listOfControls removeObject:fromC];
        [toS.listOfControls insertObject:fromC atIndex:toControlIndex];
        
        [toS.listOfControls removeObject:toC];
        [fromS.listOfControls insertObject:toC atIndex:fromControlIndex];
        
        
        int i = 0;
        for(Control *c in toS.listOfControls){
            c.order = [NSNumber numberWithInt:i];
            i++;
        }
    }
    else{
        Control *fromC = [fromS.listOfControls objectAtIndex:fromControlIndex];
        fromC.fk_ToSectionTable = toS.pk;
        [fromS.listOfControls removeObject:fromC];
        [toS.listOfControls insertObject:fromC atIndex:toControlIndex];
        int i = 0;
        for(Control *c in toS.listOfControls){
            c.order = [NSNumber numberWithInt:i];
            i++;
        }
    }
}

-(void)moveSectionAtThisIndex:(NSInteger)fromIndex toThisIndex:(NSInteger)toIndex{
    Section *fromSection = [self.listOfSections objectAtIndex:fromIndex];
    Section *toSection = [self.listOfSections objectAtIndex:toIndex];
    
    NSNumber *fromOrder;
    NSNumber *toOrder;
    
    fromOrder = [[NSNumber alloc] initWithLong:fromIndex];
    toOrder = [[NSNumber alloc] initWithLong:toIndex];
    
    fromSection.order = toOrder;
    toSection.order = fromOrder;
    
    [self.listOfSections exchangeObjectAtIndex:fromIndex
							 withObjectAtIndex:toIndex];
}

-(void)addSectionToThisNotebook{
	SQLiteDB *database = [SQLiteDB sharedDatabase];
	NSMutableArray *localListOfSections = self.listOfSections;
	NSNumber *section_pk = [database addRowToThisTable:@"SectionTable"
									withThisColumnName:@"fk_ToListsTable"
										 withThisValue:[self.pk stringValue]];
	Section *section = [[Section alloc] initWithPrimaryKey:section_pk];
	
	NSNumber *sectionOrder = [database getValueFromThisTable:@"SectionTable"
									usingThisSelectStatement:@"SELECT Max(SectionOrder) + 1 AS N FROM SectionTable"];
	
	if((NSNull *)sectionOrder == [NSNull null])
		sectionOrder = [NSNumber numberWithInt:0];
	section.order = sectionOrder;
	section.name = @"Section";
	[localListOfSections addObject:section];
}

-(void)addControlToThisNotebook{
	Section *section = [self.listOfSections lastObject];
	[self listOfControls];
	if(section == nil){
		[self addSectionToThisNotebook];
		section = [self.listOfSections lastObject];
	}
	[section listOfControls];
	SQLiteDB *database = [SQLiteDB sharedDatabase];
	NSNumber *control_pk = [database addRowToThisTable:@"ControlTable"
									withThisColumnName:@"fk_ToSectionTable"
										 withThisValue:[section.pk stringValue]];
	Control *control = [[Control alloc] initWithPrimaryKey:control_pk inThisSection:section];
	
	NSNumber *controlOrder = [database getValueFromThisTable:@"ControlTable"
									usingThisSelectStatement:@"SELECT Max(ControlOrder) + 1 AS N FROM ControlTable"];
	
	if((NSNull *)controlOrder == [NSNull null])
		controlOrder = [NSNumber numberWithInt:0];
	control.order = controlOrder;
	control.canEdit = YES;
	control.title = @"<Add Control Title>";
    //control.type = @"SmallText";
	[section.listOfControls addObject:control];
	[self.listOfControls addObject:control];
}

-(void)addNoteToThisNotebook{
	[self listOfNotes];
	NSNumber *note_pk = [[SQLiteDB sharedDatabase] addRowToThisTable:@"NotesInListTable"
												  withThisColumnName:@"fk_ToListsTable"
													   withThisValue:[self.pk stringValue]];
	Note *note = [[Note alloc] initWithPrimaryKey:note_pk inThisNotebook:self];
	NSNumber *noteOrder = [[SQLiteDB sharedDatabase] getValueFromThisTable:@"NotesInListTable"
												  usingThisSelectStatement:@"SELECT Max(NoteOrder) + 1 AS N FROM NotesInListTable"];
	if((NSNull *)noteOrder == [NSNull null])
		noteOrder = [NSNumber numberWithInt:0];
	note.order = noteOrder;
	
	[self.listOfNotes addObject:note];
}

-(void)removeThisNote:(Note *)noteToRemove{
	[[SQLiteDB sharedDatabase] executeThisSQLStatement:[NSString stringWithFormat:@"DELETE FROM NotesInListTable WHERE pk = %@", noteToRemove.pk]];
	[listOfNotes removeObject:noteToRemove];
}

-(void)removeThisSection:(Section *)sectionToRemove{
	[[SQLiteDB sharedDatabase] executeThisSQLStatement:[NSString stringWithFormat:@"DELETE FROM SectionTable WHERE pk = %@", sectionToRemove.pk]];
	[listOfSections removeObject:sectionToRemove];
}

-(void)removeThisControl:(Control *)controlToRemove fromThisSection:(Section *) section{
	[[SQLiteDB sharedDatabase] executeThisSQLStatement:[NSString stringWithFormat:@"DELETE FROM ControlTable WHERE pk = %@", controlToRemove.pk]];
	[section.listOfControls removeObject:controlToRemove];
}

-(Control *)placardTitleControl {
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"pk = %@", self.noteBadge1Control_fk];
	NSArray *listOfControlsThatMatch = [self.listOfControls filteredArrayUsingPredicate:predicate];
	if([listOfControlsThatMatch count] == 1)
		return [listOfControlsThatMatch objectAtIndex:0];
	else
		return nil;
}

-(Control *)placardImageThumbnailControl{
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"pk = %@", self.noteImageBadgeControl_fk];
	NSArray *listOfControlsThatMatch = [self.listOfControls filteredArrayUsingPredicate:predicate];
	if([listOfControlsThatMatch count] == 1){
		Control *c = [listOfControlsThatMatch objectAtIndex:0];
		if([c.type isEqualToString:@"Picture"])
			return c;
		else
			return nil;
	}
	else
		return nil;
}

-(Control *)placardDetail1Control{
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"pk = %@", self.noteBadge2Control_fk];
	NSArray *listOfControlsThatMatch = [self.listOfControls filteredArrayUsingPredicate:predicate];
	if([listOfControlsThatMatch count] == 1)
		return [listOfControlsThatMatch objectAtIndex:0];
	else
		return nil;
}

-(Control *)placardDetail2Control{
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"pk = %@", self.noteBadge3Control_fk];
	NSArray *listOfControlsThatMatch = [self.listOfControls filteredArrayUsingPredicate:predicate];
	if([listOfControlsThatMatch count] == 1)
		return [listOfControlsThatMatch objectAtIndex:0];
	else
		return nil;
}

-(Control *)placardDetail3Control{
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"pk = %@", self.noteBadge4Control_fk];
	NSArray *listOfControlsThatMatch = [self.listOfControls filteredArrayUsingPredicate:predicate];
	if([listOfControlsThatMatch count] == 1)
		return [listOfControlsThatMatch objectAtIndex:0];
	else
		return nil;
}

-(void)setAllNotesPlacardInfoToNil{
	for (Note *n in self.listOfNotes)
		[n setPlacardInfoToNil];
}

-(NSString *)toString{
	NSMutableString *noteString = [[NSMutableString alloc] init];
	for(Note *n in self.listOfNotes){
		[noteString appendString:n.toString];
		[noteString appendString:@"\n"];
	}
	[noteString appendString:@"<p>"];
	[noteString appendString:@"This note was taken with "];
	[noteString appendString:@"<a href="""];
	[noteString appendString:@"http://mobileappmastery.com/apps/iphone/tastingnotes"];
	[noteString appendString:@""">"];
	[noteString appendString:@"Tasting Notes"];
	[noteString appendString:@"</a>"];
	[noteString appendString:@"</p>"];
	
	return noteString;
}

-(void)moveNoteAtThisIndex:(NSInteger)fromIndex toThisIndex:(NSInteger)toIndex{
    [self.listOfNotes exchangeObjectAtIndex:fromIndex
                          withObjectAtIndex:toIndex];
    int i = 0;
    for(Note *note in self.listOfNotes){
        note.order = [NSNumber numberWithInt:i];
        i++;
    }
}

@end