//
//  BackupView.h
//  TastingNotes
//
//  Created by Matthew Campbell on 9/13/12.
//
//

#import <Foundation/Foundation.h>
#import "DropboxBackup.h"

@interface BackupView : UIViewController

@property(assign)DropboxBackup *dropbox;
@property (weak, nonatomic) IBOutlet UITextView *statusTextView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIButton *linkButton;
@property (weak, nonatomic) IBOutlet UIButton *backupButton;
@property (weak, nonatomic) IBOutlet UIButton *restoreButton;

- (IBAction)linkToDropbox:(id)sender;
- (IBAction)restoreAction:(id)sender;
- (IBAction)backupAction:(id)sender;
-(void)refreshScene;

@end