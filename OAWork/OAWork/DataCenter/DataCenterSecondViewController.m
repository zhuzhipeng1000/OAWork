//
//  DataCenterSecondViewController.m
//  OAWork
//
//  Created by james on 2017/12/7.
//  Copyright © 2017年 james. All rights reserved.
//

#import "DataCenterSecondViewController.h"
#import "DClistFolderViewController.h"
#import "DCListViewController.h"
#import "DCListCellTableViewCell.h"

@interface DataCenterSecondViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    NSMutableArray *_allArray;
    UIView * headView;
    UITableView *_demoTableView;
    NSMutableArray *_tableListArray;
    UISearchBar *_searchBar;
    NSString *currentType;//列表类型
}
@end

@implementation DataCenterSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(20, TOPBARCONTENTHEIGHT,SCREEN_WIDTH-20, 44)];
    _searchBar.delegate=self;
    UIImage* searchBarBg = [Utils GetImageWithColor:[Utils colorWithHexString:@"#f7f7f7"] andHeight:32.0f];
    //设置背景图片
    [_searchBar setBackgroundImage:searchBarBg];
    //设置背景色
    [_searchBar setBackgroundColor:[UIColor clearColor]];
    //设置文本框背景
    [_searchBar setSearchFieldBackgroundImage:searchBarBg forState:UIControlStateNormal];
    //    seach. barStyle= UIBarStyleBlack;
    _searchBar.backgroundColor=[Utils colorWithHexString:@"#5dbed8"];
    //    _searchBar.showsCancelButton=YES;
    _searchBar.placeholder=@"请输入关键词";
    _searchBar.layer.cornerRadius=20;
    _searchBar.clipsToBounds=true;
    [self.view addSubview:_searchBar];
    
    _allArray = [@[@{@"title":@"代办公文",@"normalImage":@"home_waitingOA",@"highLightedImage":@"home_waitingOA"},@{@"title":@"待阅公文",@"normalImage":@"home_waitingRead",@"highLightedImage":@"home_waitingRead"},@{@"title":@"流转公文",@"normalImage":@"home_liuzhuan",@"highLightedImage":@"home_liuzhuan"},@{@"title":@"收件箱",@"normalImage":@"shoujianxiang",@"highLightedImage":@"shoujianxiang"},@{@"title":@"我的收藏",@"normalImage":@"shoucang",@"highLightedImage":@"shoucang"},@{@"title":@"我的订阅",@"normalImage":@"dingyue",@"highLightedImage":@"dingyue"},@{@"title":@"已办公文",@"normalImage":@"yibangongwen",@"highLightedImage":@"yibangongwen"},@{@"title":@"已阅公文",@"normalImage":@"yiyuegongwen",@"highLightedImage":@"yiyuegongwen"},@{@"title":@"个人日程",@"normalImage":@"geRenRiCheng",@"highLightedImage":@"geRenRiCheng"}] mutableCopy];
    
    
    int width=SCREEN_WIDTH/3;
    headView=[[UIView alloc]initWithFrame:CGRectMake(0,_searchBar.bottom , SCREEN_WIDTH, width*2+40)];
    if (_allArray.count>6) {
        headView.frame=CGRectMake(0,TOPBARCONTENTHEIGHT , SCREEN_WIDTH, width*2+40);
    }else{
        long lineCount= _allArray.count%3?(_allArray.count/3):(_allArray.count/3+1);
        headView.frame=CGRectMake(0,TOPBARCONTENTHEIGHT , SCREEN_WIDTH, width*lineCount);
    }
    [self.view addSubview:headView];
    int  imageWith=35;
    for (int d=0 ;d<_allArray.count; d++) {
        NSDictionary *detailDic=_allArray[d];
    
        UIView *smallBack=[[UIView alloc]initWithFrame:CGRectMake((d%3)*width, (d/3)*width, width, width)];
        smallBack.backgroundColor=[UIColor whiteColor];
        smallBack.tag=300+d;
        if (d>5) {
            smallBack.hidden=true;
        }
        [headView addSubview:smallBack];
        
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
    if (_allArray.count>6) {
        UIButton *bt=[[UIButton alloc]initWithFrame:CGRectMake((headView.width-100)/2, 5, 100, 30)];
        [bt setTitle:@"查看更多" forState:UIControlStateNormal];
        [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [headView addSubview:bt];
        bt.tag=550;
        [bt addTarget:self action:@selector(moreTapped:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    _demoTableView=[[UITableView alloc]initWithFrame:CGRectMake(10,headView.bottom, SCREEN_WIDTH-20, SCREEN_HEIGHT-headView.bottom)];
    [_demoTableView registerNib:[UINib nibWithNibName:@"OaMainCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"OaMainCellTableViewCell"];
    _demoTableView.delegate=self;
    _demoTableView.dataSource=self;
    _demoTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_demoTableView];
    // Do any additional setup after loading the view from its nib.
}
-(void)moreTapped:(UIButton*)bt{
    [self hiddenMoreView:false];
}
- (void)hiddenMoreView:(BOOL)hidden{
    for (int d=306; d<_allArray.count+300; d++) {
        UIView *btView=[headView viewWithTag:d];
        btView.hidden=hidden;
    }
    
    if (!hidden) {
        long lineCount= _allArray.count%3?(_allArray.count/3):(_allArray.count/3+1);
        headView.frame=CGRectMake(0,TOPBARCONTENTHEIGHT , SCREEN_WIDTH, (SCREEN_WIDTH/3)*lineCount+40);
    }else{
        headView.frame=CGRectMake(0,TOPBARCONTENTHEIGHT , SCREEN_WIDTH, (SCREEN_WIDTH/3)*2+40);
    }
    
    UIView *btView=[headView viewWithTag:550];
    btView.frame=CGRectMake((headView.width-100)/2, 5, 100, 30);
    _demoTableView.frame= CGRectMake(10,headView.bottom, SCREEN_WIDTH-20, SCREEN_HEIGHT-headView.bottom);
   
}

-(void)bttonTapped:(UIButton*)bt{
    if (_allArray.count>6) {
         [self hiddenMoreView:true];
    }
//    currentType=[bt titleForState:UIControlStateNormal];
//    [_demoTableView reloadData];
    DCListViewController *DCSctrl=[[DCListViewController alloc]init];
    DCSctrl.currentIndexString=[NSString stringWithFormat:@"电子资料管理>%@",[bt titleForState:UIControlStateNormal]];
    [self.navigationController pushViewController:DCSctrl animated:YES];
}
#pragma mark UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BOOL folder=false;
    DCListCellTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *title=cell.titleLB.text;
    if (folder) {
        DCListViewController *DCSctrl=[[DCListViewController alloc]init];
        DCSctrl.currentIndexString=[NSString stringWithFormat:@"%@/%@",currentType,title];
        [self.navigationController pushViewController:DCSctrl animated:YES];
    }
   
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static  NSString  *CellIdentiferId = @"DCListCellTableViewCell";
    DCListCellTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentiferId];
    if (cell == nil) {
        cell=[[DCListCellTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentiferId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    };
    cell.titleLB.text=_allArray[indexPath.row][@"title"];
    cell.imageView.image=[UIImage imageNamed:@"wifi"];
    return  cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _allArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
    
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
