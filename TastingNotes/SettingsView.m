//
//  SettingsView.m
//  TastingNotes
//
//  Created by Matthew Campbell on 9/13/12.
//
//

#import "SettingsView.h"
#import "Analytics.h"

@implementation SettingsView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [[Analytics sharedAnalytics] thisPageWasViewed:NSStringFromClass([self class])];
}

@end