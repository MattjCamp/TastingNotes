//
//  Section.h
//  TastingNotes
//
//  Created by Matthew Campbell on 2/3/11.
//  Copyright 2011 App Shop LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLiteDB.h"
#import "Control.h"
#import "ListControl.h"

@interface Section : NSObject {
	NSString *name;
	NSNumber *order;
    NSMutableArray *listOfControls;
}

@property (nonatomic, strong) NSNumber *pk;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *order;
@property(nonatomic, strong, readonly) NSMutableArray *listOfControls;

-(id)initWithPrimaryKey:(NSNumber *) primaryKey;

@end
