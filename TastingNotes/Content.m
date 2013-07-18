//
//  Content.m
//  TastingNotes
//
//  Created by Matthew Campbell on 2/3/11.
//  Copyright 2011 App Shop LLC. All rights reserved.
//

#import "Content.h"

@implementation Content

-(id)initWithPrimaryKey:(NSNumber *) primaryKey{
	if ((self = [self init])){
		fk_ToNotesInListTable = nil;
		fk_ToControlTable = nil;
		self.pk = primaryKey;
	}
	return self;
}

#pragma mark Properties

-(void)dealloc {
	text = nil;
	numeric = nil;
	fk_ToControlTable = nil;
	fk_ToNotesInListTable = nil;
}

-(NSNumber *)fk_ToNotesInListTable {
	if(fk_ToNotesInListTable == nil){
		fk_ToNotesInListTable  = [[SQLiteDB sharedDatabase]
								  getValueFromThisTable:@"ContentInNoteAndControl" 
								  usingThisSelectStatement:[NSString stringWithFormat:@"SELECT fk_ToNotesInListTable FROM ContentInNoteAndControl WHERE pk = %@", self.pk]];
        if((NSNull *)fk_ToNotesInListTable == [NSNull null])
            fk_ToNotesInListTable = nil;
		
		return fk_ToNotesInListTable;
	}
	else
		return fk_ToNotesInListTable;
}

-(void)setFk_ToNotesInListTable:(NSNumber *)aNumber {
	if (!fk_ToNotesInListTable && !aNumber) return;
	[[SQLiteDB sharedDatabase] updateNumberInThisTable:@"ContentInNoteAndControl" 
										  inThisColumn:@"fk_ToNotesInListTable" 
										 withThisValue:aNumber 
							   usingThisWhereStatement:[NSString stringWithFormat:@"WHERE pk = %@", self.pk]];
	
	fk_ToNotesInListTable = nil;
	fk_ToNotesInListTable = aNumber;
}

-(NSNumber *)fk_ToControlTable {
	if(fk_ToControlTable == nil){
		fk_ToControlTable  = [[SQLiteDB sharedDatabase]
							  getValueFromThisTable:@"ContentInNoteAndControl" 
							  usingThisSelectStatement:[NSString stringWithFormat:@"SELECT fk_ToControlTable FROM ContentInNoteAndControl WHERE pk = %@", self.pk]];
        if((NSNull *)fk_ToControlTable == [NSNull null])
            fk_ToControlTable = nil;
		
		return fk_ToControlTable;
	}
	else
		return fk_ToControlTable;
}

-(void)setFk_ToControlTable:(NSNumber *)aNumber {
	if (!fk_ToControlTable && !aNumber) return;
	[[SQLiteDB sharedDatabase] updateNumberInThisTable:@"ContentInNoteAndControl" 
										  inThisColumn:@"fk_ToControlTable" 
										 withThisValue:aNumber 
							   usingThisWhereStatement:[NSString stringWithFormat:@"WHERE pk = %@", self.pk]];
	
	fk_ToControlTable = nil;
	fk_ToControlTable = aNumber;
}

-(NSString *)text {
	if(text == nil){
		text = [[SQLiteDB sharedDatabase]
				getValueFromThisTable:@"ContentInNoteAndControl" 
				usingThisSelectStatement:[NSString stringWithFormat:@"SELECT ContentTextValue FROM ContentInNoteAndControl WHERE pk = %@", self.pk]];
        if((NSNull *)text == [NSNull null])
            text = nil;
		return text;
	}
	else
		return text;
}

-(void)setText:(NSString *)aString {
	if ((!text && !aString) || (text && aString && [text isEqualToString:aString])) return;
	[[SQLiteDB sharedDatabase] updateStringInThisTable:@"ContentInNoteAndControl"
										  inThisColumn:@"ContentTextValue"
										 withThisValue:aString
							   usingThisWhereStatement:[NSString stringWithFormat:@"WHERE pk = %@", self.pk]];
	
	text = nil;
	text = aString;
}

-(NSNumber *)numeric {
	if(numeric == nil){
		numeric  = [[SQLiteDB sharedDatabase]
					getValueFromThisTable:@"ContentInNoteAndControl" 
					usingThisSelectStatement:[NSString stringWithFormat:@"SELECT ContentNumValue FROM ContentInNoteAndControl WHERE pk = %@", self.pk]];
        if((NSNull *)numeric == [NSNull null])
            numeric = nil;
		return numeric;
	}
	else
		return numeric;
}

-(void)setNumeric:(NSNumber *)aNumber {
	if (!numeric && !aNumber) return;
	[[SQLiteDB sharedDatabase] updateNumberInThisTable:@"ContentInNoteAndControl" 
										  inThisColumn:@"ContentNumValue" 
										 withThisValue:aNumber 
							   usingThisWhereStatement:[NSString stringWithFormat:@"WHERE pk = %@", self.pk]];
	numeric = nil;
	numeric = aNumber;
}

-(UIImage *)getImageFromFileSystem {
    UIImage *tempImage = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *userDirectory = [[paths objectAtIndex:0] stringByAppendingFormat:@"/User/"];
	BOOL directoryExists = [fileManager fileExistsAtPath:userDirectory];
	NSError *err;
	if(directoryExists == NO)
		[fileManager createDirectoryAtPath:userDirectory
			   withIntermediateDirectories:NO
								attributes:nil error:&err];
    NSString *fn_full = [NSString stringWithFormat:@"%@%@/ImageContent/%@_full.png",
                         userDirectory, self.note.notebook.pk, self.pk];
    if ([[NSFileManager defaultManager] fileExistsAtPath:fn_full]){
        NSData *imageData = [[NSData alloc] initWithContentsOfFile:fn_full];
        tempImage = [UIImage imageWithData:imageData];
        
        if(tempImage != nil){
            NSData *imageData = UIImagePNGRepresentation(tempImage);
            [[SQLiteDB sharedDatabase] updateDataInThisTable:@"ContentInNoteAndControl" 
                                                inThisColumn:@"ContentNumValue" 
                                               withThisValue:imageData 
                                     usingThisWhereStatement:[NSString stringWithFormat:@"WHERE pk = %@", self.pk]];
        }
        else{
            [[SQLiteDB sharedDatabase] updateDataInThisTable:@"ContentInNoteAndControl" 
                                                inThisColumn:@"ContentNumValue" 
                                               withThisValue:nil 
                                     usingThisWhereStatement:[NSString stringWithFormat:@"WHERE pk = %@", self.pk]];
        }
    }
    return tempImage;
}

-(UIImage *)image {
	if(_image == nil){
		NSData *imageData = [[SQLiteDB sharedDatabase]
                             getValueFromThisTable:@"ContentInNoteAndControl" 
                             usingThisSelectStatement:[NSString stringWithFormat:@"SELECT ContentNumValue FROM ContentInNoteAndControl WHERE pk = %@", self.pk]];
        if((NSNull *)imageData == [NSNull null])
            _image = nil;
        else{
            _image = [UIImage imageWithData:imageData];
        }
        if(!_image)
            _image = [self getImageFromFileSystem];
        
		return _image;
	}
	else
		return _image;
}

-(void)setImage:(UIImage *)aImage {
	if(aImage != nil){
        CGSize newSize = CGSizeMake(300, 400);
        UIGraphicsBeginImageContext(newSize);
        [aImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
        UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
		NSData *imageData = UIImagePNGRepresentation(newImage);
        [[SQLiteDB sharedDatabase] updateDataInThisTable:@"ContentInNoteAndControl" 
                                            inThisColumn:@"ContentNumValue" 
                                           withThisValue:imageData 
                                 usingThisWhereStatement:[NSString stringWithFormat:@"WHERE pk = %@", self.pk]];
		_image = aImage;
	}
	else{
        [[SQLiteDB sharedDatabase] updateDataInThisTable:@"ContentInNoteAndControl" 
                                            inThisColumn:@"ContentNumValue" 
                                           withThisValue:nil 
                                 usingThisWhereStatement:[NSString stringWithFormat:@"WHERE pk = %@", self.pk]];
		_image = nil;
	}
    
    NSFileManager *fm = [NSFileManager defaultManager];
    [fm removeItemAtPath:self.note.thumbnailCacheFilename error:nil];
}

-(Control *)control {
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"pk = %@", self.fk_ToControlTable];
	NSArray *listOfControlsThatMatch = [self.note.notebook.listOfControls filteredArrayUsingPredicate:predicate];
	if([listOfControlsThatMatch count] == 1)
		return [listOfControlsThatMatch objectAtIndex:0];
	else
		return nil;
}

-(NSString *)toString{
	if([self.control.type isEqualToString:@"Numeric"]){
		return [self.numeric stringValue];
	}
	if([self.control.type isEqualToString:@"List"]){
		ListControl *lc = (ListControl *)self.control;
		NSString *temp = [lc toStringFromThisContent:self];
		return temp;
	}
	if([self.control.type isEqualToString:@"Currency"]){
		NSNumberFormatter *numfor = [[NSNumberFormatter alloc] init];
		[numfor setNumberStyle:NSNumberFormatterCurrencyStyle];
		NSString *temp = [numfor stringFromNumber:self.numeric];
		return temp;
	}
	if([self.control.type isEqualToString:@"Date"]){
		NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:[self.numeric doubleValue]];
		NSDateFormatter *df = [[NSDateFormatter alloc] init];
		df.dateStyle = NSDateFormatterLongStyle;
		NSString *tempFormattedDate = [df stringFromDate:date];
		return tempFormattedDate;
	}
	if([self.control.type isEqualToString:@"100PointScale"]){
        if(!self.numeric)
            return nil;
        else{
            NSString *temp = [NSString stringWithFormat:@"%@ Out of 100", self.numeric];
            return temp;
        }
	}
    if([self.control.type isEqualToString:@"Picture"])
        return nil;
    
	return self.text;
}

-(NSString *)toHTML{
    NSMutableString *htmlString = [[NSMutableString alloc] init];
    [htmlString appendString:[NSString stringWithFormat:@"<h3>%@</h3><p>", self.control.title]];
    [htmlString appendString:[self toString]];
    [htmlString appendString:@"</p>"];
    
    return htmlString;
}

@end
