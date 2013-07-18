//
//  PlacardContentChooser.h
//  TastingNotes
//
//  Created by Matthew Campbell on 2/21/11.
//  Copyright 2011 App Shop LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Notebook.h"
#import "PlacardTopLevelEditor.h"

typedef enum placardInputType{
	Title,
	Detail1,
	Detail2,
	Detail3,
	Image
} InputType;

@interface PlacardContentChooser : UITableViewController

@property(nonatomic, strong) Notebook *notebook;
@property(nonatomic, assign) InputType inputType;

@end