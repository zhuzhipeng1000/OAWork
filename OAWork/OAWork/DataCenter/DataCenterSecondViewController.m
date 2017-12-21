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
#import "YZNavigationMenuView.h"

@interface DataCenterSecondViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,YZNavigationMenuViewDelegate>
{
    NSMutableArray *_allArray;
    UIView * headView;
    UITableView *_demoTableView;
    NSMutableArray *_tableListArray;
    UISearchBar *_searchBar;
    NSString *currentType;//列表类型
    NSMutableArray *_showedArray;
    NSDictionary *dicNew;
    NSDictionary *other;
    UIScrollView *_scrollView;
}
@property (nonatomic,strong)  YZNavigationMenuView *menuView;
@end

@implementation DataCenterSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view from its nib.
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, TOPBARCONTENTHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-TOPBARCONTENTHEIGHT)];
    _scrollView.showsVerticalScrollIndicator=false;
    [self.view addSubview:_scrollView];
    
    _searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(10, 10,SCREEN_WIDTH-20, 35)];
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
    [_scrollView addSubview:_searchBar];
    _showedArray=[NSMutableArray array];
    _allArray = [@[@{@"title":@"代办公文",@"normalImage":@"home_waitingOA",@"highLightedImage":@"home_waitingOA"},@{@"title":@"待阅公文",@"normalImage":@"home_waitingRead",@"highLightedImage":@"home_waitingRead"},@{@"title":@"流转公文",@"normalImage":@"home_liuzhuan",@"highLightedImage":@"home_liuzhuan"},@{@"title":@"收件箱",@"normalImage":@"shoujianxiang",@"highLightedImage":@"shoujianxiang"},@{@"title":@"我的收藏",@"normalImage":@"shoucang",@"highLightedImage":@"shoucang"},@{@"title":@"收藏",@"normalImage":@"shoucang",@"highLightedImage":@"shoucang"},@{@"title":@"我的",@"normalImage":@"shoucang",@"highLightedImage":@"shoucang"}] mutableCopy];
    

    dicNew=  @{@"title":@"新建资料分类",@"normalImage":@"wejianjia_copy_2",@"highLightedImage":@"wejianjia_copy_2"};
    other=@{@"title":@"其它资料",@"normalImage":@"more",@"highLightedImage":@"more"};
    
   [self hiddenMoreView:true];
    // Do any additional setup after loading the view from its nib.
}
-(void)moreTapped:(UIButton*)bt{
    [self hiddenMoreView:false];
}
-(void)reloadViewOfArray:(NSArray*)arr{
    
    int width=SCREEN_WIDTH/3;
  
    long lineCount= arr.count%3?(arr.count/3+1):(arr.count/3);
    [headView removeFromSuperview];
    headView=[[UIView alloc]init];
    headView.frame=CGRectMake(0,_searchBar.bottom+10 , SCREEN_WIDTH, width*lineCount);
    [_scrollView addSubview:headView];
    
    int  imageWith=35;
    for (int d=0; d<arr.count; d++) {
        
        NSDictionary *detailDic=arr[d];
        
        UIView *smallBack=[[UIView alloc]initWithFrame:CGRectMake((d%3)*width, (d/3)*width, width, width)];
        smallBack.backgroundColor=[UIColor whiteColor];
        smallBack.tag=300+d;
        [headView addSubview:smallBack];
        
        UIView *centralView=[[UIView alloc]initWithFrame:CGRectMake((width-100)/2, (width-90)/2, 100, 90)];
        centralView.backgroundColor=[UIColor whiteColor];
        [smallBack addSubview:centralView];
        
        UIImageView *im=[[UIImageView alloc]initWithImage:[UIImage imageNamed:detailDic[@"normalImage"]]];
        [centralView addSubview:im];
        im.contentMode=UIViewContentModeScaleAspectFit;
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
        [bt setTitle:detailDic[@"title"] forState:UIControlStateNormal];
        [bt setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        [bt addTarget:self action:@selector(bttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        bt.tag=200+d;
        [smallBack addSubview:bt];
    }
    if (!_demoTableView) {
        _demoTableView=[[UITableView alloc]init];
        [_demoTableView registerNib:[UINib nibWithNibName:@"OaMainCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"OaMainCellTableViewCell"];
        _demoTableView.delegate=self;
        _demoTableView.dataSource=self;
        _demoTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        [_scrollView addSubview:_demoTableView];
    }
     _demoTableView.frame=CGRectMake(0,headView.bottom+2, SCREEN_WIDTH, SCREEN_HEIGHT-headView.bottom);
    if ((SCREEN_HEIGHT-headView.bottom)<200) {
        _demoTableView.frame=CGRectMake(0, headView.bottom+2, SCREEN_WIDTH, 200);
    }
    [_demoTableView reloadData];
   _scrollView.contentSize=CGSizeMake(SCREEN_WIDTH, _demoTableView.bottom+200);
  
}
- (void)hiddenMoreView:(BOOL)hidden{
    
    if(_allArray.count>6&&hidden){
        _showedArray= [NSMutableArray array];
        for (int d=0 ;d<5; d++) {
            if (d<_allArray.count) {
                [_showedArray addObject:_allArray[d]];
            }
        }
        [_showedArray addObject:other];
        [_showedArray addObject:dicNew];
        
    }else{
        _showedArray=[[NSMutableArray alloc]initWithArray:_allArray];
        [_showedArray addObject:dicNew];
    }
    [self reloadViewOfArray:_showedArray];
    
}

-(void)bttonTapped:(UIButton*)bt{
    if ([[bt titleForState:UIControlStateNormal] isEqualToString:@"其它资料"]) {
        [self hiddenMoreView:false];
        
        return;
    }else if(_allArray.count>6){
         [self hiddenMoreView:true];
    }
    
    if ([[bt titleForState:UIControlStateNormal] isEqualToString:@"新建资料分类"]) {
        return;
    }
    
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
        cell.delegate=self;
    };
    cell.titleLB.text=_allArray[indexPath.row][@"title"];
    cell.headIcon.image=[UIImage imageNamed:@"wifi"];
    return  cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _allArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)navigationMenuView:(YZNavigationMenuView *)menuView clickedAtIndex:(NSInteger)index{
    [self removeMenuView];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     [super touchesBegan:touches withEvent:event];
    if (_menuView.superview) {
         [self removeMenuView];
    }
}
-(void)removeMenuView{
    [_menuView removeFromSuperview];
    _menuView.hidden=true;
    _menuView=nil;
}
- (void)accessBTtapped:(UIButton*)bt onCell:(DCListCellTableViewCell*) cell{
    
    
    if (!_menuView) {
        //        NSArray *imageArray = @[@"newInfo_whiteBack",@"newPro_whiteBack",@"edit_whiteBack"];
        NSArray *imageArray = @[@"liuchengjiankong",@"baocun",@"in",@"link"];
        
        CGRect re=[bt convertRect:bt.bounds toView:self.view];
        _menuView= [[YZNavigationMenuView alloc] initWithPositionOfDirection:CGPointMake(SCREEN_WIDTH-40 ,re.origin.y+30) images:imageArray titleArray:@[@"删除",@"订阅",@"收藏",@"推荐",] andType :0];
        _menuView.cellColor=[UIColor whiteColor];
        _menuView.delegate = self;
        _menuView.userInteractionEnabled=true;
        _menuView.textLabelTextAlignment=NSTextAlignmentLeft;
    }
    
    [self.view addSubview:_menuView];
    
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
