//
//  ListEditorListItemCell.h
//  TastingNotes
//
//  Created by Matthew Campbell on 9/25/12.
//
//

#import "ContentTableViewCell.h"

@interface ListEditorListItemCell : ContentTableViewCell<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *noteTextField;
@property (strong, nonatomic) ListItem *li;
@property (strong, nonatomic) IBOutlet UIView *checkboxView;

@end
