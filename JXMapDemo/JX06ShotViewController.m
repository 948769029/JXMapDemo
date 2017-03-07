//
//  JX06ShotViewController.m
//  JXMapDemo
//
//  Created by JackXu on 15/11/22.
//  Copyright © 2015年 BFMobile. All rights reserved.
//

#import "JX06ShotViewController.h"

@interface JX06ShotViewController ()

@end

@implementation JX06ShotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(29.454686, 106.539259), 5000, 5000) animated:YES];
    //3s后创建快照
    [self performSelector:@selector(shot) withObject:nil afterDelay:3.f];
}


-(void)shot{
    MKMapSnapshotOptions *options = [[MKMapSnapshotOptions alloc] init];
    options.region = self.mapView.region;
    options.size = self.mapView.frame.size;
    options.scale = [[UIScreen mainScreen] scale];
    MKMapSnapshotter *snapshotter = [[MKMapSnapshotter alloc] initWithOptions:options];
    
    // Initialize the semaphore to 0 because there are no resources yet.
    dispatch_semaphore_t snapshotSem = dispatch_semaphore_create(0);
    
    // Get a global queue (it doesn't matter which one).
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // Create variables to hold return values. Use the __block modifier because these variables will be modified inside a block.
    __block MKMapSnapshot *mapSnapshot = nil;
    __block NSError *error = nil;
    
    // Start the asynchronous snapshot-creation task.
    [snapshotter startWithQueue:queue
              completionHandler:^(MKMapSnapshot *snapshot, NSError *e) {
                  mapSnapshot = snapshot;
                  error = e;
                  // The dispatch_semaphore_signal function tells the semaphore that the async task is finished, which unblocks the main thread.
                  dispatch_semaphore_signal(snapshotSem);
              }];
    
    // On the main thread, use dispatch_semaphore_wait to wait for the snapshot task to complete.
    dispatch_semaphore_wait(snapshotSem, DISPATCH_TIME_FOREVER);
    
    if (error) { // Handle error. }
        
        // Get the image from the newly created snapshot.
        //UIImage *image = mapSnapshot.image;
        // Optionally, draw annotations on the image before displaying it.
    }
    UIImage *image = mapSnapshot.image;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 80, 200, 200)];
    imageView.layer.borderWidth = 5.f;
    imageView.layer.borderColor = [UIColor yellowColor].CGColor;
    imageView.image = image;
    [self.view addSubview:imageView];
}

@end
