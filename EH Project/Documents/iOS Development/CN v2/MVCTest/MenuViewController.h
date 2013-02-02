//
//  Created by Mo Moosa on 02/12/2012.
//  Copyright (c) 2012 Mo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"
@interface MenuViewController : UIViewController  <UITableViewDataSource, UITabBarControllerDelegate>

- (IBAction)dismissFirstRun:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *menuTitleImage;

@end
