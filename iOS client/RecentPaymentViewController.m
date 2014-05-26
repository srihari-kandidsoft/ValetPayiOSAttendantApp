//
//  RecentPaymentViewController.m
//  ValetAttendant
//
//  Created by techbasics on 4/16/14.
//  Copyright (c) 2014 techbasics. All rights reserved.
//

#import "RecentPaymentViewController.h"
#import "MenuViewController.h"
#import "MFSideMenuContainerViewController.h"
#import "Tablereload.h"

@interface RecentPaymentViewController ()
{
    NSMutableArray *insert;
    BOOL isSet;
    NSMutableArray *aa;
}
@end

@implementation RecentPaymentViewController

@synthesize address,amt,locationcode,lot_id;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(TableSelected:)
                                                     name:@"Event_Has_acepted"
                                                   object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //set the value for label
       act_view.hidden=YES;
    locationcode_lbl.text=[NSString stringWithFormat:@":%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"locationcode"]];
    amt_lbl.text=[NSString stringWithFormat:@"$%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"amt"]];
    address_lbl.text=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"address"]];
   // address_lbl.lineBreakMode = NSLineBreakByWordWrapping;
    address_lbl1.text=[[NSUserDefaults standardUserDefaults]valueForKey:@"addr1"];
    isSet=NO;
    //address_lbl.numberOfLines = 0;
    //[address_lbl sizeToFit];
    [self fetchRecentPayment];
    self.navigationController.navigationBarHidden=YES;
    [self setNeedsStatusBarAppearanceUpdate];
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    
    // _is_btnClicked_enabled_1=YES;
    [refreshControl setTintColor:[UIColor whiteColor]];
    
    // Configure Refresh Control
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    
    // Configure View Controller
    [self setRefreshControl:refreshControl];
    
    [_Table addSubview:refreshControl];
    
    
    NSTimer *timer;
     int update_interval = [[[NSUserDefaults standardUserDefaults] objectForKey:UPDATION_INTERVEL] intValue];
    NSLog(@"update_interval---%d",update_interval);
    timer=[NSTimer scheduledTimerWithTimeInterval:update_interval target:self selector:@selector(fetchRecentPayment1) userInfo:nil repeats:YES];

    
}
- (void)refresh:(id)sender {
    
    // Reload Table View
    [self fetchRecentPayment];
    [(UIRefreshControl *)sender endRefreshing];
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentifier = @"cell";
    UITableViewCell * cell  = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:cellidentifier];
        cell.backgroundColor=[UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *min_lbl = [[UILabel alloc] initWithFrame:CGRectMake(300,5,30,20)];
        [min_lbl setTag:1];
        min_lbl.textColor = [UIColor whiteColor];
        [min_lbl setBackgroundColor:[UIColor clearColor]];
        [min_lbl setFont:[UIFont fontWithName:@"Avenir" size:12]];
        [cell.contentView addSubview:min_lbl];
        
        UILabel *Name_lbl = [[UILabel alloc] initWithFrame:CGRectMake(27.5,15,200,20)];
        [Name_lbl setTag:2];
        Name_lbl.textColor = [UIColor whiteColor];
        [Name_lbl setBackgroundColor:[UIColor clearColor]];
        [Name_lbl setFont:[UIFont fontWithName:@"Avenir-Black" size:25]];
        [cell.contentView addSubview:Name_lbl];
        
        UIImageView *key=[[UIImageView alloc]initWithFrame:CGRectMake(27.5, 42.5, 14, 14)];
        key.image=[UIImage imageNamed:@"recent_key_icon.png"];
        [cell.contentView addSubview:key];
        
        UILabel *CarName_lbl = [[UILabel alloc] initWithFrame:CGRectMake(43,40.5,200,20)];
        [CarName_lbl setTag:3];
        CarName_lbl.textColor = [UIColor whiteColor];
        [CarName_lbl setBackgroundColor:[UIColor clearColor]];
        [CarName_lbl setFont:[UIFont fontWithName:@"Avenir" size:13]];
        [cell.contentView addSubview:CarName_lbl];
        
        UIImageView *star=[[UIImageView alloc]initWithFrame:CGRectMake(27.5, 65, 14, 14)];
        star.image=[UIImage imageNamed:@"recent_star_icon.png"];
        [cell.contentView addSubview:star];
        
        UILabel *CarNumber_lbl = [[UILabel alloc] initWithFrame:CGRectMake(43,63,200,20)];
        [CarNumber_lbl setTag:4];
        CarNumber_lbl.textColor = [UIColor whiteColor];
        [CarNumber_lbl setBackgroundColor:[UIColor clearColor]];
        [CarNumber_lbl setFont:[UIFont fontWithName:@"Avenir-Black" size:14]];
        [cell.contentView addSubview:CarNumber_lbl];
        
        UIImageView *clk=[[UIImageView alloc]initWithFrame:CGRectMake(27.5, 95, 14, 14)];
        clk.image=[UIImage imageNamed:@"recent_clock_icon.png"];
        [cell.contentView addSubview:clk];
        
        UILabel *Time_lbl = [[UILabel alloc] initWithFrame:CGRectMake(43,93,200,20)];
        [Time_lbl setTag:5];
        Time_lbl.textColor = [UIColor whiteColor];
        [Time_lbl setBackgroundColor:[UIColor clearColor]];
        [Time_lbl setFont:[UIFont fontWithName:@"Avenir" size:14]];
        [cell.contentView addSubview:Time_lbl];
        
        UILabel *amt1 = [[UILabel alloc] initWithFrame:CGRectMake(252,65,100,20)];
        [amt1 setTag:7];
        amt1.textColor = [UIColor whiteColor];
        [amt1 setBackgroundColor:[UIColor clearColor]];
        [amt1 setFont:[UIFont fontWithName:@"Avenir-Black" size:13]];
        [cell.contentView addSubview:amt1];
        
        UILabel *amtfloat = [[UILabel alloc] initWithFrame:CGRectMake(266,88,50,20)];
        [amtfloat setTag:8];
      //  amtfloat.textAlignment=NSTextAlignmentCenter;
       // amtfloat.backgroundColor=[UIColor redColor];
        amtfloat.textColor = [UIColor greenColor];
        [amtfloat setBackgroundColor:[UIColor clearColor]];
        [amtfloat setFont:[UIFont fontWithName:@"Avenir-Black" size:13]];
        [cell.contentView addSubview:amtfloat];
        
        UILabel *amtmain = [[UILabel alloc] initWithFrame:CGRectMake(218,93,50,20)];
        [amtmain setTag:6];
        amtmain.textAlignment=NSTextAlignmentRight;
        amtmain.textColor = [UIColor greenColor];
        [amtmain setBackgroundColor:[UIColor clearColor]];
        [amtmain setFont:[UIFont fontWithName:@"Avenir-Black" size:25]];
        [cell.contentView addSubview:amtmain];
    
    }
    
    // Swipe Left
    UISwipeGestureRecognizer * Swipeleft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeleft:)];
    Swipeleft.direction=UISwipeGestureRecognizerDirectionLeft;
    [cell addGestureRecognizer:Swipeleft];
    
    
    // SwipeRight
    UISwipeGestureRecognizer * Swiperight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swiperight:)];
    Swiperight.direction=UISwipeGestureRecognizerDirectionRight;
    [cell addGestureRecognizer:Swiperight];
    
    
    
    [(UILabel *)[cell.contentView viewWithTag:1] setFrame:CGRectMake(252,5,100, 20)];
    NSString *lastViewedString = [[insert objectAtIndex:indexPath.row] valueForKey:@"UTCDateTime"] ;
    //  NSLog( @"the latest updated value --- >%@",lastViewedString);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    
    [dateFormatter setTimeZone:timeZone];
    
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *lastViewed = [dateFormatter dateFromString:lastViewedString];
    
    
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *components = [gregorianCalendar components:unitFlags
                                                        fromDate:lastViewed
                                                          toDate:[NSDate date]
                                                         options:0];
    
    
    if ([components day] > 0) {
        [(UILabel *)[cell.contentView viewWithTag:1] setText:[NSString stringWithFormat:@"%d days ago",[components day]]];
        
    }
    else if ([components hour] > 0) {
        
        [(UILabel *)[cell.contentView viewWithTag:1] setText:[NSString stringWithFormat:@"%d hours ago",[components hour]]];
        
    }
    else if ([components minute] > 0)
    {
        [(UILabel *)[cell.contentView viewWithTag:1] setText:[NSString stringWithFormat:@"%d mins ago",[components minute]]];
        
    }
    else if ([components second] > 0)
    {
        [(UILabel *)[cell.contentView viewWithTag:1] setText:[NSString stringWithFormat:@"%d secs ago",[components second]]];
    }
    
    
    
    
    [(UILabel *)[cell.contentView viewWithTag:2] setText:[NSString stringWithFormat:@"%@",[[insert objectAtIndex:indexPath.row ] valueForKey:@"Name"]]];
    
    [(UILabel *)[cell.contentView viewWithTag:3] setText:[NSString stringWithFormat:@"%@",[[insert objectAtIndex:indexPath.row ] valueForKey:@"VehicleMakeModel"]]];
    
    [(UILabel *)[cell.contentView viewWithTag:4] setText:[NSString stringWithFormat:@"%@",[[insert objectAtIndex:indexPath.row ] valueForKey:@"LicensePlate"]]];
    
    [(UILabel *)[cell.contentView viewWithTag:5] setText:[NSString stringWithFormat:@"%@",[[insert objectAtIndex:indexPath.row ] valueForKey:@"LocalTime"]]];
    [(UILabel *)[cell.contentView viewWithTag:7] setText:[NSString stringWithFormat:@"+$%@",[[insert objectAtIndex:indexPath.row ]valueForKey:@"Tip"]]];
    //split the double value into int and float
    double num = [[[insert objectAtIndex:indexPath.row ] valueForKey:@"TotalAmount"]doubleValue];
    int intpart = (int)num;
    float decpart = num - intpart;

    NSString *str=[NSString stringWithFormat:@"%.2f",decpart];
    
    NSArray *array=[str componentsSeparatedByString:@"."];
    

    if (decpart==0.0000) {
        [(UILabel *)[cell.contentView viewWithTag:6] setText:[NSString stringWithFormat:@"$%d",intpart]];

    }
    else{
        [(UILabel *)[cell.contentView viewWithTag:6] setText:[NSString stringWithFormat:@"$%d",intpart]];
        [(UILabel *)[cell.contentView viewWithTag:8] setText:[NSString stringWithFormat:@".%@",array[1]]];
    }
    
    
    
    
    //Distance
    
    return  cell;
}

-(void)swipeleft:(UISwipeGestureRecognizer*)gestureRecognizer
{
    //Do what you want here
    if (![[NSUserDefaults standardUserDefaults]valueForKey:@"last"]) {
        
        UITableViewCell *cell=(UITableViewCell *)gestureRecognizer.view;
        
        swiped_Index = [_Table indexPathForCell:cell];
        
        [self fetchcheckout];
    }
}

-(void)swiperight:(UISwipeGestureRecognizer*)gestureRecognizer
{
    if (![[NSUserDefaults standardUserDefaults]valueForKey:@"last"]) {
        UITableViewCell *cell=(UITableViewCell *)gestureRecognizer.view;
        
        swiped_Index = [_Table indexPathForCell:cell];
        
        
      [self fetchcheckout];
        
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if ([insert count]==0) {
        _Table.hidden=YES;
        return 0;
        
    }
    else{
        _Table.hidden=NO;
        
        return [insert count];
    }
    
}

- (void)TableSelected:(NSString *)table
{
     NSLog(@"dfdfdfdf-----%@",table);
    [self fetchRecentPayment];
    // only change the main display if an animal/image was selected
    if (table)
    {
        common=table;
        
        
        // [self showAnimalSelected:animal];
    }
}

-(IBAction)slideItLeft:(id)sender
{
    [[AppDelegate appDelegate] leftSideMenuButtonPressed:nil];
//    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"last"]) {
//        
//        [self fetchRecentPayment];
//    }
//    else if([[NSUserDefaults standardUserDefaults]valueForKey:@"Recent"]){
//        [self fetchRecentPayment];
//    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fetchRecentPayment1
{
    NSLog(@"hi----%d",[insert count]);
    
    if (![AppDelegate isNetworkAvailable]) {
        _Table.hidden=YES;
        
        [AppDelegate Reachabiltyalert];
        return ;
    }
    //call the API
    NSLog(@"dfdfdf%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"last"]);
    
    if (![[NSUserDefaults standardUserDefaults]valueForKey:@"last"]) {
        act_view.hidden=NO;
        [act_view startAnimating];

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        __block    NSString *parameter;
            insert =[[NSMutableArray alloc]init];
            dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                parameter=[NSString stringWithFormat:@"valetlot_id=%@&client=mobile&Status=0",[[NSUserDefaults standardUserDefaults]valueForKey:@"lot_id"]];
 insert= [[AppDelegate downLoadFrom:[NSString stringWithFormat:@"fetch_valet_transactions.php"] parameters:parameter]valueForKey:@"result"];
            });
            dispatch_sync(dispatch_get_main_queue(), ^{
                NSLog(@"dfdfdf%d",[insert count]);
                [_Table reloadData];
                [act_view stopAnimating];

            });
            
        });


    }
    
  }
-(void)timer
{
   }
-(void)fetchRecentPayment
{
    NSLog(@"hi----%d",[insert count]);
    
    if (![AppDelegate isNetworkAvailable]) {
        _Table.hidden=YES;
        
        [AppDelegate Reachabiltyalert];
        return ;
    }
    [self performSelector:@selector(timer) withObject:nil afterDelay:25];
    
    

    NSString *parameter;
    insert =[[NSMutableArray alloc]init];
    //call the API
       NSLog(@"dfdfdf%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"last"]);

    if (![[NSUserDefaults standardUserDefaults]valueForKey:@"last"]) {
        
        parameter=[NSString stringWithFormat:@"valetlot_id=%@&client=mobile&Status=0",[[NSUserDefaults standardUserDefaults]valueForKey:@"lot_id"]];
           }
    else{
        parameter=[NSString stringWithFormat:@"valetlot_id=%@&client=mobile",[[NSUserDefaults standardUserDefaults]valueForKey:@"lot_id"]];
    }
    insert= [[AppDelegate downLoadFrom:[NSString stringWithFormat:@"fetch_valet_transactions.php"] parameters:parameter]valueForKey:@"result"];
    NSLog(@"dfdfdf%d",[insert count]);
   

    [_Table reloadData];
}
-(void)myTVReloadMethod {
   [_Table reloadData];
}
-(void)fetchcheckout
{
    
    //Checking network rechability
    
    if (![AppDelegate isNetworkAvailable]) {
        
        [AppDelegate Reachabiltyalert];
        return ;
        
    }
    //call the API
    //Do what you want here
    if (![[NSUserDefaults standardUserDefaults]valueForKey:@"last"]) {
        NSString *parameter=[NSString stringWithFormat:@"PaymentId=%@&Status=1",[[insert objectAtIndex:swiped_Index.row]valueForKey:@"PaymentId"]];
        
        NSMutableArray *  fetch =[[NSMutableArray alloc]init];
        
        
        fetch= [[AppDelegate downLoadFrom:[NSString stringWithFormat:@"checkout_customer.php"] parameters:parameter]valueForKey:@"result"];
        
        NSLog(@"dfdfdf%@",fetch);
        [self fetchRecentPayment];
        
    }
}


-(void)viewDidAppear:(BOOL)animated
{
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
}

@end
