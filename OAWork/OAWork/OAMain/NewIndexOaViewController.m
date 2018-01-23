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
@property (nonatomic,strong) NSMutableArray *allcateLogs;
@property (nonatomic,strong) UIScrollView *sc;
@end

@implementation NewIndexOaViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title=@"新建公文";
    if (!self.allcateLogs) {
        [self getData];
        self.sc=[[UIScrollView alloc]initWithFrame:CGRectMake(0, TOPBARCONTENTHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-TOPBARCONTENTHEIGHT)];
        self.sc.showsVerticalScrollIndicator=false;
        self.sc.scrollEnabled=true;
        self.sc.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:self.sc];
    }
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)detailBtTapped:(UIButton*)bt{
    NSString *title=[bt titleForState:UIControlStateNormal];
    NSLog(@"titie%@",title);
    
    OAJobDetailViewController *AA=[[OAJobDetailViewController alloc]init];
    AA.title=title;
    
    
    AA.categoryDic=[bt.accessibilityHint objectFromCTJSONString];
    [self.navigationController pushViewController:AA animated:YES];
//    ISAlertView *al=[[ISAlertView alloc]initWithTitle:nil message:@"确定删除该公文吗？" delegate:self cancelButtonTitle:nil otherButtonTitles:[@"确定"]];
//    [al show];
//    RAlertView *al=[[RAlertView alloc]initWithStyle:ConfirmAlert];
//    al.isClickBackgroundCloseWindow=false;
//    al.contentTextLabel.text=@"确定删除该公文吗？";
    
}
-(void)getData{
    
    
    NSDictionary *parameters =@{}; //[paa uppercaseString]};
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    _hud.mode = MBProgressHUDModeAnnularDeterminate;
    self.hud.labelText = @"数据获取中";
    __weak __typeof(self) weakSelf = self;
    [MyRequest getRequestWithUrl:[HostMangager oaTypeListUrl] andPara:parameters isAddUserId:NO Success:^(NSDictionary *dict, BOOL success) {
      [weakSelf.hud hide:YES];
        if ([dict isKindOfClass:[NSDictionary class]]&&[dict[@"result"] isKindOfClass:[NSArray class]]&& [dict[@"result"] count]>0) {
            weakSelf.allcateLogs=dict[@"result"];
            [self addView];
        }else{
           
                        UIAlertView *al=[[UIAlertView alloc]initWithTitle:nil message:@"数据获取失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                        [al show];
          
        }
        
    } fail:^(NSError *error) {
      [weakSelf.hud hide:YES];
                UIAlertView *al=[[UIAlertView alloc]initWithTitle:nil message:@"数据获取失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [al show];
    }];
    
}
-(void)addView{
    __weak __typeof(self) weakSelf = self;
//    NSArray *aa=@[@{@"type":@"公文类",@"image":@"gongwenlei",@"detail":@[@"发文处理类",@"事务类",@"发文处理类的大食"]},@{@"type":@"事务类",@"image":@"shiwulei",@"detail":@[@"发文处理类"]},@{@"type":@"事务类",@"image":@"shiwulei",@"detail":@[@"发文处理",@"发文处理类的大食物的",@"发的文",@"发文处理类的大食物的味道",@"发文处理类的大食物的味道"]},@{@"type":@"会议类",@"image":@"huiyilei",@"detail":@[@"周程月报类"]},@{@"type":@"周程月报类",@"image":@"zhouchenglei",@"detail":@[@"发文处理类"]},@{@"type":@"中心服务类",@"image":@"zhongxinlei",@"detail":@[@"发文处理类"]},@{@"type":@"工会事务",@"image":@"gonghuilei",@"detail":@[@"发文处理类"]},@{@"type":@"系统服务类",@"image":@"xitonglei",@"detail":@[@"发文处理类"]}];
    int  startY=20;
    
    for (int d=0; d<weakSelf.allcateLogs.count; d++) {
        UIView *BigView=[[UIView alloc] init];
        BigView.backgroundColor=[UIColor whiteColor];
        NSDictionary *dic=weakSelf.allcateLogs[d];
//        NSString *type=dic[@"type"];
        NSArray *details=dic[@"docs"];
        //        long lineCount=(details.count%3)?(details.count)/3+1:(details.count)/3;
        
        [self.sc addSubview:BigView];
        UIImageView *im=[[UIImageView alloc]initWithFrame:CGRectMake(10, (30-23)/2, 23, 23)];
        im.image=[UIImage imageNamed:@"gongwenlei"];
        [BigView addSubview:im];
        
        UILabel *titleLabe=[[UILabel alloc]initWithFrame:CGRectMake(40, 0, SCREEN_WIDTH, 30)];
        titleLabe.textColor=[UIColor blackColor];
        titleLabe.text=dic[@"CATEGORYNAME"];
        titleLabe.font=[UIFont systemFontOfSize:16.0f];
        [BigView addSubview:titleLabe];
        int   smallStartY=40;
        int  startX=20;
        if (details.count==0) {
            startY=startY+20;
        }
        for (int m=0;m<details.count;m++) {
            NSDictionary *detaiDic=details[m];
            NSString *detail =detaiDic[@"DOCTYPENAME"] ;
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
            
            detailBt.accessibilityHint=[detaiDic JSONStringFromCT];
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
                weakSelf.sc.contentSize=CGSizeMake(SCREEN_WIDTH, BigView.bottom);
            }
        }
        
    }
    weakSelf.sc.contentOffset=CGPointZero;
    
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
