//
//  Created by Mo Moosa on 08/12/2012.
//  Copyright (c) 2012 MoFo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "MenuViewController.h"
#import "FirstRunDialogViewController.h"
@class MGScrollView, PhotoBox;

@interface SummaryViewController : UIViewController
- (IBAction)revealMenu:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *summaryTitle;
@property (nonatomic, weak) IBOutlet MGScrollView *scroller;

@property (weak, nonatomic) IBOutlet UIToolbar *summaryToolbar;

@end
