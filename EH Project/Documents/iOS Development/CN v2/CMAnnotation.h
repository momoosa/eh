//
//  CNAnnotation.h
//  MoFo® Maps
//
//  Created by Mo Moosa on 01/12/2012.
//  Copyright (c) 2012 MoFo®. All rights reserved.
//
//
//
//Used 

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CNAnnotation : NSObject<MKAnnotation>
@property (nonatomic, assign)	CLLocationCoordinate2D	coordinate;
@property (nonatomic, copy)		NSString*				title;
@property (nonatomic, copy)		NSString*				subtitle;

@end
