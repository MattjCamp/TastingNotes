//
//  Analytics.m
//  TastingNotes
//
//  Created by Matthew Campbell on 10/5/12.
//
//

#import "Analytics.h"
#import "GANTracker.h"

@implementation Analytics
static Analytics *_sharedAnalytics = nil;

+(id)sharedAnalytics {
    @synchronized(self) {
        if(_sharedAnalytics == nil)
            _sharedAnalytics = [[super allocWithZone:NULL] init];
    }
    return _sharedAnalytics;
}

-(id)init {
    if ((self = [super init])){
        self.backgroundQueue = [[NSOperationQueue alloc] init];
    }
    return self;
}

-(void)startTracking{
    [self.backgroundQueue addOperationWithBlock:^{
        [[GANTracker sharedTracker] startTrackerWithAccountID:@"UA-35331153-1"
                                               dispatchPeriod:10
                                                     delegate:nil];
        NSLog(@"Tracker started");
    }];
}

-(void)stopTracking{
    [self.backgroundQueue addOperationWithBlock:^{
        [[GANTracker sharedTracker] stopTracker];
        NSLog(@"Tracker stopped");
    }];
}

-(void)thisPageWasViewed:(NSString *)pageTitle{
    [self.backgroundQueue addOperationWithBlock:^{
        NSError *error = nil;
        if (![[GANTracker sharedTracker] trackPageview:pageTitle
                                             withError:&error]) {
            NSLog(@"GANTracker trackPageview error = %@", error);
        }
    }];
}

-(void)thisUserActionOccured:(NSString *)actionName forThisCategory:(NSString *)category thisValue:(int)value{
    [self.backgroundQueue addOperationWithBlock:^{
        NSError *error = nil;
        if (![[GANTracker sharedTracker] trackEvent:@"User Actions"
                                             action:actionName
                                              label:category
                                              value:value
                                          withError:&error]) {
            NSLog(@"GANTracker trackEvent error = %@", error);
        }
    }];
}

-(void)dispatchSynchronously{
    [self.backgroundQueue addOperationWithBlock:^{
        [[GANTracker sharedTracker] dispatchSynchronous:10];
        NSLog(@"Tracking dispatched");
    }];
}

- (void)dealloc {
    //[self stopTracking];
}

@end