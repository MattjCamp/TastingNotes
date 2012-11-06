//
//  BackupView.m
//  TastingNotes
//
//  Created by Matthew Campbell on 9/13/12.
//
//

#import "BackupView.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@implementation BackupView
@synthesize linkButton;
@synthesize backupButton;
@synthesize restoreButton;

-(void)viewDidLoad{
    [super viewDidLoad];
    self.progressView.hidden = YES;
    self.dropbox = [DropboxBackup sharedDropbox];
    [self.dropbox startSessionThenDoThisWhenReady:^{
        [self refreshScene];
    }];
    [[self.statusTextView layer] setCornerRadius:8.0f];
    [[self.statusTextView layer] setMasksToBounds:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (IBAction)linkToDropbox:(id)sender {
    [self.dropbox linkFromViewController:self thenDoThisWhenDone:^{
        [self refreshScene];
    }];
}

-(void)refreshScene{
    self.statusTextView.text = nil;
    
    if(![[DBSession sharedSession] isLinked]){
        [self.linkButton setTitle:@"Link To Your Dropbox"
                         forState:UIControlStateNormal];
        self.backupButton.enabled = NO;
        self.restoreButton.enabled = NO;
        self.backupButton.alpha = .25;
        self.restoreButton.alpha = .25;
    }
    else{
        [self.linkButton setTitle:@"Disconnect From Your Dropbox"
                         forState:UIControlStateNormal];

        
        self.backupButton.enabled = YES;
        self.restoreButton.enabled = YES;
        self.backupButton.alpha = 1;
        self.restoreButton.alpha = 1;
    }
    if(self.dropbox.databaseMetadata){
        self.statusTextView.text = [NSString stringWithFormat:@"Last backup was %@ (revision %@)", self.dropbox.databaseMetadata.lastModifiedDate, self.dropbox.databaseMetadata.rev];
        self.backupButton.enabled = YES;
        self.restoreButton.enabled = YES;
        self.backupButton.alpha = 1;
        self.restoreButton.alpha = 1;
    }
}

- (IBAction)restoreAction:(id)sender {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate lockEditingWhileDoingDatabaseRestore];
    self.progressView.hidden = NO;
    self.statusTextView.text = @"Your database restore is in progress - while you may view your current notebooks you may not edit them until the restore is complete";
    [self.dropbox restoreDatabaseAndDoThisWhileWorking:^(float progress) {
        self.progressView.progress = progress;
        NSNumberFormatter *numfor = [[NSNumberFormatter alloc] init];
		[numfor setNumberStyle:NSNumberFormatterPercentStyle];
        NSNumber *percentComplete = [NSNumber numberWithFloat:progress];
        self.navigationController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%@", [numfor stringFromNumber:percentComplete]];
        
    } thenDoThisWhenDone:^{
        [appDelegate unlockEditingAfterDoingDatabaseRestore];
        self.statusTextView.text = @"Your database restore is complete - you should now see content from your backup database and you should be able to edit your notebooks again";
        self.progressView.hidden = YES;
        self.navigationController.tabBarItem.badgeValue = nil;
    }];
}

- (IBAction)backupAction:(id)sender {
    [self.dropbox backupDatabaseAndDoThisWhileWorking:^(float progress) {
        self.progressView.progress = progress;
        NSNumberFormatter *numfor = [[NSNumberFormatter alloc] init];
		[numfor setNumberStyle:NSNumberFormatterPercentStyle];
        NSNumber *percentComplete = [NSNumber numberWithFloat:progress];
        self.navigationController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%@", [numfor stringFromNumber:percentComplete]];
    } thenDoThisWhenDone:^{
        self.statusTextView.text = @"Your database backup is complete";
        self.progressView.hidden = YES;
        self.navigationController.tabBarItem.badgeValue = nil;
    }];
}

- (void)viewDidUnload {
    [self setProgressView:nil];
    [self setStatusTextView:nil];
    [self setLinkButton:nil];
    [self setBackupButton:nil];
    [self setRestoreButton:nil];
    [super viewDidUnload];
}

@end
