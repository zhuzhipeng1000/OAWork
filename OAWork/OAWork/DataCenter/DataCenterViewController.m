//
//  DataCenterViewController.m
//  OAWork
//
//  Created by james on 2017/11/24.
//  Copyright © 2017年 james. All rights reserved.
//

#import "DataCenterViewController.h"

@interface DataCenterViewController ()

@end

@implementation DataCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"电子资料库";
        [self createNaviTopBarWithShowBackBtn:false showTitle:YES];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=true;
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
