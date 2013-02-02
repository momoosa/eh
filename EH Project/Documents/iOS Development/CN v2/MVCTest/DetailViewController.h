//
//  Created by Mo on 26/11/2012.
//  Copyright (c) 2012 MoFo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CNBuilding.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
@protocol DetailViewControllerDelegate;

@class CNBuilding;

@interface DetailViewController : UITableViewController

@property (strong,nonatomic) CNBuilding *building;
@property(weak,nonatomic) IBOutlet UILabel *buildingNameLabel;
@property(weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) id <DetailViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contactLabel;
@property (weak, nonatomic) IBOutlet UILabel *campusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *buildingImage;
- (IBAction)addToContacts:(id)sender;
- (IBAction)showDirections:(id)sender;
- (IBAction)callBuilding:(id)sender;

- (IBAction)showOnMap:(id)sender;
- (IBAction)addToAddressBook:(id)sender;

@end

@protocol DetailViewControllerDelegate <NSObject>
-(void)showLocation:(DetailViewController *)controller theLat:(double)theLat theLon:(double) theLon;
@end


/*
 @property (strong, nonatomic) id detailItem;
 
 @property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
 */
