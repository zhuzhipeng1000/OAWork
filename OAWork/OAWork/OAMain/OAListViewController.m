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
@interface OAListViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,OaMainCellTableViCellDelegate>
@property (nonatomic,strong) NSMutableArray *allArray;
@property (nonatomic,strong) UITableView *demoTableView;
@property (nonatomic,strong) UISearchBar *searchBar;
@property (nonatomic,strong) UIView *headBackView;

@property (nonatomic,strong) UIView *moreView;
@property (nonatomic,strong) UIButton *moreBt;
@property (nonatomic,assign) BOOL hiddenTopBt;
@property (nonatomic,strong)  NSArray *arr;
@end

@implementation OAListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"公文列表";
    _headBackView=[[UIView alloc]initWithFrame:CGRectMake(0, TOPBARCONTENTHEIGHT, SCREEN_WIDTH, 100)];
    _headBackView.backgroundColor=[Utils colorWithHexString:@"#f7f7f7"];
    [self.view addSubview: _headBackView];
    
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
    
    _arr=@[(@"中心合同审批处理表"),@"中心请款处理表",@"中心合同审批处理表",@"内部事务",@"行政办公会议材料上报处理表",@"个人请假表"];
    _hiddenTopBt=true;
    for (int d=0; d<_arr.count; d++) {
        UIButton* _returnButton=[[UIButton alloc]init];
        _returnButton.tag=1000+d;
        [_returnButton addTarget:self action:@selector(returnButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        NSMutableAttributedString *nameString = [[NSMutableAttributedString alloc] initWithString:_arr[d] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[Utils colorWithHexString:@"#008fef"]}];
        NSAttributedString *countString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %d",d+1] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[Utils colorWithHexString:@"#09bb07"]}];
        [nameString appendAttributedString:countString];
        [_returnButton setAttributedTitle:nameString forState:UIControlStateNormal];
//        _returnButton.titleLabel.adjustsFontSizeToFitWidth=YES;
//        _returnButton.titleLabel.font=[UIFont systemFontOfSize:13.0];
        _returnButton.layer.cornerRadius=10;
        _returnButton.backgroundColor=[UIColor whiteColor];
//        _returnButton.layer.borderColor=[UIColor lightGrayColor].CGColor;
        _returnButton.layer.borderWidth=1.0f;
        _returnButton.frame=CGRectMake((d%2)?(SCREEN_WIDTH/2)+5:20,_searchBar.bottom+10+40*(d/2), SCREEN_WIDTH/2-25, 35);
        [_headBackView addSubview:_returnButton];
        if (d>=4) {
            _returnButton.hidden=_hiddenTopBt;
        }
    }
    if (_arr.count>4&&!_moreView) {
        _headBackView.frame=CGRectMake(0, TOPBARCONTENTHEIGHT, SCREEN_WIDTH, _searchBar.bottom+ 120);
        _moreView=[[UIView alloc]initWithFrame:CGRectMake(40, _headBackView.height-40, SCREEN_WIDTH-80, 30)];
        [_headBackView addSubview:_moreView];
        UIImageView *imv=[[UIImageView alloc]initWithFrame:CGRectMake(_moreView.width/2-40,(_moreView.height-13)/2, 13, 13)];
        imv.tag=20011;
        [imv setImage:[UIImage imageNamed:@"arrow_up"]];
        [_moreView addSubview:imv];
        UILabel *lb=[[UILabel alloc]initWithFrame:CGRectMake(imv.right+20, 0, 45, _moreView.height)];
        lb.text=@"展开";
        lb.tag=20010;
        lb.textColor=[Utils colorWithHexString:@"#008fef"];
        [_moreView addSubview:lb];
        _moreBt=[[UIButton alloc]initWithFrame:_moreView.bounds];
        [_moreBt addTarget:self action:@selector(moreBtTapped:) forControlEvents:UIControlEventTouchUpInside];
        [_moreView addSubview:_moreBt];
        
    }else{
        _headBackView.frame=CGRectMake(0,TOPBARCONTENTHEIGHT, SCREEN_WIDTH, _searchBar.bottom+5+(_arr.count%2)?40*(_arr.count/2+1):40*(_arr.count/2));
    }
    
    
    _allArray=[@[@"公文标题工会内部事务审批单",@"公文标题工会内部事务审批单-标题过长换行文本文本",@"公文列表",@"公文列表",@"公文列表"] mutableCopy];
    _demoTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, _headBackView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-_headBackView.bottom)];
    [_demoTableView registerNib:[UINib nibWithNibName:@"OaMainCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"OaMainCellTableViewCell"];
    _demoTableView.delegate=self;
    _demoTableView.dataSource=self;
    _demoTableView.backgroundColor= [Utils colorWithHexString:@"#f7f7f7"];
    _demoTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_demoTableView];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText = @"数据获取中";
    __weak __typeof(self) weakSelf = self;
    [MyRequest getRequestWithUrl:[HostMangager projectNewUrl] andPara:nil isAddUserId:YES Success:^(NSDictionary *dict, BOOL success) {
        [weakSelf.hud hide:YES];
        
    } fail:^(NSError *error) {
        [weakSelf.hud hide:YES];
        
    }];
}
-(void)returnButtonTapped:(UIButton*)bt{
    
    
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
        imv.transform =CGAffineTransformRotate(imv.transform, 0);
        
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
        imv.transform =CGAffineTransformRotate(imv.transform, 180);
    }
    _demoTableView.frame=CGRectMake(0, _headBackView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-_headBackView.bottom);
    
}
#pragma mark UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *avc;
    
        avc=[[NeedDoViewController alloc]initWithNibName:@"NeedDoViewController" bundle:nil];
   
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
    cell.delagate=self;
    cell.titleLB.text=_allArray[indexPath.row];
    cell.imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"p_%ld",(indexPath.row%3+1)]];
    cell.senderLB.text=@"王小动";
    cell.curentLB.text=@"部门审批";
    return  cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _allArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
    
}
-(void)returnBtTappedOnCell:(OaMainCellTableViewCell*)cell{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText = @"提交中";
    __weak __typeof(self) weakSelf = self;
    [MyRequest getRequestWithUrl:[HostMangager projectNewUrl] andPara:nil isAddUserId:YES Success:^(NSDictionary *dict, BOOL success) {
        [weakSelf.hud hide:YES];
        
    } fail:^(NSError *error) {
        [weakSelf.hud hide:YES];
        
    }];
}
-(void)deleteBtTappedOnCell:(OaMainCellTableViewCell*)cell{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText = @"提交中";
    __weak __typeof(self) weakSelf = self;
    [MyRequest getRequestWithUrl:[HostMangager projectNewUrl] andPara:nil isAddUserId:YES Success:^(NSDictionary *dict, BOOL success) {
        [weakSelf.hud hide:YES];
        
    } fail:^(NSError *error) {
        [weakSelf.hud hide:YES];
        
    }];
    
}
-(void)seeDetailBtTappedOnCell:(OaMainCellTableViewCell*)cell{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText = @"提交中";
    __weak __typeof(self) weakSelf = self;
    [MyRequest getRequestWithUrl:[HostMangager projectNewUrl] andPara:nil isAddUserId:YES Success:^(NSDictionary *dict, BOOL success) {
        [weakSelf.hud hide:YES];
        
    } fail:^(NSError *error) {
        [weakSelf.hud hide:YES];
        
    }];
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
