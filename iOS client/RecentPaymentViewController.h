//
//  RecentPaymentViewController.h
//  ValetAttendant
//
//  Created by techbasics on 4/16/14.
//  Copyright (c) 2014 techbasics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFSideMenuContainerViewController.h"
#import "AppDelegate.h"
#import "MenuViewController.h"
#import "Tablereload.h"

@interface RecentPaymentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate,UIAlertViewDelegate>

{
    
    IBOutlet UILabel *address_lbl,*locationcode_lbl,*amt_lbl,*address_lbl1;
    NSIndexPath * swiped_Index;
    NSString *common;
    IBOutlet UIActivityIndicatorView *act_view;
    IBOutlet UIImageView *Nav_view;
    
    
}
-(void)fetchRecentPayment;
-(void)myTVReloadMethod;
@property (nonatomic, strong) id Delegate;
@property (strong,nonatomic) IBOutlet UITableView *Table;
@property(strong,nonatomic)NSString *address,*locationcode,*amt,*lot_id;
@property (strong, nonatomic) MFSideMenuContainerViewController *container;
+(RecentPaymentViewController*)recennt;
- (void)TableSelected:(NSString *)table;
@property (nonatomic,strong) UIRefreshControl *refreshControl;

@end
