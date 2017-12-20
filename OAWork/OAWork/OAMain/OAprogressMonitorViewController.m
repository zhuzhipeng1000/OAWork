//
//  OAprogressMonitorViewController.m
//  OAWork
//
//  Created by JIME on 2017/12/19.
//  Copyright © 2017年 james. All rights reserved.
//

#import "OAprogressMonitorViewController.h"

@interface OAprogressMonitorViewController ()
@property (nonatomic,strong) NSDictionary *dic;
@end

@implementation OAprogressMonitorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _infost=@" 广州市教育评估和教师继续教育指导中心请假单";
    UILabel* titleLB=[[UILabel alloc]init];
    titleLB.backgroundColor=[UIColor clearColor];
    titleLB.numberOfLines=0;
    titleLB.text=_infost;
    titleLB.font=[UIFont systemFontOfSize:18.0f];
    titleLB.lineBreakMode=NSLineBreakByWordWrapping;
    titleLB.textAlignment=NSTextAlignmentCenter;
    titleLB.backgroundColor=[Utils colorWithHexString:@"#f7f7f7"];
    CGSize textSize=  [Utils sizeWithText:titleLB.text font:titleLB.font maxSize:CGSizeMake(SCREEN_WIDTH, 100)];
   
    titleLB.frame=CGRectMake(0,TOPBARCONTENTHEIGHT, SCREEN_WIDTH, textSize.height+10);
    [self.view addSubview:titleLB];
    
    UIImageView *imv=[[UIImageView alloc]initWithFrame:CGRectMake(0, titleLB.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-titleLB.bottom)];
    imv.backgroundColor=[UIColor whiteColor];
    imv.contentMode=UIViewContentModeScaleAspectFit;
    imv.image=[UIImage imageNamed:@"layer_1"];
    [self.view addSubview:imv];
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
