//
//  RatingsEditor.h
//  TastingNotes
//
//  Created by Matthew Campbell on 9/20/12.
//
//

#import <Foundation/Foundation.h>
#import "ContentTableViewCell.h"

@interface RatingsEditor : ContentTableViewCell

@property(weak, nonatomic) IBOutlet UILabel *titleLabel;
@property(weak, nonatomic) IBOutlet UIButton *button1;
@property(weak, nonatomic) IBOutlet UIButton *button2;
@property(weak, nonatomic) IBOutlet UIButton *button3;
@property(weak, nonatomic) IBOutlet UIButton *button4;
@property(weak, nonatomic) IBOutlet UIButton *button5;
@property(weak, nonatomic) UIImage *starImage;
@property(weak, nonatomic) UIImage *emptyStarImage;
@property(nonatomic, assign) BOOL isEditingNote;

-(void) populate;
-(IBAction) rateOne;
-(IBAction) rateTwo;
-(IBAction) rateThree;
-(IBAction) rateFour;
-(IBAction) rateFive;

@end
