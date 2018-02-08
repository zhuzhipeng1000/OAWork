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
        if ([dict isKindOfClass:[NSDictionary class]]&& [dict[@"code"] intValue]==0&&[dict[@"result"] isKindOfClass:[NSArray class]]) {
            weakSelf.allArray=[dict[@"result"] mutableCopy];
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
        int height=35;
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentiferId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *progressLB=[[UILabel alloc]init];// 处理步骤
        progressLB.font=[UIFont boldSystemFontOfSize:14.0f];
        progressLB.textColor=[UIColor lightGrayColor];
        progressLB.textAlignment=NSTextAlignmentLeft;
        progressLB.text=@"2017-12-11";
        progressLB.tag=1002;
        progressLB.frame=CGRectMake(10, 0, SCREEN_WIDTH/2-10, height);
        [cell.contentView addSubview:progressLB];
        
        UILabel *progressPersonLB=[[UILabel alloc]init];// 处理人
        progressPersonLB.font=[UIFont boldSystemFontOfSize:14.0f];
        progressPersonLB.textColor=[UIColor lightGrayColor];
        progressPersonLB.textAlignment=NSTextAlignmentLeft;
        progressPersonLB.text=@"2017-12-11";
        progressPersonLB.tag=1004;
        progressPersonLB.frame=CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2-10, height);
        [cell.contentView addSubview:progressPersonLB];
        
        UILabel *startTimeLB=[[UILabel alloc]init];
        startTimeLB.font=[UIFont boldSystemFontOfSize:14.0f];
        startTimeLB.textColor=[UIColor lightGrayColor];
        startTimeLB.textAlignment=NSTextAlignmentLeft;
        startTimeLB.text=@"2017-12-11";
        startTimeLB.tag=1000;
        startTimeLB.frame=CGRectMake(progressLB.left,progressLB.bottom, progressLB.width, progressLB.height);
        [cell.contentView addSubview:startTimeLB];
        
        UILabel *endTimeLB=[[UILabel alloc]init];
        endTimeLB.font=[UIFont boldSystemFontOfSize:14.0f];
        endTimeLB.textColor=[UIColor lightGrayColor];
        endTimeLB.textAlignment=NSTextAlignmentLeft;
        endTimeLB.text=@"2017-12-11";
         endTimeLB.tag=1001;
        endTimeLB.frame=CGRectMake(progressPersonLB.left,progressPersonLB.bottom, progressPersonLB.width, progressPersonLB.height);
        [cell.contentView addSubview:endTimeLB];
        
        UILabel *progressDeatinationLB=[[UILabel alloc]init];// 业务流向
        
        progressDeatinationLB.font=[UIFont boldSystemFontOfSize:14.0f];
        progressDeatinationLB.textColor=[UIColor lightGrayColor];
        progressDeatinationLB.textAlignment=NSTextAlignmentLeft;
        progressDeatinationLB.text=@"2017-12-11";
        progressDeatinationLB.tag=1005;
        progressDeatinationLB.frame=CGRectMake(startTimeLB.left,startTimeLB.bottom, startTimeLB.width, startTimeLB.height);
        [cell.contentView addSubview:progressDeatinationLB];
        
        
        UILabel *statueLB=[[UILabel alloc]init];//状态
        statueLB.font=[UIFont boldSystemFontOfSize:14.0f];
        statueLB.textColor=[UIColor lightGrayColor];
        statueLB.textAlignment=NSTextAlignmentLeft;
        statueLB.text=@"2017-12-11";
         statueLB.tag=1003;
         statueLB.frame=CGRectMake(endTimeLB.left,endTimeLB.bottom, endTimeLB.width, endTimeLB.height);
        [cell.contentView addSubview:statueLB];
        
       
        
       
        
        UILabel *progressContent=[[UILabel alloc]init];// 处理意见
        progressContent.font=[UIFont boldSystemFontOfSize:14.0f];
        progressContent.textColor=[UIColor lightGrayColor];
        progressContent.textAlignment=NSTextAlignmentLeft;
        progressContent.numberOfLines=0;
        progressContent.lineBreakMode=NSLineBreakByWordWrapping;
        progressContent.text=@"2017-12-11";
        progressContent.frame=CGRectMake(progressDeatinationLB.left,progressDeatinationLB.bottom, progressDeatinationLB.width, progressDeatinationLB.height);
         progressContent.tag=1006;
        [cell.contentView addSubview:progressContent];
        
        UILabel *lineView=[[UILabel alloc]init];// 处理意见
        lineView.tag=1007;
        lineView.backgroundColor=[UIColor lightGrayColor];
        [cell.contentView addSubview:lineView];
        
       
        
    };
    UILabel *startTimeLB=[cell.contentView viewWithTag:1000];
    UILabel *endTimeLB=[cell.contentView viewWithTag:1001];
    UILabel *progressLB=[cell.contentView viewWithTag:1002];
    UILabel *statueLB=[cell.contentView viewWithTag:1003];
    UILabel *progressPersonLB=[cell.contentView viewWithTag:1004];
    UILabel *progressDeatinationLB=[cell.contentView viewWithTag:1005];
    UILabel *progressContent=[cell.contentView viewWithTag:1006];
    UILabel *lineView=[cell.contentView viewWithTag:1007];
    NSDictionary *detailDic=_allArray[indexPath.row];
//    "STATUS": 9,
//    "WORKITEM_ID": 404182,
//    "COMPLETE_TIME": 1517673124000,
//    "RECEIVE_TIME": 1517673124000,
//    "APP_TYPE_NAME": "预约申请",
//    "DEST": "送部门审核",
//    "RECEIVER": "温总富"
//
//    APP_TYPE_NAME ： 处理步骤
//    RECEIVER：处理人
//    RECEIVER_TIME：接收时间
//    DEST：业务流向
//    COMPLETE_TIME：完成时间
//    STATUS：状态（9：已处理，0：等待，1：新收到）
//    CONTENT：处理意见
    if ([[detailDic allKeys] containsObject:@"RECEIVE_TIME"]) {
      startTimeLB.text=[NSString stringWithFormat:@"开始时间：%@",[Utils compareNowWithChineseString:[detailDic[@"RECEIVE_TIME"] floatValue]/1000]];
    }else{
         startTimeLB.text=@"开始时间：";
    }
    if ([[detailDic allKeys] containsObject:@"COMPLETE_TIME"]) {
        endTimeLB.text=[NSString stringWithFormat:@"结束时间：%@",[Utils compareNowWithChineseString:[detailDic[@"COMPLETE_TIME"] floatValue]/1000]];
    }else{
        endTimeLB.text=@"结束时间：";
    }
    NSDictionary *statuDic=@{@9:@"已处理",@0:@"等待",@1:@"新收到"};
    if ([[detailDic allKeys] containsObject:@"APP_TYPE_NAME"]) {
        progressLB.text=[NSString stringWithFormat:@"处理步骤:%@",[Utils getNotNullNotNill:detailDic[@"APP_TYPE_NAME"]]];
    }else{
        progressLB.text=@"处理步骤:";
    }
    if ([[detailDic allKeys] containsObject:@"STATUS"]) {
        statueLB.text=[NSString stringWithFormat:@"状态:%@",[Utils getNotNullNotNill:[statuDic objectForKey:[Utils getNotNullNotNill:detailDic[@"STATUS"]]]]];
        
    }else{
        statueLB.text=@"状态:";
    }
    if ([[detailDic allKeys] containsObject:@"RECEIVER"]) {
        progressPersonLB.text=[NSString stringWithFormat:@"处理人:%@",[Utils getNotNullNotNill:detailDic[@"RECEIVER"]]];
        
    }else{
         progressPersonLB.text=@"处理人:";
    }
    if ([[detailDic allKeys] containsObject:@"DEST"]) {
        progressDeatinationLB.text=[NSString stringWithFormat:@"业务流向:%@",[Utils getNotNullNotNill:detailDic[@"DEST"]]];
        
    }else{
        progressDeatinationLB.text=@"业务流向:";

    }
    if ([[detailDic allKeys] containsObject:@"APP_TYPE_NAME"]) {
        progressContent.text=[NSString stringWithFormat:@"处理意见:%@",[Utils getNotNullNotNill:detailDic[@"CONTENT"]]];
        
    }else{
        progressContent.text=@"处理意见:";
    }
//    if (indexPath.row%2==1) {
//         progressContent.text=@"处理意见:i 奥回复玩法皮肤发破解阿婆范文芳哦平均分破啊减肥我那位评价哦爬几分破啊晚饭呢跑佛教奥排污费男 佛啊发我发发 if 呢";
//    }
   
     CGSize textSize=  [Utils sizeWithText:progressContent.text font:progressContent.font maxSize:CGSizeMake(SCREEN_WIDTH-20, 100)];
    if (textSize.height<35) {
        textSize.height=35;
    }
    progressContent.frame=CGRectMake(progressDeatinationLB.left,progressDeatinationLB.bottom, SCREEN_WIDTH-20, textSize.height);
    
    lineView.frame=CGRectMake(progressContent.left,progressContent.bottom+1, SCREEN_WIDTH-20, 1);
    
    return  cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _allArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *detailDic=_allArray[indexPath.row];
    NSString *CONTENT= [NSString stringWithFormat:@"处理意见:%@",[Utils getNotNullNotNill:detailDic[@"CONTENT"]]];
//    if (indexPath.row%2==1) {
//        CONTENT=@"处理意见:i 奥回复玩法皮肤发破解阿婆范文芳哦平均分破啊减肥我那位评价哦爬几分破啊晚饭呢跑佛教奥排污费男 佛啊发我发发 if 呢";
//    }
    CGSize textSize=  [Utils sizeWithText:CONTENT font:[UIFont boldSystemFontOfSize:14.0f] maxSize:CGSizeMake(SCREEN_WIDTH-20, 100)];
    if (textSize.height<35) {
        textSize.height=35;
    }
    return 110+textSize.height;
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
