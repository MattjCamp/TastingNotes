//
//  BlogWebView.m
//  TastingNotes
//
//  Created by Matthew Campbell on 9/18/12.
//
//

#import "BlogWebView.h"

@implementation BlogWebView

-(void)viewDidLoad{
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:@"http://tastingnotesapp.com/#Blog"];
    NSURLRequest *r = [NSURLRequest requestWithURL:url];
    [self.wv loadRequest:r];
}

- (void)viewDidUnload {
    [self setWv:nil];
    [self setActivityIndicator:nil];
    [super viewDidUnload];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    self.activityIndicator.hidden = YES;
    [self.activityIndicator stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [webView loadHTMLString:[NSString stringWithFormat:@"Error loading blog:%@", error] baseURL:nil];
}

@end