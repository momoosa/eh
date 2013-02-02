//
//  CNBuilding.h
//  MVCTest
//
//  Created by User on 01/12/2012.
//  Copyright (c) 2012 Mo. All rights reserved.
//

#import "CNAnnotation.h"
#import "CNPolygon.h"

@interface CNBuilding : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, retain) NSString* type;
@property (nonatomic, retain) NSString* campus;
@property (nonatomic, retain) NSString* contact;

@property (nonatomic, retain) CNAnnotation *annotation;
@property (nonatomic, retain) MKPolygon *polygon;
@property (nonatomic) UIImage *buildingImage;


-(id)initWithName:(NSString*)name address:(NSString*)address type:(NSString*) type campus:(NSString*) campus contact:(NSString*)contact polygon:(MKPolygon*)polygon annotation:(CNAnnotation*) annotation andImagePath:(NSString*)thePath;;
@end
