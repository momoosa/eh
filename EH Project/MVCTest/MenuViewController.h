//
//  Created by Mo Moosa on 02/12/2012.
//  Copyright (c) 2012 Mo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"
#import "ISRefreshControl.h"
#import <CoreLocation/CoreLocation.h>
@interface MenuViewController : UIViewController  <UITableViewDataSource, UITabBarControllerDelegate>

- (IBAction)dismissFirstRun:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *menuTitleImage;
@property (nonatomic,retain) UIRefreshControl *refreshControl NS_AVAILABLE_IOS(6_0);
@property (nonatomic, retain) NSMutableArray *charIndex;
@property (nonatomic, retain) CLLocation *customLocation;
@property (nonatomic, retain) CLLocation *location;
@property (weak, nonatomic) IBOutlet UILabel *carouselDistanceLabel;

@end
