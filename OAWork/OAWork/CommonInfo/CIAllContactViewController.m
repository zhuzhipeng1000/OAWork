//
//  CIAllContactViewController.m
//  OAWork
//
//  Created by james on 2017/12/11.
//  Copyright © 2017年 james. All rights reserved.
//

#import "CIAllContactViewController.h"
#import "CIAreaContactViewController.h"

@interface CIAllContactViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *demoTableView;
@property (nonatomic,strong) NSMutableArray* allArray;
@property (nonatomic,strong) NSMutableArray *searchArr;
@property (nonatomic,strong) UISearchBar *searchBar;
@end

@implementation CIAllContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       self.title=@"全区通讯录";
//    _allArray=[@[@"广州",@"行政",@"人事",@"财务"]  mutableCopy];
    [self  getAllData];
    _demoTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,TOPBARCONTENTHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-TOPBARCONTENTHEIGHT)];
    [_demoTableView registerNib:[UINib nibWithNibName:@"OaMainCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"OaMainCellTableViewCell"];
    _demoTableView.delegate=self;
    _demoTableView.dataSource=self;
    _demoTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_demoTableView];
    // Do any additional setup after loading the view.
}
-(void)getAllData{
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText = @"数据获取中";
    __weak __typeof(self) weakSelf = self;
    NSDictionary *para=@{@"account":[User shareUser].ACCOUNT};
    [MyRequest getRequestWithUrl:[HostMangager findUserGroup] andPara:para isAddUserId:YES Success:^(NSDictionary *dict, BOOL success) {
        weakSelf.allArray=[dict[@"result"] mutableCopy];
        [weakSelf.demoTableView reloadData];
        [weakSelf.hud hide:YES];
        
    } fail:^(NSError *error) {
        [weakSelf.hud hide:YES];
        
    }];
}
#pragma mark UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *Arra=_searchBar.text.length?_searchArr:_allArray;
    NSDictionary *Adic =Arra[indexPath.row];
    CIAreaContactViewController *civct=[[CIAreaContactViewController alloc]init];
    civct.area=Adic[@"GROUPID"];
    civct.title=Adic[@"GROUPNAME"];
    [self.navigationController pushViewController:civct animated:YES];
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static  NSString  *CellIdentiferId = @"CIAllContactViewController";
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentiferId];
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentiferId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *tileLb=[[UILabel alloc]initWithFrame:CGRectMake(30, 0, SCREEN_WIDTH-60, 40)];
        tileLb.textColor=[UIColor lightGrayColor];
        tileLb.font=[UIFont systemFontOfSize:14.0];
        tileLb.tag=1001;
        [cell.contentView addSubview:tileLb];
        
        UIImageView *im=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow_down"]];
        im.frame=CGRectMake(tileLb.right, tileLb.top+(tileLb.height-20)/2, 24, 20);
        im.tag=1002;
        im.contentMode=UIViewContentModeScaleAspectFit;
        im.transform=CGAffineTransformMakeRotation((M_PI_2*3));// 像右往左转
        im.transform=CGAffineTransformScale(im.transform, 0.5, 0.5);
        [cell.contentView addSubview:im];
        
        UIView *bottomStrait=[[UIView alloc]initWithFrame:CGRectMake(0,tileLb.height-1, SCREEN_WIDTH, 1)];
        bottomStrait.backgroundColor=[Utils colorWithHexString:@"#e4e4e4"];
        [cell.contentView addSubview:bottomStrait];
    };
    UILabel *lb=[cell.contentView viewWithTag:1001];
   NSDictionary *dic =_allArray[indexPath.row];
    lb.text=dic[@"GROUPNAME"];
    return  cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _allArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 42;
    
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
