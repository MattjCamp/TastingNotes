//
//  List.h
//  TastingNotes
//
//  Created by Matthew Campbell on 3/10/11.
//  Copyright 2011 App Shop LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Control.h"
#import "ListItem.h"

@class ListItem, Content, AppContent, Notebooks;

@interface ListControl : Control {
	NSMutableArray *_listItems;
}

@property(nonatomic, strong, readonly) NSMutableArray *listItems;

-(id)initWithPrimaryKey:(NSNumber *) primaryKey inThisSection:(Section *)parentSection;

-(void)addListItemToThisListControl;
-(void)removeThisListItem:(ListItem *)listItem;
-(NSString *)toStringFromThisContent:(Content *)content;

@end