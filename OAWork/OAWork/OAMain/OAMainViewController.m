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
        [bt addTarget:self action:@selector(bttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        bt.tag=100+d;
        [smallBack addSubview:bt];
    }
    
    _allArray = [@[@{@"title":@"代办公文",@"normalImage":@"home_waitingOA",@"highLightedImage":@"home_waitingOA"},@{@"title":@"待阅公文",@"normalImage":@"home_waitingRead",@"highLightedImage":@"home_waitingRead"},@{@"title":@"流转公文",@"normalImage":@"home_liuzhuan",@"highLightedImage":@"home_liuzhuan"},@{@"title":@"收件箱",@"normalImage":@"shoujianxiang",@"highLightedImage":@"shoujianxiang"},@{@"title":@"我的收藏",@"normalImage":@"shoucang",@"highLightedImage":@"shoucang"},@{@"title":@"我的订阅",@"normalImage":@"dingyue",@"highLightedImage":@"dingyue"},@{@"title":@"已办公文",@"normalImage":@"yibangongwen",@"highLightedImage":@"yibangongwen"},@{@"title":@"已阅公文",@"normalImage":@"yiyuegongwen",@"highLightedImage":@"yiyuegongwen"},@{@"title":@"个人日程",@"normalImage":@"geRenRiCheng",@"highLightedImage":@"geRenRiCheng"}] mutableCopy];
    
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
        
        NSDictionary * firstAttributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:14.0f],NSForegroundColorAttributeName:[UIColor blackColor],};
        [firstPart setAttributes:firstAttributes range:NSMakeRange(0,firstPart.length)];
        NSMutableAttributedString * secondPart = [[NSMutableAttributedString alloc] initWithString:@"  2"];
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
        bt.backgroundColor=[UIColor clearColor];
        [bt addTarget:self action:@selector(bttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        bt.tag=200+d;
        [smallBack addSubview:bt];
        
    }
    
    
  
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=true;
}

- (void)bttonTapped:(UIButton*)bt{
    switch (bt.tag) {
        case 100:
        {
            UIViewController *avcc=[[NewIndexOaViewController alloc]initWithNibName:@"NewIndexOaViewController" bundle:nil];
            [self.navigationController pushViewController:avcc animated:YES];
        }
             break;
        case 101:
        {
            UIViewController *avcc=[[NewIndexOaViewController alloc]initWithNibName:@"NewIndexOaViewController" bundle:nil];
            [self.navigationController pushViewController:avcc animated:YES];
        }
            break;
        case 102:
        {
            CIAllContactViewController *DCSctrl=[[CIAllContactViewController alloc]init];
            [self.navigationController pushViewController:DCSctrl animated:YES];
            
        }
            break;
        case 200:
        {
            OAListViewController *CTL=[[OAListViewController alloc]init];
            [self.navigationController pushViewController:CTL animated:YES];
            
        }
            break;
        case 208:
        {
            WScViewController *CTL=[[WScViewController alloc]init];
            [self.navigationController pushViewController:CTL animated:YES];
        }
            break;
            
        default:
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
