//
//  JX02PortionMapController.m
//  JXMapDemo
//
//  Created by JackXu on 15/11/22.
//  Copyright © 2015年 BFMobile. All rights reserved.
//

#import "JX02PortionMapController.h"

@interface JX02PortionMapController ()
@end

@implementation JX02PortionMapController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置显示重庆理工大学(29.454686, 106.529259)
    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(29.454686, 106.539259), 5000, 5000) animated:YES];
}


@end
