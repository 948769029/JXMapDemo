//
//  MainViewController.m
//  JXMapDemo
//
//  Created by JackXu on 15/11/22.
//  Copyright © 2015年 BFMobile. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) NSArray *menuTitle;
@property(nonatomic,strong) NSArray *menuVC;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - 加载数据
-(NSArray*)menuTitle{
    if(_menuTitle==nil){
        _menuTitle = @[@"显示地图",@"显示指定区域",@"显示3D地图",@"滑动和缩放地图",@"显示用户当前位置",@"创建一个地图快照",@"添加大头针",@"修改气泡内容",@"修改大头针样式",@"自定义大头针和气泡"];
    }
    return _menuTitle;
}

-(NSArray*)menuVC{
    if (_menuVC==nil) {
        _menuVC = @[@"JX01MapShowViewController",@"JX02PortionMapController",@"JX033DMapController",@"JX04ZooomMapController",@"JX05LocationViewController",@"JX06ShotViewController",@"JX07Annotation_1ViewController",@"JX08Annotation_2ViewController",@"JX09Annotation_3ViewController",@"JX10Annotation_4ViewController"];
    }
    return _menuVC;
}


#pragma mark - UITableViewDataSource&UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.menuTitle.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *tableViewID = @"MainTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewID];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewID];
    }
    cell.textLabel.text = self.menuTitle[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *classStr = self.menuVC[indexPath.row];
    Class c = NSClassFromString(classStr);
    UIViewController *vc = [[c alloc] initWithNibName:classStr bundle:nil];
    vc.title = self.menuTitle[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
