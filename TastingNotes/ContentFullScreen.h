//
//  ContentFullScreen.h
//  TastingNotes
//
//  Created by Matthew Campbell on 9/20/12.
//
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "AppContent.h"

@interface ContentFullScreen : UIViewController{
@public
    void (^_updateBlock)();
}

@property(nonatomic, strong) Content *content;

-(void)addUpdateBlock:(void (^)())updateBlock;

@end