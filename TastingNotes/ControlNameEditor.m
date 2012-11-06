//
//  ControlNameEditor.m
//  TastingNotes
//
//  Created by Matthew Campbell on 2/7/11.
//  Copyright 2011 App Shop LLC. All rights reserved.
//

#import "ControlNameEditor.h"

@implementation ControlNameEditor

-(void)viewDidLoad{
    UIBarButtonItem *updateNotebookNameButton = [[UIBarButtonItem alloc] 
                                                 initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                 target:self action:@selector(updateControlName)];
    self.navigationItem.rightBarButtonItem = updateNotebookNameButton;
    
    self.title = @"Edit Name";
    self.textView.text = self.control.title;
    self.textView.keyboardAppearance = UIKeyboardAppearanceAlert;
    [self.textView becomeFirstResponder];
    [super viewDidLoad];
}

- (void)updateControlName{
    self.control.title = self.textView.text;
    [self.navigationController popViewControllerAnimated:YES];
}

@end