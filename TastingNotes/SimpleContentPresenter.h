//
//  SimpleContentPresenter.h
//  TastingNotes
//
//  Created by Matthew Campbell on 9/21/12.
//
//

#import <Foundation/Foundation.h>
#import "ContentTableViewCell.h"

@interface SimpleContentPresenter : ContentTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *controlLabel;

@end
