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

@interface OAMainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *allArray;
@end

@implementation OAMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.title=@"个人办公";
    self.title=@"个人办公";

     [self createNaviTopBarWithShowBackBtn:false showTitle:YES];
    
    self.view.backgroundColor=[UIColor lightGrayColor];
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, TOPBARCONTENTHEIGHT, SCREEN_WIDTH, SCREEN_WIDTH/3)];
    topView.backgroundColor=[UIColor blueColor];
    [self.view addSubview:topView];
      int width=SCREEN_WIDTH/3;
    NSArray *anArray=@[@{@"title":@"新建公文",@"normalImage":@"",@"highLightedImage":@""},@{@"title":@"公文查询",@"normalImage":@"",@"highLightedImage":@""},@{@"title":@"通讯录",@"normalImage":@"",@"highLightedImage":@""}];
    
    for (int d=0; d<anArray.count; d++) {
        NSDictionary *detailDic=_allArray[d];
        UIView *smallBack=[[UIView alloc]initWithFrame:CGRectMake((d%3)*width, (d/3)*width, width, width)];
        [topView addSubview:smallBack];
        
        UIView *centralView=[[UIView alloc]initWithFrame:CGRectMake((width-100)/2, (width-90)/2, 100, 90)];
        centralView.backgroundColor=[UIColor clearColor];
        [smallBack addSubview:centralView];
        
        UIImageView *im=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wifi"]];
        [centralView addSubview:im];
        im.frame=CGRectMake(25, 0, 50, 50);
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, im.bottom, 100, 40)];
        label.textAlignment=NSTextAlignmentCenter;
        label.textColor=[UIColor whiteColor];
        label.text=detailDic[@"title"];
        [centralView addSubview:label];
        
        UIButton *bt=[[UIButton alloc]initWithFrame:smallBack.bounds];
        bt.backgroundColor=[UIColor clearColor];
        [bt addTarget:self action:@selector(bttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        bt.tag=100+d;
        [smallBack addSubview:bt];
    }
    
    _allArray = [@[@{@"title":@"代办公文",@"normalImage":@"",@"highLightedImage":@""},@{@"title":@"待阅公文",@"normalImage":@"",@"highLightedImage":@""},@{@"title":@"流转公文",@"normalImage":@"",@"highLightedImage":@""},@{@"title":@"收件箱",@"normalImage":@"",@"highLightedImage":@""},@{@"title":@"我的收藏",@"normalImage":@"",@"highLightedImage":@""},@{@"title":@"我的订阅",@"normalImage":@"",@"highLightedImage":@""},@{@"title":@"已办公文",@"normalImage":@"",@"highLightedImage":@""},@{@"title":@"已阅公文",@"normalImage":@"",@"highLightedImage":@""},@{@"title":@"个人日程",@"normalImage":@"",@"highLightedImage":@""}] mutableCopy];
    
    UIView *aView=[[UIView alloc]initWithFrame:CGRectMake(0,topView.bottom+10 , SCREEN_WIDTH, SCREEN_WIDTH)];
    [self.view addSubview:aView];
    for (int d=0 ;d<_allArray.count; d++) {
        NSDictionary *detailDic=_allArray[d];
      
        
        
        UIView *smallBack=[[UIView alloc]initWithFrame:CGRectMake((d%3)*width, (d/3)*width, width, width)];
        smallBack.backgroundColor=[UIColor whiteColor];
        [aView addSubview:smallBack];
        
        UIView *centralView=[[UIView alloc]initWithFrame:CGRectMake((width-100)/2, (width-90)/2, 100, 90)];
        centralView.backgroundColor=[UIColor whiteColor];
        [smallBack addSubview:centralView];
        
        UIImageView *im=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wifi"]];
        [centralView addSubview:im];
        im.frame=CGRectMake(25, 0, 50, 50);
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, im.bottom, 100, 40)];
        label.textAlignment=NSTextAlignmentCenter;
        NSMutableAttributedString * firstPart = [[NSMutableAttributedString alloc] initWithString:[NSString    stringWithFormat:@"%@:",detailDic[@"title"]]];
        
        NSDictionary * firstAttributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:14.0f],NSForegroundColorAttributeName:[UIColor blackColor],};
        [firstPart setAttributes:firstAttributes range:NSMakeRange(0,firstPart.length)];
        NSMutableAttributedString * secondPart = [[NSMutableAttributedString alloc] initWithString:@"  2"];
        NSDictionary * secondAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14.0f],NSForegroundColorAttributeName:[UIColor greenColor],};
        [secondPart setAttributes:secondAttributes range:NSMakeRange(0,secondPart.length)];
        [firstPart appendAttributedString:secondPart];
        label.attributedText=firstPart;
        [centralView addSubview:label];
        
        UIView *topStrait=[[UIView alloc]initWithFrame:CGRectMake(0, 0, width, 1)];
        topStrait.backgroundColor=[UIColor lightGrayColor];
        [smallBack addSubview:topStrait];
        UIView *lineleft=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, width)];
         lineleft.backgroundColor=[UIColor lightGrayColor];
         [smallBack addSubview:lineleft];
        UIView *bottomStrait=[[UIView alloc]initWithFrame:CGRectMake(0,width, width, 1)];
         bottomStrait.backgroundColor=[UIColor lightGrayColor];
        if (d%3==0) {  
            [lineleft removeFromSuperview];
        }
        if (d>(d-3)) {//最后面3个加上下划线
            [smallBack addSubview:bottomStrait];
        }
        UIButton *bt=[[UIButton alloc]initWithFrame:smallBack.bounds];
        bt.backgroundColor=[UIColor clearColor];
        [bt addTarget:self action:@selector(bttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        bt.tag=200+d;
        [smallBack addSubview:bt];
        
    }
    
    
    
    
    _demoTableView=[[UITableView alloc]initWithFrame:CGRectMake(10, self.navigationController.navigationBar.bottom, SCREEN_WIDTH-20, SCREEN_HEIGHT-50)];
    [_demoTableView registerNib:[UINib nibWithNibName:@"OaMainCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"OaMainCellTableViewCell"];
    _demoTableView.delegate=self;
    _demoTableView.dataSource=self;
    _demoTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
//    [self.view addSubview:_demoTableView];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=false;
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
            
        }
            break;
        case 200:
        {
            
        }
            break;
            
        default:
            break;
   
    }
}
#pragma mark UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *avc;
    if (indexPath.row==0) {
        
    }else if (indexPath.row==1) {
        
    }else if (indexPath.row==2) {
        avc=[[NewIndexOaViewController alloc]initWithNibName:@"NewIndexOaViewController" bundle:nil];
    }else if (indexPath.row==3) {
        
    }else if (indexPath.row==4) {
        
    }else if (indexPath.row==5) {
        
    }else if (indexPath.row==6) {
        
    }
    if (avc) {
        [self.navigationController pushViewController:avc animated:YES];
    }
    
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
    return 50;
    
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
