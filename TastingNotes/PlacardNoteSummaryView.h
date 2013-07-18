//
//  PlacardNoteSummaryView.h
//  TastingNotes
//
//  Created by Matthew Campbell on 9/27/12.
//
//

#import <UIKit/UIKit.h>
#import "AppContent.h"

@interface PlacardNoteSummaryView : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *noteThumbnail;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (strong, nonatomic) Notebook *notebook;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end