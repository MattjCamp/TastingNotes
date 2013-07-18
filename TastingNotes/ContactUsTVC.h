//
//  ContactUsTVC.h
//  TastingNotes
//
//  Created by Matthew Campbell on 9/18/12.
//
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface ContactUsTVC : UITableViewController<UIWebViewDelegate,MFMailComposeViewControllerDelegate,UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *aweberWebView;

@end