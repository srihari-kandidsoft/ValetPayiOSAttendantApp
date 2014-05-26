//
//  LoginViewController.m
//  ValetAttendant
//
//  Created by techbasics on 4/16/14.
//  Copyright (c) 2014 techbasics. All rights reserved.
//

#import "LoginViewController.h"
#import "MenuViewController.h"
#import "MFSideMenuContainerViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)Login:(id)sender
{
    if (![AppDelegate isNetworkAvailable]) {
        
        [AppDelegate Reachabiltyalert];
        return ;
        
    }
    if (![email_id.text length] || ![pwd.text length]) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter All Fieldes!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [alert show];
    }
    else{
    NSString *parameter=[NSString stringWithFormat:@"valet_code=%@&password=%@&client=mobile",email_id.text,pwd.text];
    NSMutableArray *insert=[[NSMutableArray alloc]init];
    
    insert= [[AppDelegate downLoadFrom:[NSString stringWithFormat:@"authenticate_valet.php"] parameters:parameter]valueForKey:@"result"];
        NSLog(@"sssdsd----%@",insert);
    if (![insert isEqual:@"failed"]) {
        [[NSUserDefaults standardUserDefaults]setObject:email_id.text forKey:@"login"];
        
       RecentPaymentViewController *recent=[[RecentPaymentViewController alloc]initWithNibName:@"RecentPaymentViewController" bundle:nil];
    
    [AppDelegate appDelegate].mainNavigationController = [[UINavigationController alloc]initWithRootViewController:recent];
    
    MenuViewController *menuViewController = [[MenuViewController alloc] init];
    
    [AppDelegate appDelegate].container = [MFSideMenuContainerViewController
                                           containerWithCenterViewController:[AppDelegate appDelegate].mainNavigationController
                                           leftMenuViewController:menuViewController
                                           rightMenuViewController:nil];
    
    [AppDelegate appDelegate].mainNavigationController.navigationBarHidden=YES;
    [self.navigationController pushViewController:[AppDelegate appDelegate].container animated:YES];
        
        recent.address=[NSString stringWithFormat:@"%@",[insert valueForKey:@"Address"]];
        recent.amt=[insert valueForKey:@"ParkingRate"];
        recent.locationcode=[insert valueForKey:@"PaymentConfirmationCode"];
        recent.lot_id=[insert valueForKey:@"ValetLotId"];
        
        //store the value locally.
        
        [[NSUserDefaults standardUserDefaults]setObject:recent.address forKey:@"address"];
        [[NSUserDefaults standardUserDefaults]setObject:recent.amt forKey:@"amt"];
        [[NSUserDefaults standardUserDefaults]setObject:recent.locationcode forKey:@"locationcode"];
        [[NSUserDefaults standardUserDefaults]setObject:recent.lot_id forKey:@"lot_id"];
        [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@ , %@ %@",[insert valueForKey:@"City"],[insert valueForKey:@"State"],[insert valueForKey:@"Zipcode"]] forKey:@"addr1"];

    }
    else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Check username or password" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [alert show];
    }
    }
   // [self presentViewController:self.container animated:YES completion:nil];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    //    if ([UIScreen mainScreen].bounds.size.height != 60) {
    
    [profile_ScrollView setContentOffset:CGPointMake(0, -19) animated:YES];
    //  }
    
    [textField resignFirstResponder];
    
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    //[self animateTextField:Email_textfield up:YES];
    //   if ([UIScreen mainScreen].bounds.size.height != 300)
    //  {
    if(textField==pwd){
    [profile_ScrollView setContentOffset:CGPointMake(0, 140) animated:YES];
    
     }
    else
    {
        [profile_ScrollView setContentOffset:CGPointMake(0, 95) animated:YES];

    }
    //  self.view.frame = CGRectMake(0, textField.tag * 60, 320, [UIScreen mainScreen].bounds.size.height);
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [profile_ScrollView addGestureRecognizer:singleFingerTap];
    
    [self.view addSubview:profile_ScrollView];
    profile_ScrollView.contentSize = CGSizeMake(0,self.view.frame.size.height);

    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)])
    {
        [self setNeedsStatusBarAppearanceUpdate];
    }
    
}

//-(UIStatusBarStyle)preferredStatusBarStyle{
//    return UIStatusBarStyleLightContent;
//}

//The event handling method
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    //    if ([UIScreen mainScreen].bounds.size.height != 568) {
    
    [profile_ScrollView setContentOffset:CGPointMake(0, -19) animated:YES];
    
    //  }
    
    [self.view endEditing:YES];
    
    
    //Do stuff here...
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
