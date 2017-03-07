//
//  JX04ZooomMapController.m
//  JXMapDemo
//
//  Created by JackXu on 15/11/22.
//  Copyright © 2015年 BFMobile. All rights reserved.
//

#import "JX04ZooomMapController.h"

@interface JX04ZooomMapController ()

@end

@implementation JX04ZooomMapController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置显示重庆理工大学(29.454686, 106.529259)
    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(29.454686, 106.539259), 5000, 5000) animated:YES];
    [self performSelector:@selector(pan) withObject:nil afterDelay:3.f];
    [self performSelector:@selector(zoom) withObject:nil afterDelay:6.f];
}

//往左移动当前地图宽度的一半的距离
-(void)pan{
    CLLocationCoordinate2D mapCenter = self.mapView.centerCoordinate;
    mapCenter = [self.mapView convertPoint:
                 CGPointMake(1, (self.mapView.frame.size.width/2.0))
                      toCoordinateFromView:self.mapView];
    [self.mapView setCenterCoordinate:mapCenter animated:YES];
}

//放大
-(void)zoom{
    MKCoordinateRegion theRegion = self.mapView.region;

    // Zoom in
    theRegion.span.longitudeDelta *= 0.5;
    theRegion.span.latitudeDelta *= 0.5;
    [self.mapView setRegion:theRegion animated:YES];
}

@end
