//
//  Created by Mo Moosa on 01/12/2012.
//  Copyright (c) 2012 MoFo. All rights reserved.
//  CNDataController currently loads static data
//  but will ultimately load and parse JSON data
//  which will then be stored in Core Data.

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "CNAnnotation.h"
@class CNBuilding;

@interface CNDataController : NSObject

@property (nonatomic, copy) NSMutableArray *masterList;
@property (nonatomic, retain) NSMutableArray *filteredArray;
-(NSUInteger)countOfList;
-(CNBuilding *)objectInListAtIndex: (NSUInteger)theIndex;
-(void)addBuildingWithName:(NSString *)theName type:(NSString*)theType address:(NSString* )theAddress campus:(NSString*)theCampus contact:(NSString*)theContact polygon:(MKPolygon *)thePolygon andImagePath:(NSString*)thePath;
-(void)initializeDefaultDataList;

@end
