//
//  Created by Mo on 26/11/2012.
//  Copyright (c) 2012 MoFo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CNBuilding.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
//#import "ECSlidingViewController.h"
@class CNBuilding, MGScrollView, MGDetailViewController;
@protocol MGDetailViewControllerDelegate <NSObject>
//-(void)showLocation:(MGDetailViewController *)controller theLat:(double)theLat theLon:(double) theLon;
-(UIImage *)prepareSiteImageFor:(CNBuilding*)building From:(MGDetailViewController*)detailViewController;

@end


@interface MGDetailViewController : UIViewController <UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *siteImage;

@property (strong,nonatomic) CNBuilding *building;
@property(weak,nonatomic) IBOutlet UILabel *buildingNameLabel;
@property(weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (assign) id <MGDetailViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contactLabel;
@property (weak, nonatomic) IBOutlet UILabel *campusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *buildingImage;
@property (nonatomic, weak) IBOutlet MGScrollView *scroller;
@property (weak, nonatomic) UIActionSheet *actionSheet;
@property (weak, nonatomic) NSString * distanceString;
@property (weak, nonatomic) CLLocation * currentLocation;
- (IBAction)showImage:(id)sender;
- (IBAction)hideImage:(id)sender;

- (IBAction)addToContacts:(id)sender;
- (IBAction)showDirections:(id)sender;
- (IBAction)callBuilding:(id)sender;
- (IBAction)dismissModal:(id)sender;

- (IBAction)showOnMap:(id)sender;
- (IBAction)addToAddressBook:(id)sender;

@end


/*
 @property (strong, nonatomic) id detailItem;
 
 @property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
 */
