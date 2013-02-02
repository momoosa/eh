//
//  CNBuilding.m
//  MVCTest
//
//  Created by User on 01/12/2012.
//  Copyright (c) 2012 Mo. All rights reserved.
//

#import "CNBuilding.h"

@implementation CNBuilding

-(id)initWithName:(NSString*)name address:(NSString*)address type:(NSString*)type  campus:(NSString*) campus contact:(NSString*)contact polygon:(MKPolygon*)polygon annotation:(CNAnnotation*) annotation andImagePath:(NSString*)thePath{
    
    self = [super init];
    
    if(self) {
        _name = name;
        _address = address;
        _type = type;
        _campus = campus;
        _contact = contact;
        _polygon = polygon;
        _annotation = annotation;
        _buildingImage = [UIImage imageNamed:thePath];
        return self;
    }
    return nil;
}

@end
