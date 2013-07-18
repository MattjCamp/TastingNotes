//
//  NoteTextEditor.h
//  TastingNotes
//
//  Created by Matthew Campbell on 9/19/12.
//
//

#import <Foundation/Foundation.h>
#import "ContentTableViewCell.h"

@interface NoteTextEditor : ContentTableViewCell<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *noteTextView;
@property (weak, nonatomic) IBOutlet UILabel *noteControlTitle;

@end
