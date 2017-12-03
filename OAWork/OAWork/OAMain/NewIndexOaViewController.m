//
//  NewIndexOaViewController.m
//  OAWork
//
//  Created by james on 2017/11/28.
//  Copyright © 2017年 james. All rights reserved.
//

#import "NewIndexOaViewController.h"
#import "OAJobDetailViewController.h"

@interface NewIndexOaViewController ()

@end

@implementation NewIndexOaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *aa=@[@{@"type":@"公文类",@"detail":@[@"发文处理类"],@"事务":@[@"发文处理类的大食物的味道"]},@{@"type":@"事务",@"detail":@[@"发文处理类的大食物的味道",@"发文处理类的大食物的味道",@"发文处理类的大食物的味道",@"发文处理类的大食物的味道",@"发文处理类的大食物的味道"]}];
    int  startY=70;
    for (int d=0; d<aa.count; d++) {
        UIView *BigView=[[UIView alloc] init];
        NSDictionary *dic=aa[d];
        NSString *type=dic[@"type"];
        NSArray *details=dic[@"detail"];
        long lineCount=(details.count%3)?(details.count)/3+1:(details.count)/3;
        BigView.frame=CGRectMake(0, startY, SCREEN_WIDTH, 30+lineCount*40);
        [self.view addSubview:BigView];
        startY =BigView.bottom;
        UILabel *titleLabe=[[UILabel alloc]initWithFrame:CGRectMake(40, 0, SCREEN_WIDTH, 30)];
        titleLabe.textColor=[UIColor blackColor];
        titleLabe.text=type;
        [BigView addSubview:titleLabe];
        for (int m=0;m<details.count;m++) {
            NSString *detail = details[m];
            int width=(SCREEN_WIDTH/3)-20;
            UIButton *detailBt=[[UIButton alloc]initWithFrame:CGRectMake(20+(SCREEN_WIDTH/3)*(m%3), 30+40*(m/3), width, 30)];
            [detailBt setTitle:detail forState:UIControlStateNormal];
             [detailBt setTitle:detail forState:UIControlStateHighlighted];
            [detailBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [detailBt addTarget:self action:@selector(detailBtTapped:) forControlEvents:UIControlEventTouchUpInside];
            [detailBt setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
            detailBt.titleLabel.adjustsFontSizeToFitWidth=YES;
            detailBt.layer.cornerRadius=5;
            detailBt.layer.borderColor=[UIColor lightGrayColor].CGColor;
            detailBt.layer.borderWidth=1.0f;
            [BigView addSubview:detailBt];
            
        }
    }
    
    // Do any additional setup after loading the view from its nib.
}
-(void)detailBtTapped:(UIButton*)bt{
    NSString *title=[bt titleForState:UIControlStateNormal];
    NSLog(@"titie%@",title);
    OAJobDetailViewController *AA=[[OAJobDetailViewController alloc]init];
    [self.navigationController pushViewController:AA animated:YES];
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
