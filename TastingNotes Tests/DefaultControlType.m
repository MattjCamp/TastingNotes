//
//  DefaultControlType.m
//  TastingNotes
//
//  Created by Matt on 4/30/14.
//  Copyright (c) 2014 Mobile App Mastery. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppContent.h"

@interface DefaultControlType : XCTestCase

@property AppContent* ac;
@property Notebook* notebook;
@property NSMutableString* log;

@end

@implementation DefaultControlType

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

-(void)testControlTypeDefaultValue{
    [self.notebook addControlToThisNotebook];
    Control *c = [[self.notebook listOfControls] lastObject];
    XCTAssertNotNil(c.type, @"Control default type not being specified");
    
}

@end