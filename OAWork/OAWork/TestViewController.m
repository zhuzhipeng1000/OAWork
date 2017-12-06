//
//  TestViewController.m
//  OAWork
//
//  Created by james on 2017/12/6.
//  Copyright © 2017年 james. All rights reserved.
//

#import "TestViewController.h"
#import "OAJobDetailViewController.h"

@interface TestViewController ()
{
    
    UITextField *_tableView;
}

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    UIButton *bt=[[UIButton alloc]initWithFrame:CGRectMake(69, 90, 200, 50)];
    [bt setTitle:@"test" forState:UIControlStateNormal];
    [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(tapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bt];
    // Do any additional setup after loading the view.
}
-(void)tapped{
    
    OAJobDetailViewController *login=[[OAJobDetailViewController alloc]init];
    [self.navigationController pushViewController:login animated:YES];
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
