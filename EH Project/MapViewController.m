//
//  Created by Mo Moosa on 26/11/2012.
//  Copyright (c) 2012 MoFo. All rights reserved.
//
#import "MapViewController.h"
#import "SettingsViewController.h"
#import <MapKit/MapKit.h>
#import "CNDataController.h"
#import "CNBuilding.h"
#import "DetailViewController.h"
#import "MasterViewController.h"
#import "OLGhostAlertView.h"
#import "WBSuccessNoticeView.h"
#import "WBStickyNoticeView.h"
#import "MGDetailViewController.h"
#import "AppDelegate.h"
@interface MapViewController () <SettingsViewControllerDelegate>

@end

@interface MapViewController () <MGDetailViewControllerDelegate>

@end


@implementation MapViewController
@synthesize searchButton = _searchButton;
@synthesize infoButton = _infoButton;
@synthesize  mapView = _mapView;
@synthesize popover = _popover;
@synthesize keys = _keys;
@synthesize firstRun = _firstRun;
@synthesize topToolBar = _topToolBar;
@synthesize mapBuilding = _mapBuilding;
@synthesize bottomToolBar = _bottomToolBar;
@synthesize mapTypeControl = _mapTypeControl;
@synthesize menuButton = _menuButton;
@synthesize campusSelectionIsHidden = _campusSelectionIsHidden;
@synthesize navigationBar = _navigationBar;
@synthesize userLocationButton = _userLocationButton;
@synthesize finishedLoading = _finishedLoading;
@synthesize keysButton = _keysButton;
@synthesize mapTypesArray = _mapTypesArray;
@synthesize keyView = _keyView;
@synthesize  numberForChoice = _numberForChoice;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.bottomToolBar setBackgroundImage:[UIImage imageNamed:@"red_nav_bar.png"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    
    self.navigationBar.title=@"Map";
    CNDataController *aDataController=[[CNDataController alloc]init];
    self.dataController = aDataController;
    self.firstRun = YES;
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    self.numberForChoice = [standardUserDefaults objectForKey:@"MFMapTypeChoice"];
    
    // Map Type Control Setup
    
    
    // Slide Controller Setup
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    // [self.navigationController.navigationBar addGestureRecognizer:self.slidingViewController.panGesture];
    
    [self.slidingViewController setAnchorRightRevealAmount:280.0f];
    
    
    
    _keyIsHidden=YES;
    
    // Notification Center Observers
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onShowOnMap:) name:@"ShowOnMap" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onShowBuilding:) name:@"shareBuilding" object:nil];
    
    
    // Gestures
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(toggleKey:)];
    swipeGesture.numberOfTouchesRequired=2;
    [swipeGesture setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [self.keyView addGestureRecognizer:swipeGesture];

    
    [self setUp];
    
    AppDelegate *appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    CLLocation *currentLocation=appDelegate.locationManager.location;
    NSString* labelLocationInformation = [[NSString alloc]init];
    labelLocationInformation =[NSString stringWithFormat:@"latitude: %+.6f\nlongitude: %+.6f\naccuracy: %f",
                               currentLocation.coordinate.latitude,
                               currentLocation.coordinate.longitude,
                               currentLocation.horizontalAccuracy];
    NSLog(@"Location Manager %@", labelLocationInformation);
}

- (void)viewDidLoad
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed: @"red_nav_bar.png"]
                                                  forBarMetrics:UIBarMetricsDefault];
    [self setLat:(51.497195) setLon:(-0.100948)];
    MGDetailViewController *detailViewController = [[MGDetailViewController alloc]init];  //create an instance of ClassB
    detailViewController.delegate = self;  //set self as the delegate
    
}

-(void)fadeInElements{
    [UIView animateWithDuration:0.6
                          delay:0.5
                        options: UIViewAnimationCurveLinear
                     animations:^{
                         self.titleImage.alpha=1.0;
                         self.mapView.alpha=1.0;
                         self.topToolBar.alpha=1.0;
                         self.bottomToolBar.alpha=1.0;
                         //_keyView.alpha=1.0;
                         
                     }
                     completion:^(BOOL finished){
                     }];
    
    
}

-(void)setUp{
    if([self.dataController.masterList count]==0){
        [self.dataController initializeDefaultDataList];
        
    }
    if([_mapView.overlays count]==0){
        [self addAnnotationOverlays];
        [self addOverlays];
        
        
    }
    self.keys = [[NSMutableArray alloc]init];
    [self setUpMapTypeControl:self.mapTypeControl];
    for(CNBuilding * building in self.dataController.masterList){
        if(![self.keys containsObject:building.type]){
            [self.keys addObject:building.type];
            NSLog(@"keys count %d",[self.keys count]);
            
        }
        [self.keys sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        [self.keyView reloadData];
        
        
    }
    UIView * view = [[UIView alloc]init];
    WBSuccessNoticeView * successNotice = [WBSuccessNoticeView successNoticeInView:self.view title:@"Loaded maps successfully."];
    WBStickyNoticeView *notice = [WBStickyNoticeView stickyNoticeInView:self.view title:@"Updates available."];
    [notice setDismissalBlock:^(BOOL dismissedInteractively) {
        NSLog(@"showSmallStickyNotice dismissed!");
    }];
    notice.originY = self.bottomToolBar.frame.size.height;
    [successNotice show];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
	// Do any additional setup after loading the view.
}
- (void)mapViewWillStartLocatingUser:(MKMapView *)mapView
{
    WBStickyNoticeView *notice = [WBStickyNoticeView stickyNoticeInView:self.view title:@"Updates available."];
    [notice setDismissalBlock:^(BOOL dismissedInteractively) {
        NSLog(@"showSmallStickyNotice dismissed!");
    }];
    [notice show];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setUpMapTypeControl:(UISegmentedControl*) segmentControl{
    [segmentControl setAlpha:0.0];
    [segmentControl setSelectedSegmentIndex: self.numberForChoice.integerValue];
    [self mapTypeControlTapped:segmentControl];

}

- (IBAction)revealSettings:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
}
- (IBAction)revealUnderRight:(id)sender
{
    // [self.slidingViewController anchorTopViewTo:ECLeft];
}

//Adds all annotations for objects in dataController's masterBuildingList
-(void)addAnnotationOverlays{
    //coordinate objects
    for(CNBuilding  *building in self.dataController.masterList){
        [_mapView addAnnotation:building.annotation];
        
    }
    
}

//adds all Overlays for objects in dataController's masterBuildingList
-(void)addOverlays{
    //polygon coordinates
    for(CNBuilding  *building in self.dataController.masterList){
        [_mapView addOverlay:building.polygon];
        
    }
    
    //[_activityIndicator stopAnimating];
    
}

//adds all polygons for a particular building type
//used for the keys table to toggle building types
-(void)addBuildingPolygonsOfType:(NSString*)type{
    
    for(CNBuilding *building in self.dataController.masterList){
        if ([building.type isEqualToString:type]){
            [_mapView addOverlay:building.polygon];
            [_mapView addAnnotation:building.annotation];
        }
    }
}

//removes all polygons for a particular building type
//used for the keys table to toggle building types
-(void)removeBuildingPolygonsOfType:(NSString*)type{
    for(CNBuilding *building in self.dataController.masterList){
        if ([building.type isEqualToString:type]){
            [_mapView removeOverlay:building.polygon];
            [_mapView removeAnnotation:building.annotation];
        }
    }
}


//main mapView overlay method, handles formatting of polygons
-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay{
	if([overlay isKindOfClass:[MKPolygon class]]){
        
        MKPolygonView *pv = [[MKPolygonView alloc] initWithPolygon:overlay];
        
        if ([overlay.title isEqualToString:@"Business Faculty"]){
            pv.lineWidth=2;
            pv.strokeColor=[[UIColor alloc]initWithRed:0.0f/255.0f green:121.0f/255.0f blue:134.0f/255.0f alpha:1.0];
            pv.fillColor=[[UIColor alloc]initWithRed:0.0f/255.0f green:121.0f/255.0f blue:134.0f/255.0f alpha:0.5];
            
        }else{
            
            pv.lineWidth=2;
            pv.strokeColor=[[UIColor alloc]initWithRed:0.0f/255.0f green:0.0f/255.0f blue:128.0f/255.0f alpha:1.0];
            pv.fillColor=[[UIColor alloc]initWithRed:0.0f/255.0f green:0.0f/255.0f blue:128.0f/255.0f alpha:0.5];
        }        [_activityIndicator stopAnimating];
        
        return pv;
    }
	return nil;
    
}


- (void)viewDidUnload
{
    [self setSearchButton:nil];
    [self setInfoButton:nil];
    [self setKeyView:nil];
    [self setKeyBarButton:nil];
    [self setActivityIndicator:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    if( interfaceOrientation == UIInterfaceOrientationPortrait){
        return YES;
    } else{
        return NO;
    }
}

#pragma mark MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
	// if it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
	// attempt to dequeue an existing pin
	static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
    UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	[rightButton setTitle:annotation.title forState:UIControlStateNormal];
    
    /* Only one of the following blocks of code should be enabled at one time.
     Use Block 1 for the standard Pin Annotation and Block 2 for the Custom annotation */
    
    //Block 1
	MKPinAnnotationView* pinView = [[MKPinAnnotationView alloc]
                                    initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
    pinView.animatesDrop=YES;
	pinView.canShowCallout=YES;
	pinView.pinColor=MKPinAnnotationColorPurple;
    pinView.rightCalloutAccessoryView = rightButton;
    
    //Block 2
    //    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"marker.png"]] ;
    //
    //  MKAnnotationView * av = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
    // av.canShowCallout=YES;
    //av.rightCalloutAccessoryView = rightButton;
    //   [av addSubview:imageView];
    //    av.centerOffset = CGPointMake(-6.0,-20.0);
    
	return pinView                      ;
}

/* Handles the loading of the detail view controller when the blue callout button is tapped. It simply checks the data list for a building
 that has a title that matches the annotation's title. */
- (CNBuilding*)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    if(control){
        for(CNBuilding *building in self.dataController.masterList){
            if([view.annotation.title isEqualToString:building.annotation.title]){
                self.mapBuilding=building;
                NSLog(@"TITLE %@", view.annotation.title);
                
                [self performSegueWithIdentifier:@"showBuildingDetailsFromMap" sender:self];
                break;
            }
            
        }
    } return nil;
}


/*prepares relevant data for particular segues*/
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    MGDetailViewController *detailViewController = [[MGDetailViewController alloc]init];  //create an instance of ClassB
    detailViewController.delegate = self;  //set self as the delegate
    
    if ([[segue identifier] isEqualToString:@"showBuildingDetailsFromMap"]) {
        
        DetailViewController *detailViewController = [segue destinationViewController];
        
        
        detailViewController.building = self.mapBuilding;
        NSLog(@"filteredObject %@", detailViewController.building.name);
        
        
    }
    if ([segue isKindOfClass:[UIStoryboardPopoverSegue class]]) {
		
		if (self.popover.popoverVisible)
			[self.popover dismissPopoverAnimated:NO]; // No animation needed; other UIPopover is taking over
		
		self.popover = [(UIStoryboardPopoverSegue *)segue popoverController];
	}
    if([[segue identifier] isEqualToString:@"Search"]){
    }
    
}


//boilerplate code to set lat/lon at a particular span
- (void)setLat:(double)lat setLon:(double) lon{
    
    MKCoordinateSpan span;
    span.latitudeDelta = (double) .01;
    span.longitudeDelta = (double).01;
    
    //Define the default region to focus on
    MKCoordinateRegion region;
    region.span=span;
    region.center=CLLocationCoordinate2DMake
    (lat,lon);
    
    //set the default region to 'region'
    [_mapView setRegion: region animated:YES];
    [_mapView regionThatFits:region];
    NSLog(@"user latitude =");
}


//crude attempt to find user's location [ needs location manager]
-(IBAction)findUser:(id)sender{
    CLLocation *userLocation =_mapView.userLocation.location;
    CLLocationCoordinate2D userCoordinate = userLocation.coordinate;
    [self setLat:userCoordinate.latitude setLon:userCoordinate.longitude];
    
}

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView

{
    
}

- (IBAction)selector:(id)sender observeValueForKeyPath:(NSString *)keyPath
            ofObject:(id)object
              change:(NSDictionary *)change
             context:(void *)context {
    MKCoordinateRegion region;
    region.center = self.mapView.userLocation.coordinate;
    MKCoordinateSpan span;
    span.latitudeDelta  = 1; // Change these values to change the zoom
    span.longitudeDelta = 1;
    region.span = span;
    [self.mapView setRegion:region animated:YES];
}


-(void)showLocation:(SettingsViewController *)controller theLat:(double)theLat theLon:(double) theLon{
    [self setLat:theLat setLon:theLon];
    [self showCampusOutline];
    
    NSLog(@"lat%f", theLat);
    NSLog(@"lon: %f", theLon);
    NSLog(@"Showing location...");
    
    
    
}

//used to change the map's type
-(void)changeMap:(NSString *)theValue{
    if([theValue isEqualToString:@"standard"]){
        _mapView.mapType = MKMapTypeStandard;
        
        
    } else if([theValue isEqualToString:@"satellite"]){
        _mapView.mapType = MKMapTypeSatellite;
        
    } else if([theValue isEqualToString:@"hybrid"]){
        _mapView.mapType = MKMapTypeHybrid;
    }
    
    
}

-(void)toggleOverlay:(SettingsViewController *)controller overlayEnabled:(BOOL *)overlayEnabled{
    if(overlayEnabled){
        NSLog(@"Enabled overlay");
        [self addOverlays];
        
    } else{
        NSLog(@"Disabled overlay");
        [_mapView removeOverlays:[_mapView overlays]];
        
    }
}
//
-(void)toggleAnnotationOverlay:(SettingsViewController *)controller annotationOverlayEnabled:(BOOL *)annotationOverlayEnabled{
    if(annotationOverlayEnabled){
        NSLog(@"Enabled overlay");
        [self addAnnotationOverlays];
        
    } else{
        NSLog(@"Disabled overlay");
        [_mapView removeAnnotations:[_mapView annotations]];
        
    }
}

- (void)toggleMenu:(id)sender {
    
}
- (IBAction)toggleKey:(id)sender {
    
    //If the keys table is currently hidden, show it with animation
    if(_keyIsHidden){
        [UIView animateWithDuration:0.3
                              delay:0
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             self.mapTypeControl.alpha=1.0;
                             self.keyView.center= CGPointMake(self.keyView.center.x,self.keyView.center.y-145);}
                         completion:^(BOOL finished){
                         }];
        
        [UIView animateWithDuration:0.2
                              delay:0.1
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             
                             self.keyView.alpha = 1.0;}
                         completion:^(BOOL finished){
                         }];
        //Set keys table as no longer hidden.
        _keyIsHidden = NO;
    } else {
        [UIView animateWithDuration:0.3
                              delay:0
                            options: UIViewAnimationCurveEaseIn
                         animations:^{
                             //   _keyView.alpha = 0.0;
                             self.mapTypeControl.alpha=0.0;
                             
                             self.keyView.center= CGPointMake(self.keyView.center.x,self.keyView.center.y+145);}
                         completion:^(BOOL finished){
                             NSLog(_keyIsHidden ? @"Yes" : @"No");
                             NSLog(@"Done!");
                         }];
        [UIView animateWithDuration:0.3
                              delay:0.2
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             self.keyView.alpha = 0.0;}
                         completion:^(BOOL finished){
                             NSLog(_keyIsHidden ? @"Yes" : @"No");
                             NSLog(@"Done!");
                         }];
        
        _keyIsHidden = YES;
        
    }
}
/*Called from DetailViewController when "Show on Map" is pressed. Receives a notification object containing
 a CNBuilding object */
-(void) onShowBuilding:(NSNotification*)notification{
    NSDictionary *values = [notification object];
    
    CNBuilding *theBuilding = [values objectForKey:@"Coordinates"];
    
    [self setLat:theBuilding.annotation.coordinate.latitude setLon:theBuilding.annotation.coordinate.longitude];
    [_mapView selectAnnotation:theBuilding.annotation animated:YES];
    MGDetailViewController *detailViewController = [[MGDetailViewController alloc]init];  //create an instance of ClassB
    detailViewController.delegate = self;  //set self as the delegate
    
    
}
-(void) onShowOnMap:(NSNotification *)notification
{
    
    NSDictionary *values = [notification object];
    
    CNBuilding *theBuilding = [values objectForKey:@"Coordinates"];
    
    [self setLat:theBuilding.annotation.coordinate.latitude setLon:theBuilding.annotation.coordinate.longitude];
    [_mapView selectAnnotation:theBuilding.annotation animated:YES];
    
}

//Simply shows the particular annotation's title etc
-(void)selectAnnotation:(id)annotation{
    [_mapView selectAnnotation:annotation animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.keys count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"KeyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    //fill table
    NSString* key = [self.keys objectAtIndex:indexPath.row];
    
    cell.textLabel.text = key;
    
    return cell;
}



/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger index = [[tableView indexPathsForVisibleRows] indexOfObject:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (index != NSNotFound) {
        UITableViewCell *cell = [[tableView visibleCells] objectAtIndex:index];
        if ([cell accessoryType] == UITableViewCellAccessoryNone) {
            for(CNBuilding *building in self.dataController.masterList){
                if([building.type isEqualToString:cell.textLabel.text]){
                    [self addBuildingPolygonsOfType:building.type];
                    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
                }}
        } else {
            for(CNBuilding *building in self.dataController.masterList){
                if([building.type isEqualToString:cell.textLabel.text]){
                    [self removeBuildingPolygonsOfType:building.type];
                    
                    [cell setAccessoryType:UITableViewCellAccessoryNone];
                }
            }
        }
        //    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    }
    
}


//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//
//    UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
//
//
//    if(newCell.accessoryType==UITableViewCellAccessoryCheckmark){
//        for(CNBuilding* building in self.dataController.masterList){
//            if([building.type isEqualToString:newCell.textLabel.text]){
//                [self removeBuildingPolygonsOfType:building.type];
//                newCell.accessoryType = UITableViewCellStyleDefault;
//                return;
//
//
//
//    } else if (newCell.accessoryType==UITableViewCellStyleDefault){
//        for(CNBuilding* building in self.dataController.masterList){
//            if([building.type isEqualToString:newCell.textLabel.text]){
//                [self addBuildingPolygonsOfType:building.type];
//
//        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
//                return;
//
//            }
//    }
//        }}
// Navigation logic may go here. Create and push another view controller.
/*
 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
 // ...
 // Pass the selected object to the new view controller.
 [self.navigationController pushViewController:detailViewController animated:YES];
 */
//    }

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{}

//- (NSInteger)numberOfTilesInMenu:(MGTileMenuController *)tileMenu
//{
//	return 9;
//}
//
//
//- (UIImage *)imageForTile:(NSInteger)tileNumber inMenu:(MGTileMenuController *)tileMenu
//{
//	NSArray *images = [NSArray arrayWithObjects:
//					   @"twitter",
//					   @"key",
//					   @"speech",
//					   @"magnifier",
//					   @"scissors",
//					   @"actions",
//					   @"Text",
//					   @"heart",
//					   @"gear",
//					   nil];
//	if (tileNumber >= 0 && tileNumber < images.count) {
//		return [UIImage imageNamed:[images objectAtIndex:tileNumber]];
//	}
//
//	return [UIImage imageNamed:@"Text"];
//}
//
//
//- (NSString *)labelForTile:(NSInteger)tileNumber inMenu:(MGTileMenuController *)tileMenu
//{
//	NSArray *labels = [NSArray arrayWithObjects:
//					   @"Twitter",
//					   @"Key",
//					   @"Speech balloon",
//					   @"Magnifying glass",
//					   @"Scissors",
//					   @"Actions",
//					   @"Text",
//					   @"Heart",
//					   @"Settings",
//					   nil];
//	if (tileNumber >= 0 && tileNumber < labels.count) {
//		return [labels objectAtIndex:tileNumber];
//	}
//
//	return @"Tile";
//}
//
//
//- (NSString *)descriptionForTile:(NSInteger)tileNumber inMenu:(MGTileMenuController *)tileMenu
//{
//	NSArray *hints = [NSArray arrayWithObjects:
//                      @"Sends a tweet",
//                      @"Unlock something",
//                      @"Sends a message",
//                      @"Zooms in",
//                      @"Cuts something",
//                      @"Shows export options",
//                      @"Adds some text",
//                      @"Marks something as a favourite",
//                      @"Shows some settings",
//                      nil];
//	if (tileNumber >= 0 && tileNumber < hints.count) {
//		return [hints objectAtIndex:tileNumber];
//	}
//
//	return @"It's a tile button!";
//}
//
//
//- (UIImage *)backgroundImageForTile:(NSInteger)tileNumber inMenu:(MGTileMenuController *)tileMenu
//{
//	if (tileNumber == 1) {
//		return [UIImage imageNamed:@"purple_gradient"];
//	} else if (tileNumber == 4) {
//		return [UIImage imageNamed:@"orange_gradient"];
//	} else if (tileNumber == 7) {
//		return [UIImage imageNamed:@"red_gradient"];
//	} else if (tileNumber == 5) {
//		return [UIImage imageNamed:@"yellow_gradient"];
//	} else if (tileNumber == 8) {
//		return [UIImage imageNamed:@"green_gradient"];
//	} else if (tileNumber == -1) {
//		return [UIImage imageNamed:@"grey_gradient"];
//	}
//
//	return [UIImage imageNamed:@"blue_gradient"];
//}
//
//
//- (BOOL)isTileEnabled:(NSInteger)tileNumber inMenu:(MGTileMenuController *)tileMenu
//{
//	if (tileNumber == 2 || tileNumber == 6) {
//		return NO;
//	}
//
//	return YES;
//}
//
//
//- (void)tileMenu:(MGTileMenuController *)tileMenu didActivateTile:(NSInteger)tileNumber
//{
//	NSLog(@"Tile %d activated (%@)", tileNumber, [self labelForTile:tileNumber inMenu:tileController]);
//}
//
//
//- (void)tileMenuDidDismiss:(MGTileMenuController *)tileMenu
//{
//	tileController = nil;
//}
//
//
//#pragma mark - Gesture handling
//
//
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//	// Ensure that only touches on our own view are sent to the gesture recognisers.
//	if (touch.view == self.view) {
//		return YES;
//	}
//
//	return NO;
//}
//
//
//- (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer
//{
//	// Find out where the gesture took place.
//	CGPoint loc = [gestureRecognizer locationInView:self.view];
//	if ([gestureRecognizer isMemberOfClass:[UITapGestureRecognizer class]] && ((UITapGestureRecognizer *)gestureRecognizer).numberOfTapsRequired == 2 && ) {
//		// This was a double-tap.
//		// If there isn't already a visible TileMenu, we should create one if necessary, and show it.
//		if (!tileController || tileController.isVisible == NO) {
//			if (!tileController) {
//				// Create a tileController.
//				tileController = [[MGTileMenuController alloc] initWithDelegate:self];
//				tileController.dismissAfterTileActivated = NO; // to make it easier to play with in the demo app.
//			}
//			// Display the TileMenu.
//			[tileController displayMenuCenteredOnPoint:loc inView:self.view];
//		}
//
//	} else {
//		// This wasn't a double-tap, so we should hide the TileMenu if it exists and is visible.
//		if (tileController && tileController.isVisible == YES) {
//			// Only dismiss if the tap wasn't inside the tile menu itself.
//			if (!CGRectContainsPoint(tileController.view.frame, loc)) {
//				[tileController dismissMenu];
//			}
//		}
//	}
//}

- (IBAction)openCampusChoice:(id)sender {
    NSLog(@"Worked");
    if(self.campusSelectionIsHidden){
        [UIView animateWithDuration:0.3
                              delay:0
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             //   _keyView.alpha = 1.0;
                             
                             _campusSelectionView.center= CGPointMake(_campusSelectionView.center.x,_campusSelectionView.center.y+140);}
                         completion:^(BOOL finished){
                             NSLog(self.campusSelectionIsHidden ? @"Yes" : @"No");
                             self.campusSelectionIsHidden= NO;
                             NSLog(@"Done!");
                         }];
        
    }else{
        
        [UIView animateWithDuration:0.3
                              delay:0
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             //   _keyView.alpha = 1.0;
                             
                             _campusSelectionView.center= CGPointMake(_campusSelectionView.center.x,_campusSelectionView.center.y-140);}
                         completion:^(BOOL finished){
                             NSLog(self.campusSelectionIsHidden ? @"Yes" : @"No");
                             NSLog(@"Done!");
                             self.campusSelectionIsHidden= YES;
                             
                         }];
        
    }}

- (IBAction)mapTypeControlTapped:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex)
    
    {
        case 0:
            // map.mapType = MKMapTypeStandard;
            [self  changeMap:@"standard"];
            break;
        case 1:
            [self  changeMap:@"satellite"];
            break;
        case 2:
            [self  changeMap:@"hybrid"];
            break;
            
        default:
            break;
    }
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber *numberForChoice = [NSNumber numberWithInt:sender.selectedSegmentIndex];
    [standardUserDefaults setObject:numberForChoice forKey:@"MFMapTypeChoice"];
    [standardUserDefaults synchronize];
    
}

-(UIImage *)prepareSiteImageFor:(CNBuilding*)building From:(MGDetailViewController*)detailViewController{
    [self setLat:building.annotation.coordinate.latitude setLon:building.annotation.coordinate.longitude];
    [_mapView selectAnnotation:building.annotation animated:YES];
    
    return[self takeScreenshot:1.0];
}

-(UIImage *)takeScreenshot:(float)scale {
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width + 40, self.view.frame.size.height + 40);
    
    // UIImageView of self
    UIGraphicsBeginImageContextWithOptions(self.view.frame.size, NO, 0);
    [[UIBezierPath bezierPathWithRoundedRect:self.view.bounds
                                cornerRadius:self.view.layer.cornerRadius] addClip];
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    UIGraphicsEndImageContext();
    
    // setup the shadow
    CGFloat cx = roundf(frame.size.width / 2), cy = roundf(frame.size.height / 2);
    cy = (int)self.view.frame.size.height % 2 ? cy + 0.5 : cy; // avoid blur
    imageView.center = CGPointMake(cx, cy);
    imageView.layer.backgroundColor = UIColor.clearColor.CGColor;
    imageView.layer.borderColor = [UIColor colorWithWhite:0.65 alpha:0.7].CGColor;
    imageView.layer.borderWidth = 1;
    imageView.layer.cornerRadius = self.view.layer.cornerRadius;
    imageView.layer.shadowColor = UIColor.blackColor.CGColor;
    imageView.layer.shadowOffset = CGSizeZero;
    imageView.layer.shadowOpacity = 0.2;
    imageView.layer.shadowRadius = 10;
    
    // final UIImage
    UIView *canvas = [[UIView alloc] initWithFrame:frame];
    [canvas addSubview:imageView];
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, scale);
    [canvas.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *final = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return final;
}


#pragma mark Broken Methods - Please disregard



//shows campus outline [not working]
-(MKOverlayView *)showCampusOutline{
    //polygon coordinates
    CLLocationCoordinate2D campusOutlineCoordinates[10]={
		
        CLLocationCoordinate2DMake(51.498772,-0.102965),
        CLLocationCoordinate2DMake(51.499012,-0.099961),
        CLLocationCoordinate2DMake(51.49781,-0.100213),
        CLLocationCoordinate2DMake(51.497125,-0.099344),
        CLLocationCoordinate2DMake(51.496728,-0.099778),
        CLLocationCoordinate2DMake(51.496417,-0.099923),
        CLLocationCoordinate2DMake(51.496681,-0.101173),
        CLLocationCoordinate2DMake(51.496361,-0.101683),
        CLLocationCoordinate2DMake(51.498057,-0.103844),
        CLLocationCoordinate2DMake(51.498485,-0.102686),
        
        
        
	};
    
    MKPolygon *campusOutline=[MKPolygon polygonWithCoordinates:campusOutlineCoordinates count:10];
    
    if([campusOutline isKindOfClass:[MKPolygon class]]){
        
        MKPolygonView *pv = [[MKPolygonView alloc] initWithPolygon:campusOutline];
        
        pv.strokeColor=[[UIColor alloc]initWithRed:0.0f/255.0f green:0.0f/255.0f blue:128.0f/255.0f alpha:0.0];
        pv.fillColor=[[UIColor alloc]initWithRed:0.0f/255.0f green:0.0f/255.0f blue:128.0f/255.0f alpha:0.0];
        
        campusOutline.title = @"Outline";
        [UIView animateWithDuration:1.0
                              delay:0
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             
                             pv.strokeColor=[[UIColor alloc]initWithRed:0.0f/255.0f green:0.0f/255.0f blue:128.0f/255.0f alpha:1.0];
                             pv.fillColor=[[UIColor alloc]initWithRed:0.0f/255.0f green:0.0f/255.0f blue:128.0f/255.0f alpha:1.0];
                             ;}
                         completion:^(BOOL finished){
                             NSLog(_keyIsHidden ? @"Yes" : @"No");
                             NSLog(@"Done!");
                         }];
        return pv;
        
    }
    return nil;
    
    
}

- (IBAction)testScreenshot:(id)sender {
    CNBuilding * building = [self.dataController.masterList objectAtIndex:0];
    
    //  UIImage* image = [self prepareSiteImageFor:<#(CNBuilding *)#> From:<#(MGDetailViewController *)#>:building];
    
}
@end
