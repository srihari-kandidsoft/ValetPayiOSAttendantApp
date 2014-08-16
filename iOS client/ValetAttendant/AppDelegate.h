//
//  AppDelegate.h
//  ValetAttendant
//
//  Created by techbasics on 3/14/14.
//  Copyright (c) 2014 techbasics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFSideMenuContainerViewController.h"
#import "Flurry.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) LoginViewController *login;

//@property (strong, nonatomic) CLLocation *current_Location;

@property(strong,nonatomic)UINavigationController * mainNavigationController;
@property (strong, nonatomic) MFSideMenuContainerViewController *container;

+(AppDelegate*)appDelegate;
-(void)leftSideMenuButtonPressed:(id)sender;
+(NSDictionary *)downLoadFrom:(NSString *)url parameters:(NSString *) para_str;


+(void)Reachabiltyalert;
+(BOOL)isNetworkAvailable;

@end
