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
#import "CTTabBarEntity.h"
#import "CTTabBarView.h"
#define tabbarHeight  49
@interface ViewController ()
{
    CTTabBarView *_tabBarView;
    
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
    
    
//    _tabBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-tabbarHeight, 320, tabbarHeight)];
//        _tabBarView.userInteractionEnabled = YES; //这一步一定要设置为YES，否则不能和用户交互
//       
//    
//        [self.view addSubview:_tabBarView];
    
    [self addTabbar];
         // 下面的方法是调用自定义的生成按钮的方法
    
      // Do any additional setup after loading the view, typically from a nib.
}
#pragma mark 创建一个按钮
-(void)addTabbar{
    //添加底部的tabbar
    NSArray *entitys = [self getItemEntityArray];
   
    
    _tabBarView = [[CTTabBarView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-tabbarHeight, SCREEN_WIDTH, tabbarHeight) target:self Entity:entitys];
    
    [self.view addSubview:_tabBarView];
   [_tabBarView selectIndex:0];
    
}
#pragma mark 点击tabitem代理
- (void)selectIndex:(int)selectedInt{
    [_tabBarView selectIndex:selectedInt];
    [self selectIndex:selectedInt];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
#pragma mark - TableBar 组装
//组装菜单数组
- (NSArray *)getItemEntityArray{
    
    CTTabBarEntity *first = [[CTTabBarEntity alloc]init];
    first.index=0;
    first.isSelected=YES;
    first.titleStr=@"首页";
    first.normalImgName=@"desk_default";
    first.selectedImgName=@"desk_selected";
    first.uri=@"information/pages/module_homepage/index.html";
    first.controllerName=@"DeskViewController";
    
    
    CTTabBarEntity *second = [[CTTabBarEntity alloc]init];
    second.index=1;
    second.isSelected=NO;
    second.titleStr=@"信息";
    second.normalImgName=@"project_default";
    second.selectedImgName=@"project_selected";
    second.uri=@"https://www.baidu.com";
    second.controllerName=@"ProjectViewController";
    
    
    CTTabBarEntity *third = [[CTTabBarEntity alloc]init];
    third.index=2;
    third.isSelected=NO;
    third.titleStr=@"资料库";
    third.normalImgName=@"message_default";
    third.selectedImgName=@"message_seleted";
    third.uri=@"followup/pages/module_myCustomerBf/index.html";
    third.controllerName=@"MessageListViewController";
    
    
    
    CTTabBarEntity *myModuleEntity = [[CTTabBarEntity alloc]init];
    myModuleEntity.index=3;
    myModuleEntity.isSelected=NO;
    myModuleEntity.titleStr=@"个人";
    myModuleEntity.normalImgName=@"main_defu";
    myModuleEntity.selectedImgName=@"main_head_selected";
    myModuleEntity.controllerName=@"MainViewController";
    myModuleEntity.uri = @"myaccount/pages/module_myAccount_bupmBf/index.html";
    
    return @[first,second,third,myModuleEntity];
}
- (void) changeViewController:(UIButton*)bt{
    self.selectedIndex=bt.tag;
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
