//
//  JX09Annotation_3ViewController.m
//  JXMapDemo
//
//  Created by JackXu on 15/11/22.
//  Copyright © 2015年 BFMobile. All rights reserved.
//

#import "JX09Annotation_3ViewController.h"

@interface JX09Annotation_3ViewController ()<MKMapViewDelegate>

@end

@implementation JX09Annotation_3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(29.454686, 106.539259), 5000, 5000) animated:YES];
    MKPointAnnotation *annotation0 = [[MKPointAnnotation alloc] init];
    [annotation0 setCoordinate:CLLocationCoordinate2DMake(29.454686, 106.529259)];
    [annotation0 setTitle:@"重庆理工大学"];
    [annotation0 setSubtitle:@"重庆市巴南区红光大道69号"];
    [self.mapView addAnnotation:annotation0];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // If the annotation is the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    if ([annotation isKindOfClass:[MKPointAnnotation class]]) {
        MKAnnotationView* aView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MKPointAnnotation"];
        aView.image = [UIImage imageNamed:@"myimage"];
        aView.canShowCallout = YES;
        return aView;
    }
    return nil;
}




@end
