//
//  ContentTableViewCell.h
//  TastingNotes
//
//  Created by Matthew Campbell on 9/20/12.
//
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "AppContent.h"

@interface ContentTableViewCell : UITableViewCell

@property(nonatomic, strong) Content *content;
@property(nonatomic, assign) BOOL isFreshContent;

@end
