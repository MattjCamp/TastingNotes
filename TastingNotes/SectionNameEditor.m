//
//  SectionNameEditor.m
//  TastingNotes
//
//  Created by Matthew Campbell on 2/7/11.
//  Copyright 2011 App Shop LLC. All rights reserved.
//

#import "SectionNameEditor.h"

@implementation SectionNameEditor

-(void)viewDidLoad{
    UIBarButtonItem *updateNotebookNameButton = [[UIBarButtonItem alloc] 
                                                 initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                 target:self action:@selector(updateSectionName)];
    self.navigationItem.rightBarButtonItem = updateNotebookNameButton;
    
    self.title = @"Edit Name";
    self.textView.text = self.section.name;
    self.textView.keyboardAppearance = UIKeyboardAppearanceAlert;
    [self.textView becomeFirstResponder];
    [super viewDidLoad];
}

-(void)updateSectionName{
    self.section.name = self.textView.text;
    [self.navigationController popViewControllerAnimated:YES];
}

@end