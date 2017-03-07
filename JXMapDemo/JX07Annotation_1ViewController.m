//
//  JX07Annotation_1ViewController.m
//  JXMapDemo
//
//  Created by JackXu on 15/11/22.
//  Copyright © 2015年 BFMobile. All rights reserved.
//

#import "JX07Annotation_1ViewController.h"

@interface JX07Annotation_1ViewController ()

@end

@implementation JX07Annotation_1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(29.454686, 106.539259), 5000, 5000) animated:YES];

    //添加一个大头针
    MKPointAnnotation *annotation0 = [[MKPointAnnotation alloc] init];
    [annotation0 setCoordinate:CLLocationCoordinate2DMake(29.454686, 106.529259)];
    [annotation0 setTitle:@"重庆理工大学"];
    [annotation0 setSubtitle:@"重庆市巴南区红光大道69号"];
    [self.mapView addAnnotation:annotation0];
}


@end
