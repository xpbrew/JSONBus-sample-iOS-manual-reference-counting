//
//  JSONBusSampleAppDelegate.m
//  JSONBusSample
//
//  Created by Brodyspark on 1/2/13.
//

#import "JSONBusSampleAppDelegate.h"

@implementation JSONBusSampleAppDelegate

- (void)dealloc
{
    [_window release];
    [_myview release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];

    // Override point for customization after application launch.
    self.myview = [[[UIWebView alloc] initWithFrame:[self.window bounds]] autorelease];
    [self.window addSubview:self.myview];
    self.myview.delegate = self;

    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"www"];
    NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self.myview loadHTMLString:html baseURL:nil];

    [self.window makeKeyAndVisible];

    return YES;
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([[[request URL]absoluteString] hasPrefix:@"jsonrequest:"]) {
        NSString *s1 = [[[request URL] absoluteString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSLog(@"JSON: %@", s1);

        NSString *js = [s1 substringFromIndex:12];
        NSLog(@"decoding js: %@", js);
        NSData *d = [js dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *j = [NSJSONSerialization JSONObjectWithData:d options:kNilOptions error:nil];
        NSLog(@"jsonrequest: %@", j);
        NSLog(@"jsonrequest[\"a\"]: %@", [j objectForKey:@"a"]);

        [self.myview stringByEvaluatingJavaScriptFromString:@"window.testcb('{b:2}')"];

        return NO;
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
