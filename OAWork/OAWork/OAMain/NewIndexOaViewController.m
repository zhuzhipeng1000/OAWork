//
//  NewIndexOaViewController.m
//  OAWork
//
//  Created by james on 2017/11/28.
//  Copyright © 2017年 james. All rights reserved.
//

#import "NewIndexOaViewController.h"
#import "OAJobDetailViewController.h"
#import "ISAlertView.h"

@interface NewIndexOaViewController ()

@end

@implementation NewIndexOaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *aa=@[@{@"type":@"公文类",@"detail":@[@"发文处理类"],@"事务":@[@"发文处理类的大食"]},@{@"type":@"事务",@"detail":@[@"发文处理",@"发文处理类的大食物的",@"发的文",@"发文处理类的大食物的味道",@"发文处理类的大食物的味道"]}];
    int  startY=70;
  
    for (int d=0; d<aa.count; d++) {
        UIView *BigView=[[UIView alloc] init];
        NSDictionary *dic=aa[d];
        NSString *type=dic[@"type"];
        NSArray *details=dic[@"detail"];
//        long lineCount=(details.count%3)?(details.count)/3+1:(details.count)/3;
      
        [self.view addSubview:BigView];
       
      
        UILabel *titleLabe=[[UILabel alloc]initWithFrame:CGRectMake(40, 0, SCREEN_WIDTH, 30)];
        titleLabe.textColor=[UIColor blackColor];
        titleLabe.text=type;
        [BigView addSubview:titleLabe];
        int   smallStartY=40;
       int  startX=20;
        for (int m=0;m<details.count;m++) {
            NSString *detail = details[m];
//            int width=(SCREEN_WIDTH/3)-20;
            CGSize size=  [Utils sizeWithText:detail font:[UIFont systemFontOfSize:15.0f] maxSize:CGSizeMake(SCREEN_WIDTH, 30)];
            int  width=size.width+20;
            UIButton *detailBt=[[UIButton alloc]init];
            if ((width+startX+20)>SCREEN_WIDTH) {
                startX=20;
                smallStartY=smallStartY+40;
                detailBt.frame=CGRectMake(startX, smallStartY, width, 30);
                startX=detailBt.right+10;
            }else{
                detailBt.frame=CGRectMake(startX, smallStartY, width, 30);
                startX=detailBt.right+10;
                
            }
          
            
            [detailBt setTitle:detail forState:UIControlStateNormal];
             [detailBt setTitle:detail forState:UIControlStateHighlighted];
            [detailBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [detailBt addTarget:self action:@selector(detailBtTapped:) forControlEvents:UIControlEventTouchUpInside];
            [detailBt setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
            detailBt.titleLabel.adjustsFontSizeToFitWidth=YES;
            detailBt.titleLabel.font=[UIFont systemFontOfSize:14.0];
            detailBt.layer.cornerRadius=15;
            detailBt.layer.borderColor=[UIColor lightGrayColor].CGColor;
            detailBt.layer.borderWidth=1.0f;
            [BigView addSubview:detailBt];
            if (m==details.count-1) {
             
                BigView.frame=CGRectMake(0, startY, SCREEN_WIDTH,detailBt.bottom+10);
                   startY= startY+ detailBt.bottom+10;
            }
        }
        
    }
    
    // Do any additional setup after loading the view from its nib.
}
-(void)detailBtTapped:(UIButton*)bt{
    NSString *title=[bt titleForState:UIControlStateNormal];
    NSLog(@"titie%@",title);
    OAJobDetailViewController *AA=[[OAJobDetailViewController alloc]init];
    [self.navigationController pushViewController:AA animated:YES];
//    ISAlertView *al=[[ISAlertView alloc]initWithTitle:nil message:@"确定删除该公文吗？" delegate:self cancelButtonTitle:nil otherButtonTitles:[@"确定"]];
//    [al show];
//    RAlertView *al=[[RAlertView alloc]initWithStyle:ConfirmAlert];
//    al.isClickBackgroundCloseWindow=false;
//    al.contentTextLabel.text=@"确定删除该公文吗？";
    
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
