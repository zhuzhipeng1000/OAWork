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
    self.title=@"新建公文";
    UIScrollView *sc=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    sc.showsVerticalScrollIndicator=false;
    sc.scrollEnabled=true;
    sc.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:sc];
    NSArray *aa=@[@{@"type":@"公文类",@"image":@"gongwenlei",@"detail":@[@"发文处理类",@"事务类",@"发文处理类的大食"]},@{@"type":@"事务类",@"image":@"shiwulei",@"detail":@[@"发文处理类"]},@{@"type":@"事务类",@"image":@"shiwulei",@"detail":@[@"发文处理",@"发文处理类的大食物的",@"发的文",@"发文处理类的大食物的味道",@"发文处理类的大食物的味道"]},@{@"type":@"会议类",@"image":@"huiyilei",@"detail":@[@"周程月报类"]},@{@"type":@"周程月报类",@"image":@"zhouchenglei",@"detail":@[@"发文处理类"]},@{@"type":@"中心服务类",@"image":@"zhongxinlei",@"detail":@[@"发文处理类"]},@{@"type":@"工会事务",@"image":@"gonghuilei",@"detail":@[@"发文处理类"]},@{@"type":@"系统服务类",@"image":@"xitonglei",@"detail":@[@"发文处理类"]}];
    int  startY=20;
  
    for (int d=0; d<aa.count; d++) {
        UIView *BigView=[[UIView alloc] init];
        BigView.backgroundColor=[UIColor whiteColor];
        NSDictionary *dic=aa[d];
        NSString *type=dic[@"type"];
        NSArray *details=dic[@"detail"];
//        long lineCount=(details.count%3)?(details.count)/3+1:(details.count)/3;
      
        [sc addSubview:BigView];
        UIImageView *im=[[UIImageView alloc]initWithFrame:CGRectMake(10, (30-23)/2, 23, 23)];
        im.image=[UIImage imageNamed:dic[@"image"]];
        [BigView addSubview:im];
      
        UILabel *titleLabe=[[UILabel alloc]initWithFrame:CGRectMake(40, 0, SCREEN_WIDTH, 30)];
        titleLabe.textColor=[UIColor blackColor];
        titleLabe.text=type;
        titleLabe.font=[UIFont systemFontOfSize:16.0f];
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
                sc.contentSize=CGSizeMake(SCREEN_WIDTH, BigView.bottom);
            }
        }
        
    }
    
    // Do any additional setup after loading the view from its nib.
}
-(void)detailBtTapped:(UIButton*)bt{
    NSString *title=[bt titleForState:UIControlStateNormal];
    NSLog(@"titie%@",title);
    OAJobDetailViewController *AA=[[OAJobDetailViewController alloc]init];
    AA.title=title;
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
