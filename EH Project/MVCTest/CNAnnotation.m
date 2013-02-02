//
//  Created by User on 01/12/2012.
//  Copyright (c) 2012 edu.self. All rights reserved.
//

#import "CNAnnotation.h"

@implementation CNAnnotation
@synthesize title;
@synthesize subtitle;
@synthesize coordinate;

- (void)dealloc
{
	self.title = nil;
	self.subtitle = nil;
}
@end
