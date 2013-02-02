//
//  Created by Mo on 26/11/2012.
//  Copyright (c) 2012 MoFo. All rights reserved.
//  *MasterViewController* is responsible for handling the master (search table) side
//  of the master-detail viewcontroller design pattern. It uses a data controller and must be
//  a searchbar + searchbar display delegate.

#import "MasterViewController.h"
#import "CNDataController.h"
#import "CNBuilding.h"
#import "MGDetailViewController.h"
#import "MenuViewController.h"
@interface MasterViewController ()
@property (nonatomic, unsafe_unretained) CGFloat peekLeftAmount;

@end


@implementation MasterViewController
@synthesize peekLeftAmount;

@synthesize dataController = _dataController;
@synthesize searchBar;
@synthesize currentPath = _currentPath;
@synthesize charIndex;
@synthesize charCount;
@synthesize rightBarButton;

- (void)awakeFromNib
{
    [super awakeFromNib];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   // [searchBar setShowsScopeBar:NO];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
   // [self.tableView setBackgroundColor:[UIColor clearColor]];
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"red_nav_bar.png"]];
   // [self.view setBackgroundColor:[UIColor grayColor]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed: @"red_nav_bar.png"]
                                                  forBarMetrics:UIBarMetricsDefault];
    
    [searchBar setScopeBarBackgroundImage:[UIImage imageNamed:@"blackbar.png"]];
    
    [searchBar setBackgroundImage:[UIImage imageNamed:@"blackbar2.png"]];
    [rightBarButton setBackButtonBackgroundImage:[UIImage imageNamed:@"red_nav_bar.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [searchBar setShowsScopeBar:NO];
    [searchBar sizeToFit];
    //[rightBarButton setBackgroundImage:[UIImage imageNamed:@"red_nav_bar.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];

    CNDataController *aDataController=[[CNDataController alloc]init];
    self.dataController=aDataController;
    self.peekLeftAmount = 40.0f;
    [self.slidingViewController setAnchorLeftPeekAmount:self.peekLeftAmount];
    self.slidingViewController.underRightWidthLayout = ECVariableRevealWidth;

  //  self.navigationItem.rightBarButtonItem = self.editButtonItem;
	// Do any additional setup after loading the view, typically from a nib.
    /*
     self.navigationItem.leftBarButtonItem = self.editButtonItem;
     
     UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
     self.navigationItem.rightBarButtonItem = addButton;
     */
    [self.dataController initializeDefaultDataList];
     charIndex = [[NSMutableArray alloc] init];
    charCount = [[NSMutableDictionary alloc] init];
    
    for(int i=0; i<[self.dataController.masterList count]-1; i++)
    {
        // get the person
        CNBuilding *building = [self.dataController.masterList objectAtIndex:i];
        
        // get the first letter of the first name
        NSString *campusOfBuilding = building.type;
        
        NSLog(@"first letter: %@", campusOfBuilding);
        
        // if the index doesn't contain the letter
        if(![charIndex containsObject:campusOfBuilding])
        {
            // then add it to the index
            NSLog(@"adding: %@", campusOfBuilding);
            [charIndex addObject:campusOfBuilding];
            [charCount setObject:[NSNumber numberWithInt:1] forKey:campusOfBuilding];
        }
        [charCount setObject:[NSNumber numberWithInt:[[charCount objectForKey:campusOfBuilding] intValue] + 1] forKey:campusOfBuilding];
    }


}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    // set the section title to the matching letter
//    return [charIndex objectAtIndex:section];
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   // NSString *alphabet = [charIndex objectAtIndex:section];
    
    // get the names beginning with the letter
    
   // NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.type contains[c] %@", alphabet];
    NSArray *names = nil;

    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.dataController.filteredArray count];
    } else {
        return [self.dataController.masterList count];
    }

    
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    [self.slidingViewController setAnchorRightRevealAmount:280.0f];


}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // set the number of sections in the table to match the number of first letters
    return 1;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
/*
 - (void)insertNewObject:(id)sender
 {
 if (!_objects) {
 _objects = [[NSMutableArray alloc] init];
 }
 [_objects insertObject:[NSDate date] atIndex:0];
 NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
 [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
 }
 */

#pragma mark - Table View

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    if (tableView == self.searchDisplayController.searchResultsTableView) {
//        return [self.dataController.filteredArray count];
//    } else {
//        return [self.dataController.masterList count];
//    }
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"BuildingCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if ( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    CNBuilding* buildingAtIndex = nil;

    if (tableView == self.searchDisplayController.searchResultsTableView) {
        CNBuilding* buildingAtIndex = [self.dataController.filteredArray objectAtIndex:indexPath.row];
        [[cell textLabel]setText:buildingAtIndex.name];
        [[cell detailTextLabel]setText:buildingAtIndex.address];


    } else {
        CNBuilding* buildingAtIndex = [self.dataController.masterList objectAtIndex:indexPath.row];
        [[cell textLabel]setText:buildingAtIndex.name];
        [[cell detailTextLabel]setText:buildingAtIndex.address];

    }
//    [[cell textLabel]setText:buildingAtIndex.name];
//    [[cell detailTextLabel]setText:buildingAtIndex.address];
    //cell.imageView.image = buildingAtIndex.buildingImage;
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.slidingViewController anchorTopViewOffScreenTo:ECLeft animations:^{
        CGRect frame = self.view.frame;
        frame.origin.x = 0.0f;
        if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
            frame.size.width = [UIScreen mainScreen].bounds.size.height;
        } else if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
            frame.size.width = [UIScreen mainScreen].bounds.size.width;
        }
        self.view.frame = frame;
    } onComplete:nil];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // Perform segue to candy detail
[self performSegueWithIdentifier:@"ShowBuildingDetails" sender:tableView];
}
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _currentPath = indexPath;
    return indexPath;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_dataController.masterList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowBuildingDetails"]) {
        MGDetailViewController *detailViewController = [segue destinationViewController];
        
        if(sender == self.searchDisplayController.searchResultsTableView) {
            detailViewController.building = [self.dataController.filteredArray objectAtIndex:_currentPath.row];
            NSLog(@"filteredObject %@", detailViewController.building.name);

        }
        else {
            detailViewController.building = [self.dataController.masterList objectAtIndex:_currentPath.row];
            NSLog(@"masterObject %@", detailViewController.building.name);

        }

       // detailViewController.building = [self.dataController objectInListAtIndex:[self.tableView indexPathForSelectedRow].row];
}
    
}



- (IBAction)dismissView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	// Update the filtered array based on the search text and scope.
	
    // Remove all objects from the filtered search array
	[self.dataController.filteredArray removeAllObjects];
    
	// Filter the array using NSPredicate
    // NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@ OR SELF.type contains[c] %@ OR SELF.address contains [c] %@y",searchText, searchText, searchText];
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"self.name CONTAINS[c] %@ OR self.address CONTAINS[c] %@ OR self.type CONTAINS[c] %@", searchText, searchText, searchText];

    NSArray *tempArray = [self.dataController.masterList filteredArrayUsingPredicate:predicate];
    
    if(![scope isEqualToString:@"All"]) {
        // Further filter the array with the scope
        NSPredicate *scopePredicate = [NSPredicate predicateWithFormat:@"SELF.type contains[c] %@",scope];
        tempArray = [tempArray filteredArrayUsingPredicate:scopePredicate];
    }
    
    self.dataController.filteredArray = [NSMutableArray arrayWithArray:tempArray];
}
#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self.slidingViewController anchorTopViewOffScreenTo:ECLeft animations:^{
        CGRect frame = self.view.frame;
        frame.origin.x = 0.0f;
        if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
            frame.size.width = [UIScreen mainScreen].bounds.size.height;
        } else if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
            frame.size.width = [UIScreen mainScreen].bounds.size.width;
        }
        self.view.frame = frame;
    } onComplete:nil];
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self.slidingViewController anchorTopViewTo:ECLeft animations:^{
        CGRect frame = self.view.frame;
        frame.origin.x = self.peekLeftAmount;
        if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
            frame.size.width = [UIScreen mainScreen].bounds.size.height - self.peekLeftAmount;
        } else if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
            frame.size.width = [UIScreen mainScreen].bounds.size.width - self.peekLeftAmount;
        }
        self.view.frame = frame;
    } onComplete:nil];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
    searchBar.showsScopeBar = YES;
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar sizeToFit];
    searchBar.showsScopeBar = NO;
    return YES;
}


@end
