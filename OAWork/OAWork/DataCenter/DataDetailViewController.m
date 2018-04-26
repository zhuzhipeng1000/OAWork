//
//  DataDetailViewController.m
//  OAWork
//
//  Created by james on 2018/4/26.
//  Copyright © 2018年 james. All rights reserved.
//

#import "DataDetailViewController.h"

@interface DataDetailViewController ()
@property (nonatomic,strong) UIWebView *aWeb;
@end

@implementation DataDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=_detailDic[@"FILENAME"];
    [self createNaviTopBarWithShowBackBtn:false showTitle:YES];
    _aWeb=[[UIWebView alloc]initWithFrame:CGRectMake(0, TOPBARCONTENTHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-TOPBARCONTENTHEIGHT)];
    [_aWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_detailDic[@"PATH"]]]];
    [self.view addSubview:_aWeb];
    
    // Do any additional setup after loading the view.
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
