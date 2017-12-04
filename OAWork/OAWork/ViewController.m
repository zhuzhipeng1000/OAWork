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
@property (nonatomic,strong) UIViewController* currentController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
      self.navigationController.navigationBarHidden = YES;
    self.tabBarController.navigationController.navigationBarHidden=YES;
    self.view.backgroundColor=[UIColor whiteColor];
//     [self createNaviTopBarWithShowBackBtn:false showTitle:YES];
  
    
    
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
 
    
    for (CTTabBarEntity *selectedEntity in entitys) {
        
        Class  CDVcontrolller =  NSClassFromString(selectedEntity.controllerName);
        UIViewController *avct=[[CDVcontrolller alloc]init];
        [self addChildViewController:avct];
    }
    
    _tabBarView = [[CTTabBarView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-tabbarHeight, SCREEN_WIDTH, tabbarHeight) target:self Entity:entitys];
    
    [self.view addSubview:_tabBarView];
   [_tabBarView selectIndex:0];
    
}
#pragma mark 点击tabitem代理
#pragma mark 点击tabitem代理
- (void)selectIndex:(int)selectedInt{
    [_tabBarView selectIndex:selectedInt];
}
- (void)selectedItemAction:(CTTabBarEntity *)selectedEntity{
    UIViewController *newController = self.childViewControllers[selectedEntity.index];
    CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT - 64);
    
    if(newController ==self.currentController){
        return;
    }
    if (self.currentController) {
        [self.currentController willMoveToParentViewController:self];
        newController.view.frame=frame;
        [self transitionFromViewController:self.currentController toViewController:newController duration:0 options:0 animations:nil completion:^(BOOL finished) {
            self.currentController = newController;
            [newController didMoveToParentViewController:self];
            [self.view bringSubviewToFront:_tabBarView];
        }];
        
    }else{
        [newController.view setFrame:frame];
        [self.view addSubview:newController.view];
        self.currentController = newController;
        [self.view bringSubviewToFront:_tabBarView];
    }
    
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
    first.normalImgName=@"tab_1_1";
    first.selectedImgName=@"tab_1_1";
    first.uri=@"information/pages/module_homepage/index.html";
    first.controllerName=@"OAMainViewController";

    

    
    CTTabBarEntity *second = [[CTTabBarEntity alloc]init];
    second.index=1;
    second.isSelected=NO;
    second.titleStr=@"信息";
    second.normalImgName=@"tab_2";
    second.selectedImgName=@"tab_2";
    second.uri=@"https://www.baidu.com";
    second.controllerName=@"CommonInfoViewController";
    
    
    CTTabBarEntity *third = [[CTTabBarEntity alloc]init];
    third.index=2;
    third.isSelected=NO;
    third.titleStr=@"资料库";
    third.normalImgName=@"tab_3";
    third.selectedImgName=@"tab_3";
    third.uri=@"followup/pages/module_myCustomerBf/index.html";
    third.controllerName=@"DataCenterViewController";
    
    
    
    CTTabBarEntity *myModuleEntity = [[CTTabBarEntity alloc]init];
    myModuleEntity.index=3;
    myModuleEntity.isSelected=NO;
    myModuleEntity.titleStr=@"个人";
    myModuleEntity.normalImgName=@"tab_4";
    myModuleEntity.selectedImgName=@"tab_4";
    myModuleEntity.controllerName=@"PersonalViewController";
    myModuleEntity.uri = @"myaccount/pages/module_myAccount_bupmBf/index.html";
    
    return @[first,second,third,myModuleEntity];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
