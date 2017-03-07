//
//  MyCustomAnnotationView.h
//  MapKitDemo
//
//  Created by JackXu on 15/6/22.
//  Copyright (c) 2015年 BFMobile. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "CustomCalloutViewController.h"
@class MyCustomAnnotation;
@interface MyCustomAnnotationView : MKPinAnnotationView
- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier;
@property(strong,nonatomic)CustomCalloutViewController *calloutViewController;
@property(strong,nonatomic)MyCustomAnnotation *myCustomAnnotation;
@end
