//
//  JX01MapShowViewController.m
//  JXMapDemo
//
//  Created by JackXu on 15/11/22.
//  Copyright © 2015年 BFMobile. All rights reserved.
//

#import "JX01MapShowViewController.h"
#import <MapKit/MapKit.h>

@interface JX01MapShowViewController (){
    MKMapView *mapView;
}
@end

@implementation JX01MapShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:mapView];
}


@end
