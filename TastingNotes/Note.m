//
//  Note.m
//  TastingNotes
//
//  Created by Matthew Campbell on 2/3/11.
//  Copyright 2011 App Shop LLC. All rights reserved.
//

#import "Note.h"
#import "AppContent.h"
#import "NoteToHTMLPage.h"

@implementation Note

NSMutableArray *listOfContent;

-(id)initWithPrimaryKey:(NSNumber *) primaryKey inThisNotebook:(Notebook *) nb{
	if ((self = [self init])){
		order = nil;
		listOfContent = nil;
		fk_ToListsTable = nil;
		self.pk = primaryKey;
		self.notebook = nb;
	}
	return self;
}

#pragma mark Properties

-(void)dealloc {
	listOfContent = nil;
	_titleText = nil;
	_detailText = nil;
	order = nil;
	fk_ToListsTable = nil;
}

-(NSNumber *)order {
	if(order == nil){
		order  = [[SQLiteDB sharedDatabase]
				  getValueFromThisTable:@"NotesInListTable"
				  usingThisSelectStatement:[NSString stringWithFormat:@"SELECT NoteOrder FROM NotesInListTable WHERE pk = %@", self.pk]];
        if((NSNull *)order == [NSNull null])
            order = nil;
		
		return order;
	}
	else
		return order;
}

-(void)setOrder:(NSNumber *)aNumber {
	if (!order && !aNumber) return;
	[[SQLiteDB sharedDatabase] updateNumberInThisTable:@"NotesInListTable"
										  inThisColumn:@"NoteOrder"
										 withThisValue:aNumber
							   usingThisWhereStatement:[NSString stringWithFormat:@"WHERE pk = %@", self.pk]];
	
	order = nil;
	order = aNumber;
}

-(NSNumber *)fk_ToListsTable {
	if(fk_ToListsTable == nil){
		fk_ToListsTable  = [[SQLiteDB sharedDatabase]
							getValueFromThisTable:@"NotesInListTable"
							usingThisSelectStatement:[NSString stringWithFormat:@"SELECT fk_ToListsTable FROM NotesInListTable WHERE pk = %@", self.pk]];
        if((NSNull *)fk_ToListsTable == [NSNull null])
            fk_ToListsTable = nil;
		
		return fk_ToListsTable;
	}
	else
		return fk_ToListsTable;
}

-(void)setFk_ToListsTable:(NSNumber *)aNumber {
	if (!fk_ToListsTable && !aNumber) return;
	[[SQLiteDB sharedDatabase] updateNumberInThisTable:@"NotesInListTable"
										  inThisColumn:@"fk_ToListsTable"
										 withThisValue:aNumber
							   usingThisWhereStatement:[NSString stringWithFormat:@"WHERE pk = %@", self.pk]];
	
	fk_ToListsTable = nil;
	fk_ToListsTable = aNumber;
}

-(NSString *)titleText {
	if(_titleText == nil){
		if(!self.notebook.noteBadge1Control_fk)
			return nil;
		Control *tempControl = self.notebook.placardTitleControl;
		Content *content = [self contentInThisControl:tempControl];
		_titleText = content.toString;
        
        return _titleText;
	}
	else
		return _titleText;
}

-(NSString *) getDetailTextWithThisControl:(Control *)control{
	if(!control)
		return nil;
	Content *content = [self contentInThisControl:control];
	if(content){
		if([control isKindOfClass:[ListControl class]]){
			ListControl *lc = (ListControl *)control;
			return [lc toStringFromThisContent:content];
		}
		if(content.toString)
			return content.toString;
		else
			return nil;
	}
	else
		return nil;
}

-(NSString *)detailText {
	if(_detailText == nil){
		NSMutableString *mutableString = [[NSMutableString alloc] init];
		NSString *tempString = nil;
		tempString = [self getDetailTextWithThisControl:self.notebook.placardDetail1Control];
        if(![tempString isEqualToString:@""]){
            if(tempString){
                [mutableString appendString:tempString];
                [mutableString appendString:@"\n"];
            }
        }
        tempString = nil;
		tempString = [self getDetailTextWithThisControl:self.notebook.placardDetail2Control];
        if(![tempString isEqualToString:@""]){
            if(tempString){
                [mutableString appendString:tempString];
                [mutableString appendString:@"\n"];
            }
        }
        tempString = nil;
		tempString = [self getDetailTextWithThisControl:self.notebook.placardDetail3Control];
        if(![tempString isEqualToString:@""]){
            if(tempString){
                [mutableString appendString:tempString];
                [mutableString appendString:@"\n"];
            }
        }
		_detailText = [NSString stringWithString:mutableString];
		return _detailText;
	}
	else
		return _detailText;
}

-(NSString *)thumbnailCacheFilename{
    Control *thumbnailControl = self.notebook.placardImageThumbnailControl;
    Content *content = [self contentInThisControl:thumbnailControl];
    NSString *tempName = [NSString stringWithFormat:@"%@%@.png", [self.pk stringValue], [content.pk stringValue]];
    NSString *tempThumbnailCacheFilename = [[[AppContent sharedContent] cacheDirectory] stringByAppendingPathComponent:tempName];
    
    return tempThumbnailCacheFilename;
}

-(UIImage *)thumbnail {
	if(_thumbnail == nil){
		if(!self.notebook.noteImageBadgeControl_fk)
			return nil;
		Control *thumbnailControl = self.notebook.placardImageThumbnailControl;
		Content *content = [self contentInThisControl:thumbnailControl];
		if(content){
            
            NSFileManager *fm = [NSFileManager defaultManager];
            if([fm fileExistsAtPath:[self thumbnailCacheFilename]]){
                _thumbnail = [UIImage imageWithContentsOfFile:[self thumbnailCacheFilename]];
                return _thumbnail;
            }else{
                CGSize newSize = CGSizeMake(60, 80);
                UIGraphicsBeginImageContext(newSize);
                if(content.image){
                    [content.image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
                    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
                    UIGraphicsEndImageContext();
                    _thumbnail = newImage;
                    NSData *tempData = UIImagePNGRepresentation(newImage);
                    [tempData writeToFile:[self thumbnailCacheFilename] atomically:NO];
                    return _thumbnail;
                }
                else
                    return nil;
            }
		}
		else
			return nil;
	}
	else {
		return _thumbnail;
	}
}

-(Content *)contentInThisControl:(Control *) control{
	if(!listOfContent)
		listOfContent = [[NSMutableArray alloc] init];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"fk_ToControlTable = %@ && fk_ToNotesInListTable = %@", control.pk, self.pk];
	NSArray *tempContentList = [listOfContent filteredArrayUsingPredicate:predicate];
	if([tempContentList count] == 1)
		return [tempContentList objectAtIndex:0];
	
	NSNumber *content_pk = [[SQLiteDB sharedDatabase] getValueFromThisTable:@"ContentInNoteAndControl"
												   usingThisSelectStatement:[NSString stringWithFormat:
																			 @"SELECT pk FROM ContentInNoteAndControl WHERE fk_ToNotesInListTable = %@ AND fk_ToControlTable = %@",
																			 self.pk, control.pk]];
	if(content_pk){
		Content *content = [[Content alloc] initWithPrimaryKey:content_pk];
		content.note = self;
		[listOfContent addObject:content];
		return content;
	}
	else
		return nil;
}

-(void)addContentToThisControl:(Control *) control{
	NSNumber *content_pk = [[SQLiteDB sharedDatabase] addRowToThisTable:@"ContentInNoteAndControl"
													 withThisColumnName:@"fk_ToNotesInListTable"
														  withThisValue:[self.pk stringValue]];
	[[SQLiteDB sharedDatabase] updateNumberInThisTable:@"ContentInNoteAndControl"
										  inThisColumn:@"fk_ToControlTable"
										 withThisValue:control.pk
							   usingThisWhereStatement:[NSString stringWithFormat:@"WHERE pk = %@", content_pk]];
}

-(void)setPlacardInfoToNilWithThisControlPKValue:(NSNumber *)controlPK{
	if([self.notebook.noteBadge1Control_fk intValue] == [controlPK intValue]){
		_titleText = nil;
	}
	if([self.notebook.noteBadge2Control_fk intValue] == [controlPK intValue] ||
	   [self.notebook.noteBadge3Control_fk intValue] == [controlPK intValue] ||
	   [self.notebook.noteBadge4Control_fk intValue] == [controlPK intValue]){
		_detailText = nil;
	}
	if([self.notebook.noteImageBadgeControl_fk intValue] == [controlPK intValue]){
		_thumbnail = nil;
	}
}

-(void)setPlacardInfoToNil{
	_titleText = nil;
	_detailText = nil;
	_thumbnail = nil;
}

-(NSString *)toString{
	NSMutableString *noteString = [[NSMutableString alloc] init];
	for(Section *s in self.notebook.listOfSections){
		[noteString appendString:@"<STRONG>"];
		[noteString appendString:s.name];
		[noteString appendString:@"</STRONG><BR/>"];
		for(Control *c in s.listOfControls){
			Content *content = [self contentInThisControl:c];
			if(content.toString){
				[noteString appendString:content.toString];
				[noteString appendString:@"<BR/>"];
			}
		}
		[noteString appendString:@"<BR/>"];
	}
	
	return noteString;
}

-(NSString *)socialString{
    NSString *temp = [NSString stringWithFormat:@"Just tasted %@ %@ #tastingnotesapp", self.titleText, self.detailText];
    
    return temp;
}

-(NSString *)htmlViewString {
	if(!_htmlViewString){
        NSMutableString *noteString = [[NSMutableString alloc] init];
        [noteString appendString:[NoteToHTMLPage startPage]];
        
        for(Section *s in self.notebook.listOfSections){
            [noteString appendString:[NoteToHTMLPage htmlForThisSection:s]];
            for(Control *c in s.listOfControls){
                Content *content = [self contentInThisControl:c];
                [noteString appendString:[NoteToHTMLPage htmlForThisContent:content]];
            }
        }
        [noteString appendString:[NoteToHTMLPage endPage]];
        _htmlViewString = noteString;
    }
    return _htmlViewString;
}

-(void)setHtmlViewString:(NSString *)aString {
    if (_htmlViewString != aString)
        _htmlViewString = aString;
}

@end
