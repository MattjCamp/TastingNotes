//
//  ContactUsTVC.m
//  TastingNotes
//
//  Created by Matthew Campbell on 9/18/12.
//
//

#import "ContactUsTVC.h"

@implementation ContactUsTVC
@synthesize aweberWebView;

-(void)viewDidLoad{
    [super viewDidLoad];
    NSString *awebercode = [NSString stringWithContentsOfFile:[NSString stringWithFormat:@"%@%@", [[NSBundle mainBundle] resourcePath], @"/aweberform_iphone.html"] encoding:NSStringEncodingConversionAllowLossy error:nil];
    [self.aweberWebView loadHTMLString:awebercode baseURL:nil];
}

- (void)viewDidUnload {
    [self setAweberWebView:nil];
    [super viewDidUnload];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        if([MFMailComposeViewController canSendMail]){
            MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
            picker.mailComposeDelegate = self;
            [picker setSubject:@"About Tasting Notes"];
            [picker setToRecipients:@[ @"support@mobileappmastery.com" ]];
            [self presentViewController:picker
                               animated:YES
                             completion:nil];
        }
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
		  didFinishWithResult:(MFMailComposeResult)result
						error:(NSError*)error {
	[self dismissViewControllerAnimated:YES
                             completion:nil];
}

@end