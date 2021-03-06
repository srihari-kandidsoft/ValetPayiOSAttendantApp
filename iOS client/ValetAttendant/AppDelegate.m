//
//  AppDelegate.m
//  ValetAttendant
//
//  Created by techbasics on 3/14/14.
//  Copyright (c) 2014 techbasics. All rights reserved.
//

#import "AppDelegate.h"
#import "Reachability.h"
#define K_PREV_DEMO_VALUE @"0"

#define K_CURR_DEMO_VALUE @"K_CURR_DEMO_VALUE"

@implementation AppDelegate
{
    NSString *prevValue;
    
}
@synthesize window,mainNavigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //note: iOS only allows one crash reporting tool per app; if using another, set to: NO
    [Flurry setCrashReportingEnabled:YES];
    
    
    // Replace YOUR_API_KEY with the api key in the downloaded package
    
    [Flurry startSession:@"H5FJ2MFMCMCPKXTQCKJQ"];
[[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"IsNetworkReachabilityAlertVisible"];
    NSLog(@"dfdfdfdf%lu",(unsigned long)[[[NSUserDefaults standardUserDefaults]valueForKey:@"login"]length ]);
    // Override point for customization after application launch.
    if (![[[NSUserDefaults standardUserDefaults]valueForKey:@"login"]length ] || !([[NSUserDefaults standardUserDefaults]valueForKey:K_PREV_DEMO_VALUE]==[[NSUserDefaults standardUserDefaults]valueForKey:K_CURR_DEMO_VALUE])) {
        prevValue=[[NSUserDefaults standardUserDefaults]valueForKey:K_CURR_DEMO_VALUE];
        [[NSUserDefaults standardUserDefaults]setObject:prevValue  forKey:K_PREV_DEMO_VALUE];
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:K_PREV_DEMO_VALUE]);
        
        self.login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        self.mainNavigationController=[[UINavigationController alloc]initWithRootViewController:self.login];
        
        self.window.rootViewController = self.mainNavigationController;
    }
    else{
        
        //remove local value
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"last"];
        //set rootview controller
        RecentPaymentViewController *recent=[[RecentPaymentViewController alloc]initWithNibName:@"RecentPaymentViewController" bundle:nil];
        
        self.mainNavigationController = [[UINavigationController alloc]initWithRootViewController:recent];
        
        MenuViewController *menuViewController = [[MenuViewController alloc] init];
        
        self.container = [MFSideMenuContainerViewController
                          containerWithCenterViewController:[AppDelegate appDelegate].mainNavigationController
                          leftMenuViewController:menuViewController
                          rightMenuViewController:nil];
        
        self.mainNavigationController=[[UINavigationController alloc]initWithRootViewController:self.container];
        
        self.window.rootViewController = self.mainNavigationController;
        
        
    }
    self.mainNavigationController.navigationBarHidden=YES;
    [self.window makeKeyAndVisible];
    [self registerDefaultsFromSettingsBundle];
    return YES;
}
+(NSDictionary *)downLoadFrom:(NSString *)url parameters:(NSString *) para_str

{
    
    NSLog(@"the URL ---- >%@",url);
    //   NSLog(@"para meters -----> %@",para_str);
    NSString *url1;
    // NSString *parms;
    
    // NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //demo
    //  BOOL  enabled = [defaults boolForKey:@"enabled_preference"];
    // NSLog(@"url=======%hhd",enabled);
    
    //  if (enabled) {
    //      url1=[NSString stringWithFormat:@"http://api.valetpayapp.com/%@",url ];
    //      parms=[NSString stringWithFormat:@"%@&mode=demo",para_str];
    //      para_str=parms;
    //  }
    //  else
    //  {
    url1=[NSString stringWithFormat:@"http://api.valetpayapp.com/%@",url ];
    //        parms=[NSString stringWithFormat:@"%@&mode=demo",para_str];
    //        para_str=parms;
    //         NSLog(@"para meters -----> %@",para_str);
    
    // }
    //NSLog(@"url=======%@",url1);
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url1]];
    
    [request setHTTPMethod:@"POST"];
    
    // set headers
    
    NSString *contentType = [NSString stringWithFormat:@"application/x-www-form-urlencoded "];
    
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    
    // setup post string
    
    
    NSMutableString *postString = [[NSMutableString alloc] init];
    
    [postString appendFormat:@"%@",para_str];
    
    // Log the POST body
    
    //  NSLog(@"PostString: %@", postString);
    
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    
    // get response
    
    NSHTTPURLResponse *urlResponse = nil;
    
    NSError *error = [[NSError alloc] init];
    
    
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request
                            
                                                 returningResponse:&urlResponse
                            
                                                             error:&error];
    
    NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSLog(@"result-------%@",result);
    
    // NSLog(@"result-------%@",[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil]);
    
    
    
    
    return  [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
    
    
    
    // NSLog(@"Response code: %d", [urlResponse statusCode]);
    
    
    
    if ([urlResponse statusCode] >=200 && [urlResponse statusCode] <300)
        
    {
        
        NSLog(@"Response ==> %@", result);
        
        
        
        //[self performSelector:@selector(getuserevents) withObject:activityIndicator afterDelay:0.0];
        
        
    }
    
}


// Action for left Menu Button
- (void)leftSideMenuButtonPressed:(id)sender
{
    [self.container toggleLeftSideMenuCompletion:^{
    }];
}
+(AppDelegate*)appDelegate{
	return (AppDelegate*)[[UIApplication sharedApplication]delegate];
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    //remove local value
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"last"];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    //remove local value
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"last"];
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"IsNetworkReachabilityAlertVisible"];
    [self registerDefaultsFromSettingsBundle];
    
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

+(BOOL)isNetworkAvailable

{
    
    // *** Internet connection checking *** //
    
    Reachability *reach=[Reachability reachabilityWithHostName:@"www.google.com"];
    
    NetworkStatus internetStatus=[reach currentReachabilityStatus];
    
    if ((internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN))
        
    {
        if (![[NSUserDefaults standardUserDefaults]boolForKey:@"IsNetworkReachabilityAlertVisible"]) {
        
        [AppDelegate Reachabiltyalert];
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"IsNetworkReachabilityAlertVisible"];
        }
        return NO;
        
    }
    
    else
        
    {
        
        return YES;
        
    }
    
}
+ (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated
{
    
}

+ (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        AppDelegate *app=[[AppDelegate alloc]init];
        [app.alert removeFromSuperview];

        RecentPaymentViewController *recen=[[RecentPaymentViewController alloc]init];
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"IsNetworkReachabilityAlertVisible"];
        [recen fetchRecentPayment];
    }
}
+(void)Reachabiltyalert
{
    AppDelegate *app=[[AppDelegate alloc]init];
  app.alert = [[UIAlertView alloc]initWithTitle:@"Network Unreachable" message:@"Check your network Connection" delegate:self cancelButtonTitle:@"Retry" otherButtonTitles:nil];
    [ app.alert show];
}


- (void)registerDefaultsFromSettingsBundle {
    // this function writes default settings as settings
    
    NSString *settingsBundle = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
    if(!settingsBundle) {
        //  NSLog(@"Could not find Settings.bundle");
        return;
    }
    
    NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:[settingsBundle stringByAppendingPathComponent:@"Root.plist"]];
    
    NSArray *preferences = [settings objectForKey:@"PreferenceSpecifiers"];
    
    NSMutableDictionary *defaultsToRegister = [[NSMutableDictionary alloc] initWithCapacity:[preferences count]];
    for(NSDictionary *prefSpecification in preferences) {
        NSString *key = [prefSpecification objectForKey:@"Key"];
        if(key)
        {
            [defaultsToRegister setObject:[prefSpecification objectForKey:@"DefaultValue"] forKey:key];
            NSLog(@"writing as default %@ to the key %@",[prefSpecification objectForKey:@"DefaultValue"],key);
        }
    }
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultsToRegister];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    id LocationMe = [[NSUserDefaults standardUserDefaults] objectForKey:@"timer"];
    NSLog(@"%@",LocationMe);
    
    
    //Current user interval
    
    if ([LocationMe isEqualToString:@"0"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"5" forKey:UPDATION_INTERVEL];
    }
    else if  ([LocationMe isEqualToString:@"1"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"10" forKey:UPDATION_INTERVEL];
    }
    else  if ([LocationMe isEqualToString:@"2"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"25" forKey:UPDATION_INTERVEL];
    }
    else if ([LocationMe isEqualToString:@"3"])
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"60" forKey:UPDATION_INTERVEL];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"120" forKey:UPDATION_INTERVEL];
    }
    
    BOOL enabled;
    //demo
    enabled = [defaults boolForKey:@"enabled_preference"];
    
    [[NSUserDefaults standardUserDefaults]setBool:[defaults boolForKey:@"enabled_preference"] forKey:@"demo"];
    
    [[NSUserDefaults standardUserDefaults]setBool:[defaults boolForKey:@"demo"] forKey:K_CURR_DEMO_VALUE];
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:K_CURR_DEMO_VALUE]  isEqual:@"0"]) {
        prevValue=@"0";
    }
    
    
    
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:K_CURR_DEMO_VALUE]);
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:K_PREV_DEMO_VALUE]);
    //    if (!([[NSUserDefaults standardUserDefaults]valueForKey:K_PREV_DEMO_VALUE]==[[NSUserDefaults standardUserDefaults]valueForKey:K_CURR_DEMO_VALUE]))
    if (![[[NSUserDefaults standardUserDefaults]valueForKey:@"login"]length])
        
    {
        //remove nususer defaults value..
        
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"login"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"last"];
        
        //set home viewcontroller
        
        [AppDelegate appDelegate].login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [AppDelegate appDelegate].mainNavigationController=[[UINavigationController alloc]initWithRootViewController:[AppDelegate appDelegate].login];
        
        [AppDelegate appDelegate].window.rootViewController = [AppDelegate appDelegate].mainNavigationController;
        [AppDelegate appDelegate].mainNavigationController.navigationBarHidden=YES;
        [[AppDelegate appDelegate].window makeKeyAndVisible];
        
        
        prevValue=[[NSUserDefaults standardUserDefaults]valueForKey:K_CURR_DEMO_VALUE];
        [[NSUserDefaults standardUserDefaults]setObject:prevValue  forKey:K_PREV_DEMO_VALUE];
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:K_PREV_DEMO_VALUE]);
        
        
        return;
    }
    else{
        
        //remove local value
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"last"];
        //set rootview controller
        RecentPaymentViewController *recent=[[RecentPaymentViewController alloc]initWithNibName:@"RecentPaymentViewController" bundle:nil];
        
        self.mainNavigationController = [[UINavigationController alloc]initWithRootViewController:recent];
        
        MenuViewController *menuViewController = [[MenuViewController alloc] init];
        
        self.container = [MFSideMenuContainerViewController
                          containerWithCenterViewController:[AppDelegate appDelegate].mainNavigationController
                          leftMenuViewController:menuViewController
                          rightMenuViewController:nil];
        
        self.mainNavigationController=[[UINavigationController alloc]initWithRootViewController:self.container];
        
        self.window.rootViewController = self.mainNavigationController;
        
        
    }
    
    self.mainNavigationController.navigationBarHidden=YES;
    [self.window makeKeyAndVisible];
    
    
}

@end
