//
//  Notebooks.h
//  TastingNotes
//
//  Created by Matthew Campbell on 2/3/11.
//  Copyright 2011 App Shop LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLiteDB.h"
#import "Notebook.h"
#import "ListControl.h"

typedef enum notebooktype{
    Wine,
    Beer,
	Whiskey,
	Cigars,
	Coffee,
	Tea,
    GeneralNote
} NotebookType;

@interface Notebooks : NSObject {
	NSMutableArray *listOfNotebooks;
}

@property(nonatomic, strong, readonly) NSMutableArray *listOfNotebooks;

-(void)addNewNotebookWithThisName:(NSString *)newTableName;
-(void)addNewNotebookWithThisType:(NotebookType)notebooktype;
-(void)removeThisNotebook:(Notebook *)notebookToRemove;
-(void)moveNotebookAtThisIndex:(int)fromIndex toThisIndex:(int)toIndex;
-(void)populateThisListControl:(ListControl *)listControl;
-(void)resetData;

@end
