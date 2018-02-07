//
//  OAprogressMonitorViewController.m
//  OAWork
//
//  Created by JIME on 2017/12/19.
//  Copyright © 2017年 james. All rights reserved.
//

#import "OAprogressMonitorViewController.h"

@interface OAprogressMonitorViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *allArray;
@property (nonatomic,strong) UITableView *demoTableView;
@end

@implementation OAprogressMonitorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=self.infost[@"DOCNAME"];
    
    _demoTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,TOPBARCONTENTHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-TOPBARCONTENTHEIGHT)];
    [_demoTableView registerNib:[UINib nibWithNibName:@"OaMainCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"OaMainCellTableViewCell"];
    _demoTableView.delegate=self;
    _demoTableView.dataSource=self;
    _demoTableView.backgroundColor= [Utils colorWithHexString:@"#f7f7f7"];
    _demoTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_demoTableView];
    __weak __typeof(self) weakSelf = self;

    // Do any additional setup after loading the view.
}
-(void)addImageview{
//        _infost=@" 广州市教育评估和教师继续教育指导中心请假单";
    //    UILabel* titleLB=[[UILabel alloc]init];
    //    titleLB.backgroundColor=[UIColor clearColor];
    //    titleLB.numberOfLines=0;
    //    titleLB.text=_infost;
    //    titleLB.font=[UIFont systemFontOfSize:18.0f];
    //    titleLB.lineBreakMode=NSLineBreakByWordWrapping;
    //    titleLB.textAlignment=NSTextAlignmentCenter;
    //    titleLB.backgroundColor=[Utils colorWithHexString:@"#f7f7f7"];
    //    CGSize textSize=  [Utils sizeWithText:titleLB.text font:titleLB.font maxSize:CGSizeMake(SCREEN_WIDTH, 100)];
    //
    //    titleLB.frame=CGRectMake(0,TOPBARCONTENTHEIGHT, SCREEN_WIDTH, textSize.height+10);
    //    [self.view addSubview:titleLB];
    //
    //    UIImageView *imv=[[UIImageView alloc]initWithFrame:CGRectMake(0, titleLB.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-titleLB.bottom)];
    //    imv.backgroundColor=[UIColor whiteColor];
    //    imv.contentMode=UIViewContentModeScaleAspectFit;
    //    imv.image=[UIImage imageNamed:@"layer_1"];
    //    [self.view addSubview:imv];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData];
}
-(void)getData{
    
    NSDictionary *parameters =@{@"formsetInstId":self.infost[@"FORMSET_INST_ID"]};
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    _hud.mode = MBProgressHUDModeAnnularDeterminate;
    self.hud.labelText = @"数据获取中";
    __weak __typeof(self) weakSelf = self;
    [MyRequest getRequestWithUrl:[HostMangager findFormsetInstFlow] andPara:parameters isAddUserId:true Success:^(NSDictionary *dict, BOOL success) {
        [weakSelf.hud hide:YES];
        if ([dict isKindOfClass:[NSDictionary class]]&& [dict[@"code"] intValue]==0&&[dict[@"result"][@"formData"] isKindOfClass:[NSArray class]]) {
            weakSelf.allArray=[dict[@"result"][@"formData"] mutableCopy];
           [weakSelf.demoTableView reloadData];
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
#pragma mark UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *avc;
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    //        avc=[[NeedDoViewController alloc]initWithNibName:@"NeedDoViewController" bundle:nil];
    //
    //    if (avc) {
    //        [self.navigationController pushViewController:avc animated:YES];
    //    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static  NSString  *CellIdentiferId = @"OAprogressMonitorViewController";
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentiferId];
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentiferId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *startTimeLB=[[UILabel alloc]init];
        startTimeLB.font=[UIFont boldSystemFontOfSize:14.0f];
        startTimeLB.textColor=[UIColor lightGrayColor];
        startTimeLB.textAlignment=NSTextAlignmentRight;
        startTimeLB.text=@"2017-12-11";
        startTimeLB.tag=1000;
        [cell.contentView addSubview:startTimeLB];
        
        UILabel *endTimeLB=[[UILabel alloc]init];
        endTimeLB.font=[UIFont boldSystemFontOfSize:14.0f];
        endTimeLB.textColor=[UIColor lightGrayColor];
        endTimeLB.textAlignment=NSTextAlignmentRight;
        endTimeLB.text=@"2017-12-11";
         endTimeLB.tag=1001;
        [cell.contentView addSubview:endTimeLB];
        
        UILabel *progressLB=[[UILabel alloc]init];// 处理步骤
        progressLB.font=[UIFont boldSystemFontOfSize:14.0f];
        progressLB.textColor=[UIColor lightGrayColor];
        progressLB.textAlignment=NSTextAlignmentRight;
        progressLB.text=@"2017-12-11";
         progressLB.tag=1001;
        [cell.contentView addSubview:progressLB];
        
        
        UILabel *statueLB=[[UILabel alloc]init];//状态
        statueLB.font=[UIFont boldSystemFontOfSize:14.0f];
        statueLB.textColor=[UIColor lightGrayColor];
        statueLB.textAlignment=NSTextAlignmentRight;
        statueLB.text=@"2017-12-11";
         statueLB.tag=1001;
        [cell.contentView addSubview:statueLB];
        
        UILabel *progressPersonLB=[[UILabel alloc]init];// 处理人
        progressPersonLB.font=[UIFont boldSystemFontOfSize:14.0f];
        progressPersonLB.textColor=[UIColor lightGrayColor];
        progressPersonLB.textAlignment=NSTextAlignmentRight;
        progressPersonLB.text=@"2017-12-11";
         progressPersonLB.tag=1001;
        [cell.contentView addSubview:progressPersonLB];
        
        UILabel *progressDeatinationLB=[[UILabel alloc]init];// 业务流向

        progressDeatinationLB.font=[UIFont boldSystemFontOfSize:14.0f];
        progressDeatinationLB.textColor=[UIColor lightGrayColor];
        progressDeatinationLB.textAlignment=NSTextAlignmentRight;
        progressDeatinationLB.text=@"2017-12-11";
         progressDeatinationLB.tag=1001;
        [cell.contentView addSubview:progressDeatinationLB];
        
        UILabel *progressContent=[[UILabel alloc]init];// 处理意见
        progressContent.font=[UIFont boldSystemFontOfSize:14.0f];
        progressContent.textColor=[UIColor lightGrayColor];
        progressContent.textAlignment=NSTextAlignmentRight;
        progressContent.text=@"2017-12-11";
         progressContent.tag=1001;
        [cell.contentView addSubview:progressContent];
        
        
        
        "STATUS": 9,
        "WORKITEM_ID": 404182,
        "COMPLETE_TIME": 1517673124000,
        "RECEIVE_TIME": 1517673124000,
        "APP_TYPE_NAME": "预约申请",
        "DEST": "送部门审核",
        "RECEIVER": "温总富"
        
        APP_TYPE_NAME ： 处理步骤
        RECEIVER：处理人
        RECEIVER_TIME：接收时间
        DEST：业务流向
        COMPLETE_TIME：完成时间
        STATUS：状态（9：已处理，0：等待，1：新收到）
        CONTENT：处理意见
        
    };
    NSDictionary *detailDic=_allArray[indexPath.row];
   
    cell.titleLB.text=detailDic[@"TITLE"];
    cell.imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"p_%ld",(indexPath.row%3+1)]];
    cell.senderLB.text=detailDic[@"SENDNAME"];
    cell.curentLB.text=detailDic[@"CURRENTSTEP"];
    cell.timeLB.text=[Utils compareNowWithChineseString:[detailDic[@"RECEIVE_TIME"] floatValue]/1000];
    return  cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _allArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
    
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
