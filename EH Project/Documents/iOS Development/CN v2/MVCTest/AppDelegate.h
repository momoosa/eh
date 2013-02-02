//
//  AppDelegate.h
//  MVCTest
//
//  Created by User on 01/12/2012.
//  Copyright (c) 2012 Mo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstRunDialogViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
