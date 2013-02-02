//
//  Created by Mo Moosa on 26/11/2012.
//  Copyright (c) 2012 MoFo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ECSlidingViewController.h"
#import <MapKit/MapKit.h>
#import "MGTileMenuController.h"
#import "CNBuilding.h"
#import "MenuViewController.h"
@class CNDataController;

@interface MapViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

//Interface Builder Outlets

@property (weak, nonatomic) IBOutlet UIBarButtonItem *searchButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *infoButton;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *keyBarButton;
@property (weak, nonatomic) IBOutlet UIView *keyView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *userLocationButton;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationBar;
@property (strong, nonatomic) NSArray *mapTypesArray;
@property (weak, nonatomic) IBOutlet UIView *titleImage;
//NSArrays
@property (nonatomic, retain) NSArray *pickerViewArray;
@property (strong, nonatomic) NSMutableArray* allTableData;
@property (strong, nonatomic) NSMutableArray* filteredTableData;
@property (nonatomic, retain) NSMutableArray *keys;
@property (nonatomic, retain) CNBuilding * mapBuilding;
@property (weak, nonatomic) IBOutlet UIToolbar *topToolBar;
@property (weak, nonatomic) IBOutlet UIToolbar *bottomToolBar;
@property (strong, nonatomic) IBOutlet UISegmentedControl *mapTypeControl;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *keysButton;

//Controllers
@property (nonatomic) UIPopoverController *popover;
@property (strong, nonatomic)CNDataController *dataController;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuButton;
- (IBAction)openCampusChoice:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *campusSelectionView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *segBarButton;


- (IBAction)mapTypeControlTapped:(id)sender;

//BOOL
@property (nonatomic, assign) bool isFiltered;
@property (nonatomic, assign) bool isActive;
@property (nonatomic) BOOL keyIsHidden;
@property (nonatomic) BOOL finishedLoading;

@property (nonatomic) BOOL campusSelectionIsHidden;

@property (nonatomic) BOOL firstRun;

//misc
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

- (void)setLat:(double)lat setLon:(double) lon;
-(void)loadExample:(id)sender;
-(void)saySomething;

//Interface Builder Actions
-(IBAction)findUser:(id)sender;
-(IBAction)findSouthwark:(id)sender;
-(IBAction)findHavering:(id)sender;
-(IBAction)revealUnderRight:(id)sender;
-(IBAction)dismissView:(id)sender;
-(IBAction)toggleKey:(id)sender;
- (IBAction)revealSettings:(id)sender;


@end

