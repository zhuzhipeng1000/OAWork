//
//  ViewController.m
//  OAWork
//
//  Created by james on 2017/11/23.
//  Copyright © 2017年 james. All rights reserved.
//

#import "ViewController.h"
#import "OAMainViewController.h"
#import "CommonInfoViewController.h"
#import "DataCenterViewController.h"
#import "PersonalViewController.h"
#define tabbarHeight  49
@interface ViewController ()
{
    UIImageView *_tabBarView;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.hidden=YES;
    OAMainViewController *oa=[[OAMainViewController alloc]init];
    CommonInfoViewController *common=[[CommonInfoViewController alloc]init];
    DataCenterViewController *data=[[DataCenterViewController alloc]init];
    PersonalViewController *person=[[PersonalViewController alloc]init];

    self.viewControllers=@[oa,common,data,person];
    
    
    _tabBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-tabbarHeight, 320, tabbarHeight)];
        _tabBarView.userInteractionEnabled = YES; //这一步一定要设置为YES，否则不能和用户交互
        _tabBarView.image = [UIImage imageNamed:@"背景图片"];
    
        [self.view addSubview:_tabBarView];
    
         // 下面的方法是调用自定义的生成按钮的方法
         [self creatButtonWithNormalName:@"图片1"andSelectName:@"图片2"andTitle:@"消息"andIndex:0];
         [self creatButtonWithNormalName:@"图片3"andSelectName:@"图片4"andTitle:@"联系人"andIndex:1];
         [self creatButtonWithNormalName:@"图片5"andSelectName:@"图片6"andTitle:@"动态"andIndex:2];
         [self creatButtonWithNormalName:@"图片7"andSelectName:@"图片8"andTitle:@"设置"andIndex:3];
  
         UIButton *btn = _tabBarView.subviews[0];
    
         [self changeViewController:btn]; //自定义的控件中的按钮被点击了调用的方法，默认进入界面就选中第一个按钮
    // Do any additional setup after loading the view, typically from a nib.
}
#pragma mark 创建一个按钮
- (void)creatButtonWithNormalName:(NSString *)normal andSelectName:(NSString *)selected andTitle:(NSString *)title andIndex:(int)index{
    float width=SCREEN_WIDTH/4;
    
    UIButton *bt=[[UIButton alloc]initWithFrame:CGRectMake(index*width, 0, width, tabbarHeight)];
    [bt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [bt setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [bt setTitle:normal forState:UIControlStateNormal];
    [bt setTitle:normal forState:UIControlStateHighlighted];
    [bt addTarget:self action:@selector(changeViewController:) forControlEvents:UIControlEventTouchUpInside];
    bt.tag=index;
    [_tabBarView addSubview:bt];

}
- (void) changeViewController:(UIButton*)bt{
    self.selectedIndex=bt.tag;
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
