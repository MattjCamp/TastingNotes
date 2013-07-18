//
//  ImageEditro.h
//  TastingNotes
//
//  Created by Matthew Campbell on 9/20/12.
//
//

#import <Foundation/Foundation.h>
#import "ContentTableViewCell.h"

@interface ImageEditor : ContentTableViewCell

@property(nonatomic, assign) IBOutlet UILabel *controlLabel;
@property(nonatomic, assign) IBOutlet UIImageView *contentImage;

@end