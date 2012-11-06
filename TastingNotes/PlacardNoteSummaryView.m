//
//  PlacardNoteSummaryView.m
//  TastingNotes
//
//  Created by Matthew Campbell on 9/27/12.
//
//

#import "PlacardNoteSummaryView.h"
#import <QuartzCore/QuartzCore.h>

@implementation PlacardNoteSummaryView

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [[self.containerView layer] setCornerRadius:8.0f];
    [[self.containerView layer] setMasksToBounds:YES];
    [[self.noteThumbnail layer] setCornerRadius:8.0f];
    [[self.noteThumbnail layer] setMasksToBounds:YES];
    
    Control *ct = [self.notebook placardTitleControl];
    Control *cd1 = [self.notebook placardDetail1Control];
    Control *cd2 = [self.notebook placardDetail2Control];
    Control *cd3 = [self.notebook placardDetail3Control];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if(ct.title){
            NSDictionary *titleAttributes = @{ NSFontAttributeName : [UIFont boldSystemFontOfSize:14.0f]};
            self.titleLabel.attributedText = [[NSMutableAttributedString alloc] initWithString:ct.title
                                                                                    attributes:titleAttributes];
        }
        NSDictionary *detailAttributes = @{ NSFontAttributeName : [UIFont systemFontOfSize:12.0f]};
        NSMutableAttributedString *detailString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@\n%@\n", cd1.title,cd2.title,cd3.title]
                                                                                         attributes:detailAttributes];
        self.detailLabel.attributedText = detailString;
    });
}

@end