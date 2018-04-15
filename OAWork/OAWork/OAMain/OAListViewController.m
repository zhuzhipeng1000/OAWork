//
//  OAListViewController.m
//  OAWork
//
//  Created by james on 2017/12/17.
//  Copyright © 2017年 james. All rights reserved.
//

#import "OAListViewController.h"
#import "OaMainCellTableViewCell.h"
#import "OAJobDetailViewController.h"
#import "NeedDoViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "OAprogressMonitorViewController.h"
@interface OAListViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,OaMainCellTableViCellDelegate>
@property (nonatomic,strong) NSMutableArray *allArray;
@property (nonatomic,strong) UITableView *demoTableView;
@property (nonatomic,strong) UISearchBar *searchBar;
@property (nonatomic,strong) UIView *headBackView;

@property (nonatomic,strong) UIView *moreView;
@property (nonatomic,strong) UIButton *moreBt;
@property (nonatomic,assign) BOOL hiddenTopBt;
@property (nonatomic,strong)  NSArray *arr;
@property (nonatomic,assign) NSInteger currentPageCount;
@property (nonatomic,strong) NSDictionary *catelogDic;
@property (nonatomic,strong) UIButton *selectedCateBt;
@end

@implementation OAListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _currentPageCount=1;
       self.allArray=[NSMutableArray array];
//    self.title=@"公文列表";
    _headBackView=[[UIView alloc]initWithFrame:CGRectMake(0, TOPBARCONTENTHEIGHT, SCREEN_WIDTH, 100)];
    _headBackView.backgroundColor=[Utils colorWithHexString:@"#f7f7f7"];
    [self.view addSubview: _headBackView];
    if (_type==1) {
        _searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(20,10,SCREEN_WIDTH-40, 35)];
        _searchBar.delegate=self;
        UIImage* searchBarBg = [Utils GetImageWithColor:[UIColor whiteColor] andHeight:32.0f];
        //设置背景图片
        [_searchBar setBackgroundImage:searchBarBg];
        //设置背景色
        [_searchBar setBackgroundColor:[UIColor clearColor]];
        //设置文本框背景
        [_searchBar setSearchFieldBackgroundImage:searchBarBg forState:UIControlStateNormal];
        //    seach. barStyle= UIBarStyleBlack;
        _searchBar.backgroundColor=[UIColor whiteColor];
        //    _searchBar.showsCancelButton=YES;
        _searchBar.placeholder=@"请输入关键词";
        _searchBar.layer.cornerRadius=_searchBar.height/2;
        _searchBar.clipsToBounds=true;
        [_headBackView addSubview:_searchBar];
        _headBackView.frame=CGRectMake(0, TOPBARCONTENTHEIGHT, SCREEN_WIDTH, _searchBar.bottom+10);
    }

//
//

//    _allArray=[@[@"公文标题工会内部事务审批单",@"公文标题工会内部事务审批单-标题过长换行文本文本",@"公文列表",@"公文列表",@"公文列表"] mutableCopy];
    _demoTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, _headBackView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-_headBackView.bottom)];
    [_demoTableView registerNib:[UINib nibWithNibName:@"OaMainCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"OaMainCellTableViewCell"];
    _demoTableView.delegate=self;
    _demoTableView.dataSource=self;
    _demoTableView.backgroundColor= [Utils colorWithHexString:@"#f7f7f7"];
    _demoTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_demoTableView];
    __weak __typeof(self) weakSelf = self;
    _demoTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.currentPageCount=1;
        if (weakSelf.type==1) {
            [weakSelf searchData:nil];
        }else{
            [weakSelf countMyWorkItems];
        }
    }];
    _demoTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.currentPageCount++;
        if (weakSelf.type==1) {
            [weakSelf searchData:nil];
        }else{
            [weakSelf countMyWorkItems];
        }
    }];
    // Do any additional setup after loading the view.
}

-(void)addheadButtons{
    for (UIView *aView in _headBackView.subviews) {
        if ([aView isKindOfClass:[UIButton class]]) {
            [aView removeFromSuperview];
        }
    }
    //    _arr=@[(@"中心合同审批处理表"),@"中心请款处理表",@"中心合同审批处理表",@"内部事务",@"行政办公会议材料上报处理表"];//,@"个人请假表"
    _hiddenTopBt=true;
//    if (_type==1) {
//        _arr=@[];
//    }
    for (int d=0; d<_arr.count; d++) {
        NSDictionary *detailDic=_arr[d];
        UIButton* _returnButton=[[UIButton alloc]init];
        _returnButton.tag=1000+d;
        [_returnButton addTarget:self action:@selector(returnButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        NSMutableAttributedString *nameString = [[NSMutableAttributedString alloc] initWithString:detailDic[@"categoryName"] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[Utils colorWithHexString:@"#008fef"]}];
        NSAttributedString *countString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@",detailDic[@"count"]] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[Utils colorWithHexString:@"#09bb07"]}];
        [nameString appendAttributedString:countString];
        [_returnButton setAttributedTitle:nameString forState:UIControlStateNormal];
        //        _returnButton.titleLabel.adjustsFontSizeToFitWidth=YES;
        //        _returnButton.titleLabel.font=[UIFont systemFontOfSize:13.0];
        _returnButton.layer.cornerRadius=10;
        _returnButton.backgroundColor=[UIColor whiteColor];
        _returnButton.clipsToBounds=true;
        //        _returnButton.layer.borderColor=[UIColor lightGrayColor].CGColor;
        _returnButton.layer.borderWidth=1.0f;
        _returnButton.accessibilityHint=[detailDic JSONStringFromCT];
        _returnButton.frame=CGRectMake((d%2)?(SCREEN_WIDTH/2)+5:20,10+10+40*(d/2), SCREEN_WIDTH/2-25, 35);
        [_headBackView addSubview:_returnButton];
        if (d>=4) {
            _returnButton.hidden=_hiddenTopBt;
        }
    }
    if (_arr.count>4&&!_moreView) {
        _headBackView.frame=CGRectMake(0, TOPBARCONTENTHEIGHT, SCREEN_WIDTH, 10+ 120);
        _moreView=[[UIView alloc]initWithFrame:CGRectMake(40, _headBackView.height-40, SCREEN_WIDTH-80, 30)];
        [_headBackView addSubview:_moreView];
        UIImageView *imv=[[UIImageView alloc]initWithFrame:CGRectMake(_moreView.width/2-40,(_moreView.height-13)/2, 13, 13)];
        imv.tag=20011;
        imv.contentMode=UIViewContentModeScaleAspectFit;
        [imv setImage:[UIImage imageNamed:@"arrow_down"]];
        [_moreView addSubview:imv];
        UILabel *lb=[[UILabel alloc]initWithFrame:CGRectMake(imv.right+20, 0, 45, _moreView.height)];
        lb.text=@"展开";
        lb.font=[UIFont systemFontOfSize:14.0f];
        lb.tag=20010;
        lb.textColor=[Utils colorWithHexString:@"#008fef"];
        [_moreView addSubview:lb];
        _moreBt=[[UIButton alloc]initWithFrame:_moreView.bounds];
        [_moreBt addTarget:self action:@selector(moreBtTapped:) forControlEvents:UIControlEventTouchUpInside];
        [_moreView addSubview:_moreBt];
        
    }else{
        _headBackView.frame=CGRectMake(0,TOPBARCONTENTHEIGHT, SCREEN_WIDTH, 55+((_arr.count%2)?40*(_arr.count/2+1):40*(_arr.count/2)));
    }
    
     _demoTableView.frame=CGRectMake(0, _headBackView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-_headBackView.bottom);
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(_type!=1&&!_catelogDic){
        [self countMyWorkItems];
    }
//    [self getData];
    
}
-(void)returnButtonTapped:(UIButton*)bt{
    NSDictionary *dic=[bt.accessibilityHint objectFromCTJSONString];
    if (_selectedCateBt==bt) {
        return;
    }
//    NSMutableAttributedString *nameString = [[NSMutableAttributedString alloc] initWithString:dic[@"categoryName"] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[Utils colorWithHexString:@"#008fef"]}];
//    NSAttributedString *countString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@",dic[@"count"]] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[Utils colorWithHexString:@"#09bb07"]}];
//    [nameString appendAttributedString:countString];

//    [bt setAttributedTitle:nameString forState:UIControlStateNormal];
    [bt setBackgroundImage:[Utils createImageWithColor:[UIColor lightGrayColor]] forState:UIControlStateNormal];
    [_selectedCateBt setBackgroundImage:[Utils createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
//    [bt setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _selectedCateBt=bt;
    _catelogDic=dic;
    [self getData:dic];
}
-(void)searchData:(NSDictionary*)categoryDic{
    
    
    NSDictionary *parameters =@{@"name":_searchBar.text,@"pageNum":[NSNumber numberWithInteger:_currentPageCount],@"pageSize":@"10"};
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    _hud.mode = MBProgressHUDModeAnnularDeterminate;
    self.hud.labelText = @"数据获取中";
    __weak __typeof(self) weakSelf = self;
    [MyRequest getRequestWithUrl:[HostMangager searchWorkItems] andPara:parameters isAddUserId:true Success:^(NSDictionary *dict, BOOL success) {
        [weakSelf.hud hide:YES];
        if ([dict isKindOfClass:[NSDictionary class]]&&[dict[@"code"] intValue]==0) {
            weakSelf.allArray=[NSMutableArray array];
            for (NSDictionary *dic in dict[@"result"]) {
                //                if ([[Utils getNotNullNotNill: dic[@"TITLE"]] length]>0 ) {
                [weakSelf.allArray addObject:dic];
                //                }
            }
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
-(void)getData:(NSDictionary*)categoryDic{
    
    
    NSDictionary *parameters =@{@"status":@(_type-1),@"categoryId":self.catelogDic[@"categoryId"],@"pageNum":[NSNumber numberWithInteger:_currentPageCount],@"pageSize":@"10"};
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    _hud.mode = MBProgressHUDModeAnnularDeterminate;
    self.hud.labelText = @"数据获取中";
    __weak __typeof(self) weakSelf = self;
    [MyRequest getRequestWithUrl:[HostMangager oaListUrl] andPara:parameters isAddUserId:true Success:^(NSDictionary *dict, BOOL success) {
        [weakSelf.hud hide:YES];
        if ([dict isKindOfClass:[NSDictionary class]]&&[dict[@"code"] intValue]==0) {
            if (_currentPageCount==1) {
                [weakSelf.allArray removeAllObjects];
            }
         
            for (NSDictionary *dic in dict[@"result"]) {
//                if ([[Utils getNotNullNotNill: dic[@"TITLE"]] length]>0 ) {
                    [weakSelf.allArray addObject:dic];
//                }
            }
            [weakSelf.demoTableView reloadData];
            [weakSelf.demoTableView.mj_footer endRefreshing];
            [weakSelf.demoTableView.mj_header endRefreshing];
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
-(void)countMyWorkItems{
    
    
    NSDictionary *parameters =@{@"status":@(_type-1)};
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    _hud.mode = MBProgressHUDModeAnnularDeterminate;
    self.hud.labelText = @"数据获取中";
    __weak __typeof(self) weakSelf = self;
    [MyRequest getRequestWithUrl:[HostMangager countMyWorkItems] andPara:parameters isAddUserId:true Success:^(NSDictionary *dict, BOOL success) {
        [weakSelf.hud hide:YES];
        if ([dict isKindOfClass:[NSDictionary class]]&&[dict[@"code"] intValue]==0&&[dict[@"result"] isKindOfClass:[NSArray class]]) {
            if ([dict[@"result"]  count]>0) {
                weakSelf.arr=dict[@"result"];
                int lastSelectedIndex=-1;
                if (weakSelf.catelogDic) {
                    for (int d=0; d<weakSelf.arr.count; d++) {
                        NSDictionary *detailDic=weakSelf.arr[d];
                        if ([detailDic[@"categoryId"] intValue]==[weakSelf.catelogDic[@"categoryId"]intValue] ) {
                            lastSelectedIndex=d;
                        }
                    }
                }
                [weakSelf addheadButtons];
                if (lastSelectedIndex>=0) {
                    
                }else{
                    lastSelectedIndex=0;
                    weakSelf.catelogDic=weakSelf.arr[0];
                    
                }
                UIButton *bt=[weakSelf.headBackView viewWithTag:1000+lastSelectedIndex];
                
                if ([bt isKindOfClass:[UIButton class]]) {
                    [weakSelf returnButtonTapped:bt];
                }
               
            }
           
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

-(void)moreBtTapped:(UIButton*)bt{
    _hiddenTopBt=!_hiddenTopBt;
    if (!_hiddenTopBt) {
        for (UIView *aView in _headBackView.subviews) {
            aView.hidden=false;
        }
        _headBackView.frame=CGRectMake(0,TOPBARCONTENTHEIGHT, SCREEN_WIDTH, 55+((_arr.count%2)?40*(_arr.count/2+2):40*(_arr.count/2+1)));
        _moreView.frame=CGRectMake(40, _headBackView.height-40, SCREEN_WIDTH-80, 30);
        
        UILabel* alb= [_moreView viewWithTag:20010] ;
        [alb setText:@"缩起"];
        UIImageView* imv= [_moreView viewWithTag:20011] ;
        imv.transform =CGAffineTransformMakeRotation (M_PI_2*2);
        
    }else{
        for (UIView *aView in _headBackView.subviews) {
            if ([aView isKindOfClass:[UIButton class]]&&aView.tag>1003) {
                aView.hidden=true;
            }
        }
         _headBackView.frame=CGRectMake(0, TOPBARCONTENTHEIGHT, SCREEN_WIDTH,120+55);
         _moreView.frame=CGRectMake(40, _headBackView.height-40, SCREEN_WIDTH-80, 30);
        UILabel* alb= [_moreView viewWithTag:20010] ;
        [alb setText:@"展开"];
        UIImageView* imv= [_moreView viewWithTag:20011] ;
        imv.transform =CGAffineTransformMakeRotation(0);
    }
    _demoTableView.frame=CGRectMake(0, _headBackView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-_headBackView.bottom);
    
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
    static  NSString  *CellIdentiferId = @"OaMainCellTableViewCell";
    OaMainCellTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentiferId];
    if (cell == nil) {
        cell=[[OaMainCellTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentiferId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    };
    NSDictionary *detailDic=_allArray[indexPath.row];
    cell.delagate=self;
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
#pragma mark searBarDeleager
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if ([searchBar.text length]) {
        [self searchData:nil];
    }
}

-(void)returnBtTappedOnCell:(OaMainCellTableViewCell*)cell{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText = @"提交中";
    __weak __typeof(self) weakSelf = self;
//    [MyRequest getRequestWithUrl:[HostMangager projectNewUrl] andPara:nil isAddUserId:YES Success:^(NSDictionary *dict, BOOL success) {
//        [weakSelf.hud hide:YES];
//
//    } fail:^(NSError *error) {
//        [weakSelf.hud hide:YES];
//
//    }];
}
-(void)progressTappedOnCell:(OaMainCellTableViewCell *)cell{
    OAprogressMonitorViewController *moct=[[OAprogressMonitorViewController alloc]init];
    NSIndexPath *indexPath=[_demoTableView indexPathForCell:cell];
    NSDictionary *detailDic=_allArray[indexPath.row];
    moct.infost=detailDic;
    [self.navigationController pushViewController:moct animated:YES];
}
-(void)deleteBtTappedOnCell:(OaMainCellTableViewCell*)cell{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText = @"提交中";
    __weak __typeof(self) weakSelf = self;
//    [MyRequest getRequestWithUrl:[HostMangager projectNewUrl] andPara:nil isAddUserId:YES Success:^(NSDictionary *dict, BOOL success) {
//        [weakSelf.hud hide:YES];
//
//    } fail:^(NSError *error) {
//        [weakSelf.hud hide:YES];
//
//    }];
    
}
-(void)seeDetailBtTappedOnCell:(OaMainCellTableViewCell*)cell{
    NeedDoViewController *avc;
            avc=[[NeedDoViewController alloc]initWithNibName:@"NeedDoViewController" bundle:nil];
    NSIndexPath *indexPath=[_demoTableView indexPathForCell:cell];
    NSDictionary *detailDic=_allArray[indexPath.row];
    avc.needDoDic=detailDic;
        if (avc) {
            [self.navigationController pushViewController:avc animated:YES];
        }
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
