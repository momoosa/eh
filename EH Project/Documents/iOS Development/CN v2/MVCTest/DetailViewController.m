//
//  Created by Mo Moosa on 26/11/2012.
//  Copyright (c) 2012 MoFo. All rights reserved.
//

#import "DetailViewController.h"
#import "CNBuilding.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <Social/Social.h>
@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

@synthesize building=_building, addressLabel=_addressLabel;
@synthesize buildingImage = _buildingImage;
@synthesize typeLabel=_typeLabel,contactLabel=_contactLabel, delegate = _delegate;

#pragma mark - Managing the detail item

-(void)setBuilding:(CNBuilding *) newBuilding{
    if (_building != newBuilding) {
        _building = newBuilding;
        
        // Update the view.
        //[self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    CNBuilding *theBuilding = self.building;
    
    static NSDateFormatter *formatter = nil;
    if(formatter == nil){
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        
    }
    if (theBuilding) {
        self.buildingNameLabel.text = theBuilding.name;
        NSLog(@"buildingDetails %@", self.buildingNameLabel.text);

        self.addressLabel.text = theBuilding.address;
        self.typeLabel.text = theBuilding.type;
        self.contactLabel.text = theBuilding.contact;
        self.buildingImage.image = theBuilding.buildingImage;
        self.navigationItem.title = theBuilding.name;
        
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self configureView];
}

- (void)viewDidUnload
{
    self.building = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    // BATTrailsViewController *trailsController = [[BATTrailsViewController alloc] initWithStyle:UITableViewStylePlain];
    // trailsController.selectedRegion = [regions objectAtIndex:indexPath.row];
    // [[self navigationController] pushViewController:trailsController animated:YES];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (IBAction)callBuilding:(id)sender {
//    NSString *phoneNumber = [@"tel:" stringByAppendingString:self.building.contact];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    
    if (NSClassFromString(@"UIActivityViewController")) {
        NSString *textObject = @"This is a test from MoFo Education.";
        NSURL *url = [NSURL URLWithString:@"http://www.momoosa.com"];
        UIImage *image = [UIImage imageNamed:@"CN_Retina_iphone.png"];
        NSArray *activityItems = [NSArray arrayWithObjects:textObject, url, image, nil];
        
        //-- initialising the activity view controller
        UIActivityViewController *avc = [[UIActivityViewController alloc]
                                         initWithActivityItems:activityItems
                                         applicationActivities:nil];
        
        //-- define the activity view completion handler
        avc.completionHandler = ^(NSString *activityType, BOOL completed){
            NSLog(@"Activity Type selected: %@", activityType);
            if (completed) {
                NSLog(@"Selected activity was performed.");
            } else {
                if (activityType == NULL) {
                    NSLog(@"User dismissed the view controller without making a selection.");
                } else {
                    NSLog(@"Activity was not performed.");
                }
            }
        
        };
        avc.excludedActivityTypes = [NSArray arrayWithObjects:UIActivityTypeAssignToContact, nil];
        
        //-- show the activity view controller
        [self presentViewController:avc
                           animated:YES completion:nil];

    }
}

- (IBAction)showOnMap:(id)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowOnMap" object:[NSDictionary dictionaryWithObject:self.building
                                                                                                               forKey:@"Coordinates"]];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addToAddressBook:(id)sender {

        // Create the pre-filled properties
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:1234567890"]];
    ABRecordRef newPerson = ABPersonCreate();
    CFErrorRef error = NULL;
    NSString*name = self.building.name;
    
    ABRecordSetValue(newPerson, kABPersonOrganizationProperty, (__bridge CFTypeRef)(name), &error);
    ABRecordSetValue(newPerson, kABPersonDepartmentProperty,  (__bridge CFTypeRef)(self.building.type), &error);
    


    
//    ABRecordSetValue(newPerson, kABPersonImageFormatThumbnail,  (__bridge CFTypeRef)(self.building.buildingImage), &error);
//
//    ABRecordSetValue(newPerson, kABPersonImageFormatOriginalSize,  (__bridge CFTypeRef)(self.building.buildingImage), &error);

    
    ABRecordSetValue(newPerson, kABPersonDepartmentProperty,  (__bridge CFTypeRef)(self.building.type), &error);


    ABNewPersonViewController *newPersonVC = [[ABNewPersonViewController alloc] init];
    newPersonVC.newPersonViewDelegate = self;
    newPersonVC.displayedPerson = newPerson;
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:newPersonVC];
    [self presentViewController:nc animated:YES completion:nil];
    

}
- (void)newPersonViewController:(ABNewPersonViewController *)newPersonView didCompleteWithNewPerson:(ABRecordRef)person
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showDirections:(id)sender {
    
    CLLocationCoordinate2D start = { 51.497496, -0.101731 };
    
    // CLLocationCoordinate2D destination = { 37.322778, -122.031944 };
    
    NSString *googleMapsURLString = [NSString stringWithFormat:@"http://maps.apple.com?q=saddr=%1.6f,%1.6f&daddr=%1.6f,%1.6f",
                                     start.latitude, start.longitude, self.building.annotation.coordinate.latitude, self.building.annotation.coordinate.longitude];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:googleMapsURLString]];
}

@end
