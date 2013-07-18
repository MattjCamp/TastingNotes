//
//  Analytics.h
//  TastingNotes
//
//  Created by Matthew Campbell on 10/5/12.
//
//

#import <Foundation/Foundation.h>

@interface Analytics : NSObject

+(id)sharedAnalytics;

@property(nonatomic, strong)NSOperationQueue *backgroundQueue;
@property(nonatomic, strong)NSString *webPropertyID;

-(void)startTracking;
-(void)stopTracking;
-(void)dispatchSynchronously;
-(void)thisPageWasViewed:(NSString *)pageTitle;
-(void)thisUserActionOccured:(NSString *)actionName forThisCategory:(NSString *)category thisValue:(int)value;

@end