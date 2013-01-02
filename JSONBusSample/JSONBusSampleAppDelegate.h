//
//  JSONBusSampleAppDelegate.h
//  JSONBusSample
//
//  Created by Brodyspark on 1/2/13.
//

#import <UIKit/UIKit.h>

@interface JSONBusSampleAppDelegate : UIResponder <UIApplicationDelegate, UIWebViewDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UIWebView *myview;

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;

@end
