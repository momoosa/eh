//
//  Created by Mo Moosa on 16/12/2012.
//  Copyright (c) 2012 MoFo. All rights reserved.
//

#import "FirstRunDialogViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface FirstRunDialogViewController ()

@end

@implementation FirstRunDialogViewController
@synthesize backgroundImage;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.layer.cornerRadius=10;
   // self.view.layer.borderWidth = 2.0;
    backgroundImage.layer.cornerRadius=10;
    backgroundImage.layer.masksToBounds = YES;
  //  backgroundImage.layer.borderWidth = 2.0;

    backgroundImage.layer.borderColor = [UIColor whiteColor].CGColor;

    self.view.layer.borderColor = [UIColor whiteColor].CGColor;
    self.view.layer.masksToBounds=YES;


    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
