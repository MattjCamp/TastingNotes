//
//  ControlNameEditor.h
//  TastingNotes
//
//  Created by Matthew Campbell on 2/7/11.
//  Copyright 2011 App Shop LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Control.h"

@interface ControlNameEditor : UIViewController

@property(nonatomic, strong) Control *control;
@property(nonatomic, strong) IBOutlet UITextView *textView;

@end
