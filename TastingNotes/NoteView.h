//
//  NoteView.h
//  TastingNotes
//
//  Created by Matthew Campbell on 9/18/12.
//
//

#import <Foundation/Foundation.h>
#import "AppContent.h"

@interface NoteView : UIViewController<UITableViewDataSource, UITableViewDelegate, UIWebViewDelegate>

@property(nonatomic, strong) Note *note;
@property (weak, nonatomic) IBOutlet UITableView *tv;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *socialButton;

- (IBAction)socialButtonAction:(id)sender;

@end