//
//  SectionNameEditor.h
//  TastingNotes
//
//  Created by Matthew Campbell on 2/7/11.
//  Copyright 2011 App Shop LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Section.h"

@interface SectionNameEditor : UIViewController

@property(nonatomic, strong) Section *section;
@property(nonatomic, strong) IBOutlet UITextView *textView;

@end

