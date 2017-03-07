//
//  JX033DMapController.m
//  JXMapDemo
//
//  Created by JackXu on 15/11/22.
//  Copyright © 2015年 BFMobile. All rights reserved.
//

#import "JX033DMapController.h"

@interface JX033DMapController ()
@end

@implementation JX033DMapController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置显示重庆理工大学(29.454686, 106.529259)
    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(29.454686, 106.539259), 5000, 5000) animated:YES];
    // Create a coordinate structure for the location.
    CLLocationCoordinate2D ground = CLLocationCoordinate2DMake(29.454686, 106.529259);
    // Create a coordinate structure for the point on the ground from which to view the location.
    CLLocationCoordinate2D eye = CLLocationCoordinate2DMake(29.545686, 106.628259);
    // Ask Map Kit for a camera that looks at the location from an altitude of 100 meters above the eye coordinates.
    MKMapCamera *myCamera = [MKMapCamera cameraLookingAtCenterCoordinate:ground fromEyeCoordinate:eye eyeAltitude:100];
    // Assign the camera to your map view
    self.mapView.camera = myCamera;
}



@end
