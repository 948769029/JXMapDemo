//
//  JX10Annotation_4ViewController.m
//  JXMapDemo
//
//  Created by JackXu on 15/11/22.
//  Copyright © 2015年 BFMobile. All rights reserved.
//

#import "JX10Annotation_4ViewController.h"
#import "MyCustomAnnotationView.h"
#import "MyCustomAnnotation.h"

@interface JX10Annotation_4ViewController ()<MKMapViewDelegate>

@end

@implementation JX10Annotation_4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(29.454686, 106.539259), 5000, 5000) animated:YES];
    MyCustomAnnotation *annotation1 = [[MyCustomAnnotation alloc] initWithLocation:CLLocationCoordinate2DMake(29.454686, 106.529259)];
    annotation1.maintitle = @"重庆理工大学";
    annotation1.secondtitle = @"计算机科学与工程学院";
    [self.mapView addAnnotation:annotation1];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MyCustomAnnotation class]]){
        MyCustomAnnotationView *annotationView = (MyCustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"MyCustomAnnotationView"];
        if (!annotationView) {
            annotationView = [[MyCustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MyCustomAnnotationView"];
            annotationView.image = [UIImage imageNamed:@"myimage"];
        }
        return annotationView;
    }
    return nil;
}

@end
