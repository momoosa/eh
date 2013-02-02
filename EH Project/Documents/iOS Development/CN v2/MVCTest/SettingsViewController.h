//
//  Created by Mo Moosa on 26/11/2012.
//  Copyright (c) 2012 MoFo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
@protocol SettingsViewControllerDelegate;

@interface SettingsViewController : UIViewController

@property (weak, nonatomic) id <SettingsViewControllerDelegate> delegate;
@property NSInteger chosenValue;
@property BOOL overlayEnabled;
@property BOOL annotationOverlayEnabled;
- (IBAction)revealMenu:(id)sender;

- (IBAction)findElephantAndCastle:(id)sender;
- (IBAction)findHavering:(id)sender;
- (IBAction)dismissView:(id)sender;
- (IBAction)mapSatelliteSegmentControlTapped:(UISegmentedControl *)sender;
- (IBAction)toggleOverlay:(id)sender;
- (IBAction)toggleAnnotationOverlay:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *settingsScrollView;
@property (weak, nonatomic) IBOutlet UISwitch *overlaySwitch;
@property (weak, nonatomic) IBOutlet UISwitch *annotationOverlaySwitch;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@property NSInteger *mapType;
@end

@protocol SettingsViewControllerDelegate <NSObject>

-(void)showLocation:(SettingsViewController *)controller theLat:(double)theLat theLon:(double) theLon;
-(void)changeMap:(SettingsViewController *)controller theValue:(NSString *)theValue;
-(void)toggleOverlay:(SettingsViewController *)controller overlayEnabled:(BOOL *)overlayEnabled;
-(void)toggleAnnotationOverlay:(SettingsViewController *)controller annotationOverlayEnabled:(BOOL *)annotationOverlayEnabled;

@end