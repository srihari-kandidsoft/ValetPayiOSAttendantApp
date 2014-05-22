//
//  LoginViewController.h
//  ValetAttendant
//
//  Created by techbasics on 4/16/14.
//  Copyright (c) 2014 techbasics. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MFSideMenuContainerViewController.h"
@interface LoginViewController : UIViewController<UIScrollViewDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
{
       IBOutlet UIScrollView *profile_ScrollView;
    IBOutlet UITextField *email_id,*pwd;
     
    
}

@property (strong, nonatomic) MFSideMenuContainerViewController *container;
@end
