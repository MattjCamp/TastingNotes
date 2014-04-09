//
//  NoteSummaryTableViewCell.m
//  TastingNotes
//
//  Created by Matthew Campbell on 9/13/12.
//
//

#import "NoteSummaryTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation NoteSummaryTableViewCell

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    //self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [[self.containerView layer] setCornerRadius:8.0f];
    [[self.containerView layer] setMasksToBounds:YES];
    [[self.noteThumbnail layer] setCornerRadius:8.0f];
    [[self.noteThumbnail layer] setMasksToBounds:YES];
    
    self.noteThumbnail.image = nil;
    self.titleLabel.text = nil;
    self.detailLabel.text = nil;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSDictionary *titleAttributes = @{ NSFontAttributeName : [UIFont boldSystemFontOfSize:14.0f]};
        NSDictionary *detailAttributes = @{ NSFontAttributeName : [UIFont systemFontOfSize:12.0f]};
        if(self.note.titleText)
            self.titleLabel.attributedText = [[NSMutableAttributedString alloc] initWithString:self.note.titleText
                                                                                    attributes:titleAttributes];
        if(self.note.detailText)
            self.detailLabel.attributedText = [[NSMutableAttributedString alloc] initWithString:self.note.detailText
                                                                                     attributes:detailAttributes];
        [UIView animateWithDuration:1.00 animations:^{
            self.noteThumbnail.alpha = 0;
            self.noteThumbnail.image = self.note.thumbnail;
            self.noteThumbnail.alpha = 1;
        }];
    });
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    if(editing){
        self.backgroundColor = [UIColor whiteColor];
    }
    else {
        self.backgroundColor = [UIColor clearColor];
    }
    [super setEditing:editing animated:animated];
}

@end