//
//  DCListViewController.m
//  OAWork
//
//  Created by james on 2017/12/7.
//  Copyright © 2017年 james. All rights reserved.
//

#import "DCListViewController.h"
#import "DCListCellTableViewCell.h"
#import "YZNavigationMenuView.h"
#import "DataDetailViewController.h"

@interface DCListViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,YZNavigationMenuViewDelegate>
{
//   UIBarButtonItem *_bar;
    BOOL _isEdite;
    NSMutableArray *_selectedIds;
    UIButton *_bar;
}
@property (nonatomic,strong) UITableView *demoTableView;
@property (nonatomic,strong) NSMutableArray* allArray;
@property (nonatomic,strong) NSMutableArray *searchArr;
@property (nonatomic,strong) UISearchBar *searchBar;
@property (nonatomic,strong) UILabel *currentIndexlb;
@property (nonatomic,strong)  YZNavigationMenuView *menuView;
@end

@implementation DCListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    if (self.type==DCListSave) {
        _currentIndexString=@"收藏";
    }else if (self.type==DCListOrder) {
        _currentIndexString=@"订阅";
    }else if (self.type==DCListRecommend) {
        _currentIndexString=@"推荐";
    }else{
      _currentIndexString= [[_currentIndexString componentsSeparatedByString:@">"] lastObject];
    }
    self.title=_currentIndexString;
    
    
    _isEdite=false;
//    _allArray=[@[@"电子资料库",@"电子资料库",@"电子资料库",@"电子资料库",@"电子资料库",@"电子资料库",@"电子资料库",@"电子资料库",@"电子资料库",@"电子资料库",@"电子资料库",@"电子资料库",@"电子资料库"] mutableCopy];
    
    _searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(10, TOPBARCONTENTHEIGHT+10,SCREEN_WIDTH-20, 35)];
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
    _searchBar.layer.cornerRadius=_searchBar.height/2;
    _searchBar.clipsToBounds=true;
    [self.view addSubview:_searchBar];
//    if (self.type) {
//        _currentIndexlb=[[UILabel alloc]initWithFrame:CGRectMake(_searchBar.left, _searchBar.bottom, _searchBar.width,30)];
//        [_currentIndexlb setTextColor:[UIColor lightGrayColor]];
//        _currentIndexlb.text=[NSString stringWithFormat:@"%@",_currentIndexString];
//        _currentIndexlb.font=[UIFont systemFontOfSize:14.0f];
//        [self.view addSubview:_currentIndexlb];
//    }
    
    _demoTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,_searchBar.bottom+10, SCREEN_WIDTH, SCREEN_HEIGHT-_searchBar.bottom-10)];
    [_demoTableView registerNib:[UINib nibWithNibName:@"OaMainCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"OaMainCellTableViewCell"];
    _demoTableView.delegate=self;
    _demoTableView.dataSource=self;
    _demoTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_demoTableView];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!_bar) {
        _bar=[[UIButton alloc]init];
        NSString *bttitle=@"编辑";
        UIColor * titleColor=[UIColor blackColor];
        if (self.type==DCListSave) {
            bttitle=@"取消收藏";
            titleColor=[Utils colorWithHexString:@"#008fef"];
        }else if (self.type==DCListOrder) {
            bttitle=@"取消订阅";
            titleColor=[Utils colorWithHexString:@"#008fef"];
        }else if (self.type==DCListRecommend) {
            bttitle=@"取消推荐";
            titleColor=[Utils colorWithHexString:@"#008fef"];
        }
       
        [_bar setTitle:bttitle forState: UIControlStateNormal];
        [_bar setTitleColor:titleColor forState:UIControlStateNormal];
         [_bar setTitle:bttitle forState: UIControlStateHighlighted];
       [_bar setTitleColor:titleColor forState:UIControlStateHighlighted];
        [_bar addTarget:self action:@selector(editTapped:) forControlEvents:UIControlEventTouchUpInside];
       UIBarButtonItem* barButton = [[UIBarButtonItem alloc] initWithCustomView:_bar];
        self.navigationItem.rightBarButtonItem = barButton;
    }
}
-(void)editTapped:(UIButton*)bt{
    [self.view endEditing:YES];
    _selectedIds=[NSMutableArray array];
    _isEdite=!_isEdite;
    if (_isEdite) {
        [_bar setTitle:@"完成" forState: UIControlStateNormal];
         [_bar setTitle:@"完成" forState: UIControlStateHighlighted];
        [self changeFileState:nil Type:0];
    }else{
        [_bar setTitle:@"编辑" forState: UIControlStateNormal];
         [_bar setTitle:@"编辑" forState: UIControlStateHighlighted];
    }
    
    [_demoTableView reloadData];
    
    
}
#pragma mark UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *Arra=_searchBar.text.length?_searchArr:_allArray;
    NSDictionary *Adic =Arra[indexPath.row];
    
    DCListCellTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (_isEdite) {//编辑状态，cell只改变状态
        cell.isAddInto=!cell.isAddInto;
        if (cell.isAddInto) {
            if ([_selectedIds containsObject:[NSString stringWithFormat:@"%@",Adic[@"id"]]]) {

            }else{
                [_selectedIds addObject:[NSString stringWithFormat:@"%@",Adic[@"id"]]];
            }
        }else{
            [_selectedIds removeObject:[NSString stringWithFormat:@"%@",Adic[@"id"]]];
        }
        
        return;
    }
//    BOOL folder=false;
//
//    NSString *title=cell.titleLB.text;
//    if (folder) {
//        DataDetailViewController *DCSctrl=[[DataDetailViewController alloc]init];
//        DCSctrl.detailDic=Adic;
//        [self.navigationController pushViewController:DCSctrl animated:YES];
//    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static  NSString  *CellIdentiferId = @"DCListCellTableViewCell";
    DCListCellTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentiferId];
    if (cell == nil) {
        cell=[[DCListCellTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentiferId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate=self;
    };
    if (_isEdite) {
        cell.isStartEdit=20;
    }else{
         cell.isStartEdit=0;
    }

    cell.titleLB.text=_allArray[indexPath.row];
    cell.headIcon.image=[UIImage imageNamed:@"w"];
    return  cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _allArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
    
}

- (void)navigationMenuView:(YZNavigationMenuView *)menuView clickedAtIndex:(NSInteger)index{
    [self removeMenuView];
    NSDictionary *dic=[menuView.accessibilityHint objectFromCTJSONString];
    
    [self changeFileState:dic[@"id"] Type:1];
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
        _menuView.accessibilityHint=[cell.infoDic JSONStringFromCT];
        _menuView.textLabelTextAlignment=NSTextAlignmentLeft;
    }
    
    [self.view addSubview:_menuView];
    
}
-(void)getData{
    
    NSDictionary *parameters =@{@"type":[NSNumber numberWithInt:self.type]};
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    _hud.mode = MBProgressHUDModeAnnularDeterminate;
    self.hud.labelText = @"数据获取中";
    __weak __typeof(self) weakSelf = self;
    [MyRequest getRequestWithUrl:[HostMangager findUserFiles] andPara:parameters isAddUserId:true Success:^(NSDictionary *dict, BOOL success) {
        [weakSelf.hud hide:YES];
        if ([dict isKindOfClass:[NSDictionary class]]&& [dict[@"code"] intValue]==0&&[dict[@"result"] isKindOfClass:[NSArray class]]) {
            weakSelf.allArray=[dict[@"result"] mutableCopy];
           
            [_demoTableView reloadData];
            
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
-(void)changeFileState:(NSString*)fileid Type:(int)type {
//    type 操作类型（0 表示删除，1表示订阅，2表示收藏，3表示推荐，其中0删除不需要管状态值）
//    value  状态值（0表示 取消订阅、取消收藏、取消推荐，1表示订阅、收藏、推荐）
    NSDictionary *parameters;
    if (!fileid) {
       parameters=@{@"type":[NSNumber numberWithInt:self.type],@"fileid":_selectedIds,@"value":@"0"};
    }else{
        parameters=@{@"type":[NSNumber numberWithInt:type],@"fileid":fileid,@"value":@"1"};
    }
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    _hud.mode = MBProgressHUDModeAnnularDeterminate;
    self.hud.labelText = @"数据获取中";
    __weak __typeof(self) weakSelf = self;
    [MyRequest getRequestWithUrl:[HostMangager operateFile] andPara:parameters isAddUserId:true Success:^(NSDictionary *dict, BOOL success) {
        [weakSelf.hud hide:YES];
        [weakSelf.view makeToast:@"修改成功"];
        if ([dict isKindOfClass:[NSDictionary class]]&& [dict[@"code"] intValue]==0&&[dict[@"result"] isKindOfClass:[NSArray class]]) {
            if (!fileid) {
                
                    for (NSString *ids in _selectedIds) {
                        for (long m=weakSelf.allArray.count-1;m>=0;m--) {
                            NSDictionary *dic=weakSelf.allArray[m];
                            if ([dic[@"id"] intValue] ==[ids intValue]) {
                                [weakSelf.allArray removeObject:dic];
                            }
                        }
                    }
                [_selectedIds removeAllObjects];
                [weakSelf.demoTableView reloadData];
            }
            
        }else{
            
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:nil message:@"修改失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [al show];
            
        }
        
    } fail:^(NSError *error) {
        [weakSelf.hud hide:YES];
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:nil message:@"数据获取失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [al show];
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
