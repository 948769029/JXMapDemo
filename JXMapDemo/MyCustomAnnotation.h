//
//  MyCustomAnnotation.h
//  MapKitDemo
//
//  Created by JackXu on 15/6/21.
//  Copyright (c) 2015年 BFMobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyCustomAnnotation : NSObject <MKAnnotation> {
    CLLocationCoordinate2D coordinate;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) NSString *maintitle;
@property (nonatomic, strong) NSString *secondtitle;

- (id)initWithLocation:(CLLocationCoordinate2D)coord;

@end
