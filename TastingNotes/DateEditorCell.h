//
//  DateEditorCell.h
//  TastingNotes
//
//  Created by Matthew Campbell on 9/21/12.
//
//

#import "ContentTableViewCell.h"

@interface DateEditorCell : ContentTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *controlLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)updateDateContent:(id)sender;

@end
