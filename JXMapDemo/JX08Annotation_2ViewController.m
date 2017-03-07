//
//  JX08Annotation_2ViewController.m
//  JXMapDemo
//
//  Created by JackXu on 15/11/22.
//  Copyright © 2015年 BFMobile. All rights reserved.
//

#import "JX08Annotation_2ViewController.h"

@interface JX08Annotation_2ViewController ()<MKMapViewDelegate>

@end

@implementation JX08Annotation_2ViewController

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


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    // If the annotation is the user location, just return nil.（如果是显示用户位置的Annotation,则使用默认的蓝色圆点）
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    if ([annotation isKindOfClass:[MKPointAnnotation class]]) {
        // Try to dequeue an existing pin view first.（这里跟UITableView的重用差不多）
        MKPinAnnotationView *customPinView = (MKPinAnnotationView*)[mapView
                                                                    dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        if (!customPinView){
            // If an existing pin view was not available, create one.
            customPinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                      reuseIdentifier:@"CustomPinAnnotationView"];
        }
        //iOS9中用pinTintColor代替了pinColor
        customPinView.pinColor = MKPinAnnotationColorPurple;
        customPinView.animatesDrop = YES;
        customPinView.canShowCallout = YES;
        
        UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 50)];
        rightButton.backgroundColor = [UIColor grayColor];
        [rightButton setTitle:@"查看详情" forState:UIControlStateNormal];
        customPinView.rightCalloutAccessoryView = rightButton;
        
        // Add a custom image to the left side of the callout.（设置弹出起泡的左面图片）
        UIImageView *myCustomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"myimage"]];
        customPinView.leftCalloutAccessoryView = myCustomImage;
        return customPinView;
    }
    return nil;//返回nil代表使用默认样式
}


-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    NSLog(@"点击了查看详情");
}



@end
