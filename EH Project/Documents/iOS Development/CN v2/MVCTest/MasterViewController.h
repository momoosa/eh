//
//  Created by Mo on 26/11/2012.
//  Copyright (c) 2012 MoFo. All rights reserved.
//  *MasterViewController* is responsible for handling the master (search table) side
//  of the master-detail viewcontroller design pattern. It uses a data controller and must be
//  a searchbar + searchbar display delegate.

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"
@class CNDataController;
@interface MasterViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>

@property (strong, nonatomic)CNDataController *dataController;
- (IBAction)dismissView:(id)sender;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic) NSIndexPath *currentPath;
@property (nonatomic, retain) NSMutableArray *charIndex;
@property (nonatomic, retain) NSMutableDictionary *charCount;


@end
