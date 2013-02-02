//
//  Created by Mo Moosa on 02/12/2012.
//  Copyright (c) 2012 MoFo. All rights reserved.
//

#import "InitialViewController.h"
#import "AppDelegate.h"
@interface InitialViewController ()

@end

@implementation InitialViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
//    if ( ! [[NSUserDefaults standardUserDefaults] boolForKey:@"initialised"] ) {
//        // Setup stuff
//        
//        UIStoryboard *storyboard;
//        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
//            storyboard = [UIStoryboard storyboardWithName:@"iPhone" bundle:nil];
//        } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//            storyboard = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
//        }
//        AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        UIViewController *screen = [storyboard instantiateViewControllerWithIdentifier:@"tutorial"];
//        NSLog(@"screen %@", screen);
//        // [self.window setRootViewController:screen];
//        [app.window.rootViewController presentViewController:screen animated:NO completion:nil];
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"initialised"];
//        
//    }

    UIStoryboard *storyboard;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        storyboard = [UIStoryboard storyboardWithName:@"iPhone" bundle:nil];
    } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        storyboard = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    }
    
    self.topViewController = [storyboard instantiateViewControllerWithIdentifier:@"Summary"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
