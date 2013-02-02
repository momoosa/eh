//
//  Created by Mo Moosa on 02/12/2012.
//  Copyright (c) 2012 Mo. All rights reserved.
//

#import "MenuViewController.h"
#import "ISRefreshControl.h"
#import "WBSuccessNoticeView.h"
#import "WBStickyNoticeView.h"
#import "MGDetailViewController.h"
#import "AppDelegate.h"

@interface MenuViewController()
@property (nonatomic, strong) NSArray *menuItems;
@property (nonatomic, unsafe_unretained) CGFloat peekLeftAmount;

@end


@implementation MenuViewController
@synthesize menuItems;
@synthesize refreshControl;
@synthesize menuTitleImage;
@synthesize charIndex;
@synthesize carouselDistanceLabel;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)awakeFromNib{
    self.menuItems = [NSArray arrayWithObjects:@"News", @"Near Me",@"Events", @"Favourites",@"Settings", @"About",nil];

}
-(void) viewDidAppear:(BOOL)animated{
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.refreshControl = (id)[[ISRefreshControl alloc] init];
    [self.refreshControl addTarget:self
                            action:@selector(refresh)
                  forControlEvents:UIControlEventValueChanged];

    [self.slidingViewController setAnchorRightRevealAmount:280.0f];
    self.slidingViewController.underLeftWidthLayout = ECFullWidth;

	// Do any additional setup after loading the view.
    AppDelegate *appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    CLLocation *currentLocation=appDelegate.locationManager.location;
    NSString* labelLocationInformation = [[NSString alloc]init];
    labelLocationInformation =[NSString stringWithFormat:@"latitude: %+.6f\nlongitude: %+.6f\naccuracy: %f",
                               currentLocation.coordinate.latitude,
                               currentLocation.coordinate.longitude,
                               currentLocation.horizontalAccuracy];
    //        CLLocationCoordinate2DMake(51.4971949457464, -0.1012301107794733),

    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:51.4988354072503 longitude:-0.1056801561689547];
    CLLocation *customLocation = [[CLLocation alloc] initWithLatitude:51.4971949457464 longitude:-0.1012301107794733];

    [geocoder geocodeAddressString:@"90 London Road, London, SE1 6LN" completionHandler:^(NSArray* placemarks, NSError* error){
        for (CLPlacemark* aPlacemark in placemarks)
        {
            // Process the placemark.
            NSString *latDest1 = [NSString stringWithFormat:@"%.4f",aPlacemark.location.coordinate.latitude];
            NSString *lngDest1 = [NSString stringWithFormat:@"%.4f",aPlacemark.location.coordinate.longitude];
            NSLog(@"lat %@", latDest1);
            NSLog(@"lon %@", lngDest1);

          //  lblDestinationLat.text = latDest1;
          //  lblDestinationLng.text = lngDest1;
        }
    }];
    
    



    CLLocationDistance distance = [customLocation distanceFromLocation:location];
    if (distance == 0) {
        
    } else {
        NSString* distanceLabel = [NSString stringWithFormat:@"%.01f miles", distance/1609.34];
        [self.carouselDistanceLabel setText:distanceLabel];
        WBStickyNoticeView *distanceNoticeView = [WBStickyNoticeView stickyNoticeInView:self.view title:distanceLabel];
        [distanceNoticeView show];

    }

    WBStickyNoticeView *noticeView = [WBStickyNoticeView stickyNoticeInView:self.view title:labelLocationInformation];

    [noticeView show];

}

- (void)refresh
{
    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        static BOOL flag = NO;
        if (flag) {
         //   self.items = @[@"foo", @"bar", @"baz"];
        }else {
         //   self.items = @[@"hoge", @"fuga", @"piyo"];
        }
        flag = !flag;
        
    //    [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"MenuItemCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.font= [UIFont fontWithName:@"Helvetica Neue" size:17.0];
    cell.textLabel.text = [self.menuItems objectAtIndex:indexPath.row];
    cell.textLabel.backgroundColor = [UIColor clearColor];
//    UIImageView *av = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 277, 58)];
//    av.backgroundColor = [UIColor clearColor];
//    av.opaque = NO;
//    av.image = [UIImage imageNamed:@"table_row_gradient.png"];
//    cell.backgroundView = av;
    

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *identifier =  [self.menuItems objectAtIndex:indexPath.row];
    
    UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController = newTopViewController;
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissFirstRun:(id)sender {
    UIStoryboard *storyboard;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        storyboard = [UIStoryboard storyboardWithName:@"iPhone" bundle:nil];
    } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        storyboard = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    }
    
    UIViewController *screen = [storyboard instantiateViewControllerWithIdentifier:@"initial"];
    NSLog(@"screen %@", screen);

    [self dismissViewControllerAnimated:YES completion:nil];
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    // set the section title to the matching letter
//    return [charIndex objectAtIndex:section];
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    NSString *alphabet = [charIndex objectAtIndex:section];
//    
//    // get the names beginning with the letter
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.type contains[c] %@", alphabet];
//    
//    NSArray *names = [self.menuItems filteredArrayUsingPredicate:predicate];
//    
//    return [names count];
//    
//    
//}


@end
