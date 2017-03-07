//
//  JX05LocationViewController.m
//  JXMapDemo
//
//  Created by JackXu on 15/11/22.
//  Copyright © 2015年 BFMobile. All rights reserved.
//

#import "JX05LocationViewController.h"

@interface JX05LocationViewController ()<CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
}

@end

@implementation JX05LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //在Info.plist右键，Add Row,添加Key为NSLocationAlwaysUsageDescription
    [self initLocation];
    self.mapView.showsUserLocation = YES;
    // Do any additional setup after loading the view.
}

-(void)initLocation {
    if (nil == locationManager)
        locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0){
        [locationManager requestWhenInUseAuthorization];
    }
    if(![CLLocationManager locationServicesEnabled]){
        NSLog(@"请开启定位:设置 > 隐私 > 位置 > 定位服务");
    }
    if([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [locationManager requestAlwaysAuthorization]; // 永久授权
        [locationManager requestWhenInUseAuthorization]; //使用中授权
    }
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    // If it's a relatively recent event, turn off updates to save power.
    CLLocation* location = [locations lastObject];
    NSLog(@"didUpdateLocations:%@",location);
}

@end