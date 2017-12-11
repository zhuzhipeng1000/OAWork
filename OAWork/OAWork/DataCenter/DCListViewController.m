//
//  DCListViewController.m
//  OAWork
//
//  Created by james on 2017/12/7.
//  Copyright © 2017年 james. All rights reserved.
//

#import "DCListViewController.h"
#import "DCListCellTableViewCell.h"

@interface DCListViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
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

@end

@implementation DCListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.type==DCListSave) {
        _currentIndexString=@"收藏";
    }else if (self.type==DCListOrder) {
        _currentIndexString=@"订阅";
    }else if (self.type==DCListRecommend) {
        _currentIndexString=@"推荐";
    }else{
        [[_currentIndexString componentsSeparatedByString:@">"] lastObject];
    }
    
    self.navigationController.title=@"电子资料库";
    _isEdite=false;
    _allArray=[@[@"电子资料库",@"电子资料库",@"电子资料库",@"电子资料库",@"电子资料库",@"电子资料库",@"电子资料库",@"电子资料库",@"电子资料库",@"电子资料库",@"电子资料库",@"电子资料库",@"电子资料库"] mutableCopy];
    
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
    if (self.type) {
        _currentIndexlb=[[UILabel alloc]initWithFrame:CGRectMake(_searchBar.left, _searchBar.bottom, _searchBar.width,30)];
        [_currentIndexlb setTextColor:[UIColor lightGrayColor]];
        _currentIndexlb.text=[NSString stringWithFormat:@"%@",_currentIndexString];
        _currentIndexlb.font=[UIFont systemFontOfSize:14.0f];
        [self.view addSubview:_currentIndexlb];
    }
    
    _demoTableView=[[UITableView alloc]initWithFrame:CGRectMake(10,self.type?_currentIndexlb.bottom:_searchBar.bottom, SCREEN_WIDTH-20, SCREEN_HEIGHT-_searchBar.bottom)];
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
        [_bar setTitle:@"编辑" forState: UIControlStateNormal];
        [_bar setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
         [_bar setTitle:@"编辑" forState: UIControlStateHighlighted];
       [_bar setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
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
//        if (cell.isAddInto) {
//            if ([_selectedIds containsObject:Adic[@"id"]]) {
//
//            }else{
//                [_selectedIds addObject:Adic[@"id"]];
//            }
//        }else{
//            [_selectedIds removeObject:Adic[@"id"]];
//        }
        
        return;
    }
    BOOL folder=false;
   
    NSString *title=cell.titleLB.text;
    if (folder) {
        DCListViewController *DCSctrl=[[DCListViewController alloc]init];
        DCSctrl.currentIndexString=[NSString stringWithFormat:@"%@>%@",_currentIndexString,title];
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
    if (_isEdite) {
        cell.isStartEdit=40;
    }else{
         cell.isStartEdit=0;
    }
    cell.titleLB.text=_allArray[indexPath.row];
    cell.headIcon.image=[UIImage imageNamed:@"wifi"];
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
