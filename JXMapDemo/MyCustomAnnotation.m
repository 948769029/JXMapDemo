//
//  MyCustomAnnotation.m
//  MapKitDemo
//
//  Created by JackXu on 15/6/21.
//  Copyright (c) 2015年 BFMobile. All rights reserved.
//

#import "MyCustomAnnotation.h"

@implementation MyCustomAnnotation
@synthesize coordinate;

- (id)initWithLocation:(CLLocationCoordinate2D)coord {
    self = [super init];
    if (self) {
        coordinate = coord;
        
    }
    return self;
}
@end
