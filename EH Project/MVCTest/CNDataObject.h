//
//  Created by Mo Moosa on 01/12/2012.
//  Copyright (c) 2012 edu.self. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "CNAnnotation.h"
#import "CNPolygon.h"

@interface CNDataObject : NSObject

@property (nonatomic, retain) CNAnnotation *annotation;
@property (nonatomic, retain) CNPolygon *polygon;

@end
