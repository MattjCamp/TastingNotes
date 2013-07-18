//
//  NoteSummaryTableViewCell.h
//  TastingNotes
//
//  Created by Matthew Campbell on 9/13/12.
//
//

#import <UIKit/UIKit.h>
#import "AppContent.h"

@interface NoteSummaryTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *noteThumbnail;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (strong, nonatomic) Note *note;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end