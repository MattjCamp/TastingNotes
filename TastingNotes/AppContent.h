//
//  RootModel.h
//  TastingNotes
//
//  Created by Matthew Campbell on 2/3/11.
//  Copyright 2011 App Shop LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLiteDB.h"
#import "Notebook.h"
#import "Notebooks.h"

@protocol AppContentDelegate <NSObject>

-(void) notebookDataJustReset;

@end

@interface AppContent : NSObject {
	BOOL databaseIsInitialized;
	NSNumber *databaseVersion;
	NSString *appType;
    NSString *_cacheDirectory;
}

+(id) sharedContent;

@property(nonatomic, assign) BOOL databaseIsInitialized;
@property(nonatomic, strong) NSNumber *databaseVersion;
@property(nonatomic, strong) NSString *appType;
@property(nonatomic, strong) Notebooks *notebooks;
@property (unsafe_unretained) id <AppContentDelegate> delegate;
@property(nonatomic, strong) Notebook *activeNotebook;
@property(nonatomic, strong) NSMutableDictionary *userSettings;
@property(nonatomic, assign)NotebookType noteBookType;

-(void)setUpInititalNotebook;
-(void)resetNotebookData;

-(NSString *)cacheDirectory;
-(NSString *)cssFileCache;

@end
