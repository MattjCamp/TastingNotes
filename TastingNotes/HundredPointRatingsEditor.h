//
//  HundredPointRatingsEditor.h
//  TastingNotes
//
//  Created by Matthew Campbell on 9/20/12.
//
//

#import <Foundation/Foundation.h>
#import "ContentTableViewCell.h"

@interface HundredPointRatingsEditor : ContentTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *controlLabel;
@property (weak, nonatomic) IBOutlet UISlider *ratingSlider;

-(IBAction)ratingSliderAction:(id)sender;
-(void)updateUI;

@end
