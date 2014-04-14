//
//  SQLite_Tests.m
//  TastingNotes
//
//  Created by Matt on 4/14/14.
//  Copyright (c) 2014 Mobile App Mastery. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppContent.h"
#import "Section+TesterHelp.h"
#import "Notebook+Inspector.h"

@interface SQLite_Tests : XCTestCase

@property AppContent* ac;
@property Notebook* notebook;
@property NSMutableString* log;

@end

@implementation SQLite_Tests

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
    [self.log writeToFile:@"/Users/matt/Desktop/SQLite_Tests_log.txt"
               atomically:YES
                 encoding:NSStringEncodingConversionAllowLossy
                    error:nil];
    NSLog(@"log = %@", self.log);
}

-(void)testContentCreation{
    XCTAssertNotNil(self.ac, @"App Content not getting created");
    XCTAssert([self.notebook.name isEqualToString:@"Wines"], @"%@ is not the right notebook name", self.notebook.name);
    [self.notebook logStateToThisString:self.log];
}

@end
