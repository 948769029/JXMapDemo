# JXMapDemo
#简介
关于苹果系统地图的使用，大多数人都不陌生，但是对于地图的灵活运用，好多都是现从网上搜索。我这里简单的整理下JackXu写的一个对于地图的总体运用，功能如图所示

![Paste_Image.png](http://upload-images.jianshu.io/upload_images/1097226-01d503e56ac1620f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
我这里就简单的介绍下，功能代码以上传，你们可以直接[下载Demo](https://github.com/948769029/JXMapDemo)

####1、显示地图
```
mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
[self.view addSubview:mapView];
```
###2、显示指定区域
```
//设置显示重庆理工大学(29.454686, 106.529259)
[self.mapView setRegion:MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(29.454686, 106.539259), 5000, 5000) animated:YES];
```
###3、显示3D地图
```
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
```
###4、滑动和缩放地图
```
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置显示重庆理工大学(29.454686, 106.529259)
    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(29.454686, 106.539259), 5000, 5000) animated:YES];
    [self performSelector:@selector(pan) withObject:nil afterDelay:3.f];
    [self performSelector:@selector(zoom) withObject:nil afterDelay:6.f];
}

//往左移动当前地图宽度的一半的距离
-(void)pan{
    CLLocationCoordinate2D mapCenter = self.mapView.centerCoordinate;
    mapCenter = [self.mapView convertPoint:
                 CGPointMake(1, (self.mapView.frame.size.width/2.0))
                      toCoordinateFromView:self.mapView];
    [self.mapView setCenterCoordinate:mapCenter animated:YES];
}

//放大
-(void)zoom{
    MKCoordinateRegion theRegion = self.mapView.region;

    // Zoom in
    theRegion.span.longitudeDelta *= 0.5;
    theRegion.span.latitudeDelta *= 0.5;
    [self.mapView setRegion:theRegion animated:YES];
}
```
###5、显示用户当前位置
```
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
```
###6、创建一个地图快照
```
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
```
###7、添加一个大头针
```
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
```
###8、修改气泡内容
```
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
```
###9、修改大头针样式
```
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
```
###10、自定义大头针跟气泡
```
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
```
