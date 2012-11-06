//
//  NotebookNameEditorVC.m
//  TastingNotes
//
//  Created by Matthew Campbell on 2/5/11.
//  Copyright 2011 App Shop LLC. All rights reserved.
//

#import "NotebookNameEditorVC.h"

@implementation NotebookNameEditorVC

-(void)viewDidLoad{
    UIBarButtonItem *updateNotebookNameButton = [[UIBarButtonItem alloc] 
                                    initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                    target:self action:@selector(updateNotebookName)];
    self.navigationItem.rightBarButtonItem = updateNotebookNameButton;

    self.title = @"Edit Name";
    self.textView.text = self.notebook.name;
    self.textView.keyboardAppearance = UIKeyboardAppearanceAlert;
    [self.textView becomeFirstResponder];
    [super viewDidLoad];
}

-(void)updateNotebookName{
    self.notebook.name = self.textView.text;
    [self.navigationController popViewControllerAnimated:YES];
}

@end