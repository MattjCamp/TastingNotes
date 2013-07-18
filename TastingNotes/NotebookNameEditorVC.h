//
//  NotebookNameEditorVC.h
//  TastingNotes
//
//  Created by Matthew Campbell on 2/5/11.
//  Copyright 2011 App Shop LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Notebook.h"

@interface NotebookNameEditorVC : UIViewController<UITextViewDelegate>

@property(nonatomic, strong) Notebook *notebook;
@property(nonatomic, strong) IBOutlet UITextView *textView;

@end