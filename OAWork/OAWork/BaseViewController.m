//
//  BaseViewController.m
//  OAWork
//
//  Created by james on 2017/11/24.
//  Copyright © 2017年 james. All rights reserved.
//

#import "BaseViewController.h"
#import "BackButton.h"
//#define DefaultY 0
@interface BaseViewController (){
    UIView *lineView;
    UITapGestureRecognizer *tap;
}
    


@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
 
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    lineView=[[UIView alloc]initWithFrame:CGRectMake(0,1, SCREEN_WIDTH, 1)];
    lineView.backgroundColor=[Utils colorWithHexString:@"#d7d7d7"];
    [self.view addSubview:lineView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    //注册键盘消失的通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    // Do any additional setup after loading the view.
}
-(void)keyboardWasShown:(NSNotificationCenter*)notify{
    if (!tap) {
        tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiidenKeyBoard)];
       
    }
     [self.view addGestureRecognizer:tap];
}
-(void)keyboardWillBeHidden:(NSNotificationCenter*)notify{
    [self.view endEditing:YES];
    [self.view removeGestureRecognizer:tap];
}
-(void)hiddenLineView:(BOOL)hidden{
    lineView.hidden=hidden;
}
- (UIView *)createNaviTopBarWithShowBackBtn:(BOOL)showBackBtn showTitle:(BOOL)showTitle{
    
    self.navigationController.navigationBarHidden = YES;
    
    
    UIView *bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TOPBARCONTENTHEIGHT+1)];
    bar.backgroundColor= [UIColor whiteColor];
    [self.view addSubview:bar];
    _barView = bar;
    
    
    
    if(showTitle){
        UILabel *naviTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, DefaultY, bar.frame.size.width, TOPBARCONTENTHEIGHT)];
        _titleLabel = naviTitle;
        naviTitle.backgroundColor=[UIColor clearColor];
        naviTitle.textAlignment=NSTextAlignmentCenter;
        //[naviTitle setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17.0f]];
        [naviTitle setFont:[UIFont systemFontOfSize:17.0F]];
        naviTitle.textColor=[UIColor blackColor];
        [naviTitle setText:self.title];
        [bar addSubview:naviTitle];
    }
    if(showBackBtn){
        
        BackButton *back = [[BackButton alloc] init];
        back.frame = CGRectMake(0, DefaultY, 65+fix6pBackButtonWidth, TOPBARCONTENTHEIGHT);
        back.titleLabel.font=[UIFont systemFontOfSize:16.0F];
        [back setTitle:@"返回" forState:UIControlStateNormal];
        [back setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [back setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [back addTarget:self action:@selector(baseBackAction) forControlEvents:UIControlEventTouchUpInside];
        [bar addSubview:back];
        self.backButton = back;
    }
    
    // 分割线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, DefaultY+TOPBARCONTENTHEIGHT, SCREEN_WIDTH, kMinPixels)];
    line.backgroundColor = [UIColor lightGrayColor];
    [bar addSubview:line];
    
    
    return bar;
}
-(void)hiidenKeyBoard{
    [self.view endEditing:YES];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=false;
    
    BackButton *back = [[BackButton alloc] init];
    back.frame = CGRectMake(0, DefaultY, 65+fix6pBackButtonWidth, TOPBARCONTENTHEIGHT);
    back.titleLabel.font=[UIFont systemFontOfSize:16.0F];
    [back setTitle:@"返回" forState:UIControlStateNormal];
    [back setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [back setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(baseBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *menuButton2 = [[UIBarButtonItem alloc] initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = menuButton2;
    
    //    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackOpaque];
    //    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsLandscapePhone];
    //    for (UIView *view in self.navigationController.navigationBar.subviews) {
    //        if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
    //            [view removeFromSuperview];
    //        }
    //    }
    
}
-(void)baseBackAction{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
