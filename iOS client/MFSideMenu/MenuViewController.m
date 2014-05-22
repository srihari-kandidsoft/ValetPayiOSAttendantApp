//
//  MenuViewController.m
//  Valet Pay
//
//  Created by techbasics on 10/7/13.
//  Copyright (c) 2013 techbasics. All rights reserved.
//

#import "MenuViewController.h"
#import "Tablereload.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(IBAction)sel:(id)sender
{
    
       NSString *str=@"Recent";
 
    [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"Recent"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"last"];
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"Event_Has_acepted"
     object:nil];

    [[AppDelegate appDelegate] leftSideMenuButtonPressed:nil];
}

-(IBAction)satelite_Clicked:(id)sender
{
    
    // [_delegate animalSelected:currentRecord];
    NSString *str=@"last24";
   // RecentPaymentViewController *r=[[RecentPaymentViewController alloc]init];
   // r.Delegate = self;
   // [r TableSelected:str];
//[r.Delegate performSelector:@selector(myTVReloadMethod) withObject:nil];
    [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"last"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Recent"];
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"Event_Has_acepted"
     object:nil];
    [[AppDelegate appDelegate] leftSideMenuButtonPressed:nil];

    

}
-(IBAction)NoDuty_Clicked:(id)sender
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
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[self setNeedsStatusBarAppearanceUpdate];
    
    [self setNeedsStatusBarAppearanceUpdate];
    
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
