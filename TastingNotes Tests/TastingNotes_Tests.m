//
//  TastingNotes_Tests.m
//  TastingNotes Tests
//
//  Created by Matt on 4/10/14.
//  Copyright (c) 2014 Mobile App Mastery. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppContent.h"
#import "Section+TesterHelp.h"

@interface TastingNotes_Tests : XCTestCase

@property AppContent* ac;
@property Notebook* notebook;
@property NSMutableString* log;

@end

@implementation TastingNotes_Tests

-(void)setUp{
    [super setUp];
    self.log = [[NSMutableString alloc]init];
    self.ac = [AppContent sharedContent];
    self.ac.noteBookType = Wine;
    [self.ac setUpInititalNotebook];
    self.notebook = [self.ac activeNotebook];
}

-(void)tearDown{
    [super tearDown];
    [self.log writeToFile:@"/Users/matt/Desktop/log.txt"
               atomically:YES
                 encoding:NSStringEncodingConversionAllowLossy
                    error:nil];
    [self.ac resetNotebookData];
}

-(void)testContentCreation{
    XCTAssertNotNil(self.ac, @"App Content not getting created");
    XCTAssert([self.notebook.name isEqualToString:@"Wines"], @"%@ is not the right notebook name", self.notebook.name);
}

-(void)testImageThumbnail{
    [self.notebook addNoteToThisNotebook];
    Note* n = [[self.notebook listOfNotes]lastObject];
    Section *s = [self.notebook.listOfSections objectAtIndex:0];
    Control *control = [s.listOfControls objectAtIndex:2];
    [n addContentToThisControl:control];
    Content *content = [n contentInThisControl:control];
    NSLog(@"content = %@", content);
    XCTAssertNil(n.thumbnail, @"Thumbnail image should initially be nil");
}

@end
