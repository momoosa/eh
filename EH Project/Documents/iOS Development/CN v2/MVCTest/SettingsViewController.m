//
//  Created by Mo Moosa on 26/11/2012.
//  Copyright (c) 2012 MoFo. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController
@synthesize delegate = _delegate, overlayEnabled = _overlayEnabled, chosenValue, annotationOverlayEnabled = _annotationOverlayEnabled, settingsScrollView=_settingsScrollView;
@synthesize secondView;
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
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    self.slidingViewController.underRightViewController = nil;
    self.slidingViewController.anchorLeftPeekAmount     = 0;
    self.slidingViewController.anchorLeftRevealAmount   = 0;
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}

- (IBAction)revealMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
}



    

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [_settingsScrollView setScrollEnabled:YES];
    
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;

    [_settingsScrollView setContentSize:CGSizeMake(320,2800)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)findElephantAndCastle:(id)sender {
    [[self delegate] showLocation:self theLat:51.497496 theLon:-0.101731];
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    
    
}

- (IBAction)findHavering:(id)sender {
    
    [[self delegate] showLocation:self theLat:51.592322 theLon:0.227365];
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    
}

- (IBAction)dismissView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)mapSatelliteSegmentControlTapped:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex)
    {
        case 0:
            // map.mapType = MKMapTypeStandard;
            [[self delegate] changeMap:self theValue:@"standard"];
            chosenValue = 0;
            break;
        case 1:
            [[self delegate] changeMap:self theValue:@"satellite"];
            chosenValue =1;
            break;
        case 2:
            [[self delegate] changeMap:self theValue:@"hybrid"];
            chosenValue =2;
            break;
            
        default:
            break;
    }
    NSLog(@"selected index %i", sender.selectedSegmentIndex);
    
}

- (IBAction)toggleOverlay:(id)sender {
    if([_overlaySwitch isOn]){
        _overlayEnabled=YES;
        NSLog(@"YES");
        [[self delegate] toggleOverlay:self overlayEnabled:YES];
        
        
    } else{
        _overlayEnabled=NO;
        [[self delegate] toggleOverlay:self overlayEnabled:NO];
        
        NSLog(@"NO");
        
        
    }
}

- (IBAction)toggleAnnotationOverlay:(id)sender {
    if([_annotationOverlaySwitch isOn]){
        _annotationOverlayEnabled=YES;
        NSLog(@"YES");
        [[self delegate] toggleAnnotationOverlay:self annotationOverlayEnabled:YES];
        
        
    } else{
        _annotationOverlayEnabled=NO;
        [[self delegate] toggleAnnotationOverlay:self annotationOverlayEnabled:NO];
        
        NSLog(@"NO");
        
        
    }
    
}
- (void)viewDidUnload {
    [self setOverlaySwitch:nil];
    
    [self setAnnotationOverlaySwitch:nil];
    [super viewDidUnload];
}



@end
