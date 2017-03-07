//
//  CustomCalloutViewController.h
//  MapKitDemo
//
//  Created by JackXu on 15/6/22.
//  Copyright (c) 2015年 BFMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCalloutViewController : UIViewController{
    UILabel *labTitle;
}

@property (weak, nonatomic) IBOutlet UILabel *maintitle;
@property (weak, nonatomic) IBOutlet UILabel *secondtitle;

@end
