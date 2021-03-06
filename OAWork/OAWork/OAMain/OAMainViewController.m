//
//  OAMainViewController.m
//  OAWork
//
//  Created by james on 2017/11/24.
//  Copyright © 2017年 james. All rights reserved.
//

#import "OAMainViewController.h"
#import "OaMainCellTableViewCell.h"
#import "NewIndexOaViewController.h"
#import "WScViewController.h"
#import "OAListViewController.h"
#import "CIAllContactViewController.h"


@interface OAMainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *allArray;
@end

@implementation OAMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.title=@"个人办公";
    self.title=@"个人办公";
    [self createNaviTopBarWithShowBackBtn:false showTitle:YES];

 
    self.view.backgroundColor=[Utils colorWithHexString:@"#ffffff"];
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, TOPBARCONTENTHEIGHT, SCREEN_WIDTH, SCREEN_WIDTH/3)];
    topView.backgroundColor=[Utils colorWithHexString:@"#008fef"];
    [self.view addSubview:topView];
      int width=SCREEN_WIDTH/3;
    int  imageWith=35;
    NSArray *anArray=@[@{@"title":@"新建公文",@"normalImage":@"home_newoa",@"highLightedImage":@"home_newoa"},@{@"title":@"公文查询",@"normalImage":@"home_newSearch",@"highLightedImage":@"home_newSearch"},@{@"title":@"通讯录",@"normalImage":@"home_contact",@"highLightedImage":@"home_contact"}];
    
    for (int d=0; d<anArray.count; d++) {
        NSDictionary *detailDic=anArray[d];
        UIView *smallBack=[[UIView alloc]initWithFrame:CGRectMake((d%3)*width, (d/3)*width, width, width)];
        [topView addSubview:smallBack];
        
        UIView *centralView=[[UIView alloc]initWithFrame:CGRectZero];
        centralView.backgroundColor=[UIColor clearColor];
        [smallBack addSubview:centralView];
        
        UIImageView *im=[[UIImageView alloc]initWithImage:[UIImage imageNamed:detailDic[@"normalImage"]]];
        [centralView addSubview:im];
         im.contentMode=UIViewContentModeScaleAspectFit;
        im.frame=CGRectMake((width-imageWith)/2, 0, imageWith, imageWith);
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(1, im.bottom, width-2, 40)];
        label.textAlignment=NSTextAlignmentCenter;
        label.textColor=[UIColor whiteColor];
        label.font=[UIFont systemFontOfSize:14.0];
        label.text=detailDic[@"title"];
        [centralView addSubview:label];
        
        centralView.frame=CGRectMake(label.left, im.top, label.width, label.bottom);
        
        centralView.center=CGPointMake(smallBack.width/2, smallBack.height/2);
        
        UIButton *bt=[[UIButton alloc]initWithFrame:smallBack.bounds];
        bt.backgroundColor=[UIColor clearColor];
        [bt setTitle:detailDic[@"title"] forState:UIControlStateNormal];
        [bt setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        [bt addTarget:self action:@selector(bttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        bt.tag=100+d;
        [smallBack addSubview:bt];
    }
    
    _allArray = [@[@{@"type":@"1",@"title":@"待办公文",@"normalImage":@"home_waitingOA",@"highLightedImage":@"home_waitingOA"},@{@"type":@"2",@"title":@"待阅公文",@"normalImage":@"home_waitingRead",@"highLightedImage":@"home_waitingRead"},@{@"type":@"3",@"title":@"流转公文",@"normalImage":@"home_liuzhuan",@"highLightedImage":@"home_liuzhuan"},@{@"title":@"收件箱",@"normalImage":@"shoujianxiang",@"highLightedImage":@"shoujianxiang"},@{@"title":@"我的收藏",@"normalImage":@"shoucang",@"highLightedImage":@"shoucang"},@{@"title":@"我的订阅",@"normalImage":@"dingyue",@"highLightedImage":@"dingyue"},@{@"type":@"4",@"title":@"已办公文",@"normalImage":@"yibangongwen",@"highLightedImage":@"yibangongwen"},@{@"type":@"5",@"title":@"已阅公文",@"normalImage":@"yiyuegongwen",@"highLightedImage":@"yiyuegongwen"},@{@"title":@"个人日程",@"normalImage":@"geRenRiCheng",@"highLightedImage":@"geRenRiCheng"}] mutableCopy];
    
    UIView *aView=[[UIView alloc]initWithFrame:CGRectMake(0,topView.bottom+10 , SCREEN_WIDTH, SCREEN_WIDTH)];
     aView.backgroundColor=[Utils colorWithHexString:@"#ffffff"];
    [self.view addSubview:aView];
    for (int d=0 ;d<_allArray.count; d++) {
        NSDictionary *detailDic=_allArray[d];
      
        UIView *smallBack=[[UIView alloc]initWithFrame:CGRectMake((d%3)*width, (d/3)*width, width, width)];
        smallBack.backgroundColor=[UIColor whiteColor];
        [aView addSubview:smallBack];
        
        UIView *centralView=[[UIView alloc]initWithFrame:CGRectMake((width-100)/2, (width-90)/2, 100, 90)];
        centralView.backgroundColor=[UIColor whiteColor];
        [smallBack addSubview:centralView];
        
        UIImageView *im=[[UIImageView alloc]initWithImage:[UIImage imageNamed:detailDic[@"normalImage"]]];
        [centralView addSubview:im];
         im.frame=CGRectMake((width-imageWith)/2, 0, imageWith, imageWith);
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, im.bottom, width, 40)];
        label.textAlignment=NSTextAlignmentCenter;
        NSMutableAttributedString * firstPart = [[NSMutableAttributedString alloc] initWithString:[NSString    stringWithFormat:@"%@",detailDic[@"title"]]];
        centralView.frame=CGRectMake(label.left, im.top, label.width, label.bottom);
        
        centralView.center=CGPointMake(smallBack.width/2, smallBack.height/2);
        label.tag=4000+d;
        NSDictionary * firstAttributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:14.0f],NSForegroundColorAttributeName:[UIColor blackColor],};
        [firstPart setAttributes:firstAttributes range:NSMakeRange(0,firstPart.length)];
//        NSMutableAttributedString * secondPart = [[NSMutableAttributedString alloc] initWithString:@"  2"];
         NSMutableAttributedString * secondPart = [[NSMutableAttributedString alloc] initWithString:@""];
        NSDictionary * secondAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14.0f],NSForegroundColorAttributeName:[UIColor greenColor],};
        [secondPart setAttributes:secondAttributes range:NSMakeRange(0,secondPart.length)];
        [firstPart appendAttributedString:secondPart];
        label.attributedText=firstPart;
        [centralView addSubview:label];
        
        UIView *topStrait=[[UIView alloc]initWithFrame:CGRectMake(0, 0, width, 1)];
        topStrait.backgroundColor=[Utils  colorWithHexString:@"#e4e4e4"];
        [smallBack addSubview:topStrait];
        UIView *lineleft=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, width)];
         lineleft.backgroundColor=[Utils colorWithHexString:@"#e4e4e4"];
         [smallBack addSubview:lineleft];
        UIView *bottomStrait=[[UIView alloc]initWithFrame:CGRectMake(0,width, width, 1)];
         bottomStrait.backgroundColor=[Utils colorWithHexString:@"#e4e4e4"];
        
        UIView *lineRight=[[UIView alloc]initWithFrame:CGRectMake(width-1, 0, 1, width)];
        lineRight.backgroundColor=[Utils colorWithHexString:@"#e4e4e4"];
       
        
        if (d%3==0) {  
            [lineleft removeFromSuperview];
        }
        if (d>(d-3)) {//最后面3个加上下划线
            [smallBack addSubview:bottomStrait];
        }
        if (d==(_allArray.count-1)&&(d%3)!=2){//最后一个，判断是非靠边
            [smallBack addSubview:lineRight];
        }
        UIButton *bt=[[UIButton alloc]initWithFrame:smallBack.bounds];
        [bt setTitle:detailDic[@"title"] forState:UIControlStateNormal];
        bt.backgroundColor=[UIColor clearColor];
        [bt addTarget:self action:@selector(bttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [bt setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        bt.tag=200+d;
        [smallBack addSubview:bt];
        
    }
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText = @"数据获取中";
    __weak __typeof(self) weakSelf = self;
    [MyRequest getRequestWithUrl:[HostMangager mainIndexUrl] andPara:nil isAddUserId:YES Success:^(NSDictionary *dict, BOOL success) {
        [weakSelf.hud hide:YES];
        
    } fail:^(NSError *error) {
        [weakSelf.hud hide:YES];
        
    }];
    
  
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=true;
    
    [self  getData];
}


- (void)bttonTapped:(UIButton*)bt{
    NSString *ttle=[bt titleForState:UIControlStateNormal];
    OAListViewController *avcc;
    switch (bt.tag) {
        case 100:
        {
            avcc=(OAListViewController*)[[NewIndexOaViewController alloc]initWithNibName:@"NewIndexOaViewController" bundle:nil];
            avcc.title=ttle;
           
            [self.navigationController pushViewController:avcc animated:YES];
        }
             break;
        case 101:
        {
            avcc=[[OAListViewController alloc]init];
            avcc.type=1;
            avcc.title=ttle;
            [self.navigationController pushViewController:avcc animated:YES];
        }
            break;
        case 102:
        {
            avcc=(OAListViewController*)[[CIAllContactViewController alloc]init];
            avcc.title=ttle;
            [self.navigationController pushViewController:avcc animated:YES];
            
        }
            break;
        case 200:
        {
           avcc=[[OAListViewController alloc]init];
            avcc.title=ttle;
             avcc.type=2;
            [self.navigationController pushViewController:avcc animated:YES];
            
        }
            break;
        case 201:
        {
            avcc=[[OAListViewController alloc]init];
            avcc.title=ttle;
            avcc.type=3;
            [self.navigationController pushViewController:avcc animated:YES];
            
        }
            break;
        case 202:
        {
            avcc=[[OAListViewController alloc]init];
            avcc.title=ttle;
            avcc.type=4;
            [self.navigationController pushViewController:avcc animated:YES];
            
        }
            break;
       
        case 208:
        {
            avcc=(OAListViewController*)[[WScViewController alloc]init];
            avcc.title=ttle;
            [self.navigationController pushViewController:avcc animated:YES];
        }
            break;
            
        default:{
            avcc=[[OAListViewController alloc]init];
            avcc.title=ttle;
            avcc.type=(int)bt.tag-200+2;
            [self.navigationController pushViewController:avcc animated:YES];
            
        }
            break;
            
    }
}
#pragma mark UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
 
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static  NSString  *CellIdentiferId = @"OaMainCellTableViewCell";
    OaMainCellTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentiferId];
    if (cell == nil) {
        cell=[[OaMainCellTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentiferId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    };
    cell.titleLB.text=_allArray[indexPath.row];
    cell.imageView.image=[UIImage imageNamed:@"wifi"];
    return  cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _allArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
    
}

-(void)getData{
    
    NSDictionary *parameters =@{};
//    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    _hud.mode = MBProgressHUDModeAnnularDeterminate;
//    self.hud.labelText = @"数据获取中";
    __weak __typeof(self) weakSelf = self;
    [MyRequest getRequestWithUrl:[HostMangager mainIndexUrl] andPara:parameters isAddUserId:true Success:^(NSDictionary *dict, BOOL success) {
        [weakSelf.hud hide:YES];
            if ([dict isKindOfClass:[NSDictionary class]]&&[dict[@"code"] intValue]==0) {
            for (int d=0; d<[_allArray count]; d++) {
                NSDictionary*dic=_allArray[d];
                
                UILabel *label=[self.view viewWithTag:(4000+d)];
                if ( [dic.allKeys containsObject:@"type"]){
                for ( NSDictionary *detailDic in dict[@"result"] ) {
                    if ([dic[@"type"] intValue]==[detailDic[@"type"] intValue]) {
                        
                        NSMutableAttributedString * firstPart = [[NSMutableAttributedString alloc] initWithString:[NSString    stringWithFormat:@"%@",dic[@"title"]]];
                        NSDictionary * firstAttributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:14.0f],NSForegroundColorAttributeName:[UIColor blackColor],};
                        [firstPart setAttributes:firstAttributes range:NSMakeRange(0,firstPart.length)];
                        if ([detailDic[@"count"] intValue]>0) {
                            NSMutableAttributedString * secondPart = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",detailDic[@"count"]]];
                            NSDictionary * secondAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14.0f],NSForegroundColorAttributeName:[UIColor greenColor],};
                            [secondPart setAttributes:secondAttributes range:NSMakeRange(0,secondPart.length)];
                            [firstPart appendAttributedString:secondPart];
                        }
                        
                        
                        label.attributedText=firstPart;
                    }
                }
                }
            }
        }else{
            
//            UIAlertView *al=[[UIAlertView alloc]initWithTitle:nil message:@"数据获取失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//            [al show];
            
        }
        
    } fail:^(NSError *error) {
        [weakSelf.hud hide:YES];
//        UIAlertView *al=[[UIAlertView alloc]initWithTitle:nil message:@"数据获取失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [al show];
    }];

    
}
#pragma mark UITableViewDataSource
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
