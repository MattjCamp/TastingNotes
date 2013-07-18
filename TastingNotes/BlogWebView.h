//
//  BlogWebView.h
//  TastingNotes
//
//  Created by Matthew Campbell on 9/18/12.
//
//

#import <Foundation/Foundation.h>

@interface BlogWebView : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *wv;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end