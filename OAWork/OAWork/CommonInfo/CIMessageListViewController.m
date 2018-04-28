//
//  CIMessageListViewController.m
//  OAWork
//
//  Created by james on 2017/12/11.
//  Copyright © 2017年 james. All rights reserved.
//

#import "CIMessageListViewController.h"
#import "MessageListCell.h"
#import "CIMessageDetailViewController.h"

@interface CIMessageListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *demoTableView;
@property (nonatomic,strong) NSMutableArray* allArray;
@property (nonatomic,strong) NSMutableArray *searchArr;
@property (nonatomic,strong) UISearchBar *searchBar;
@end

@implementation CIMessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"通知公告";
    _allArray=[@[@"广州",@"行政",@"人事",@"财务"]  mutableCopy];
//    [self getAllData];
    _demoTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,TOPBARCONTENTHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-TOPBARCONTENTHEIGHT)];
    [_demoTableView registerNib:[UINib nibWithNibName:@"OaMainCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"OaMainCellTableViewCell"];
    _demoTableView.delegate=self;
    _demoTableView.dataSource=self;
    _demoTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_demoTableView];
    // Do any additional setup after loading the view.
}
#pragma mark UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *Arra=_searchBar.text.length?_searchArr:_allArray;
    NSDictionary *Adic =Arra[indexPath.row];
    [self updateMessageStatue:Adic[@"id"]];
    CIMessageDetailViewController *cimd=[[CIMessageDetailViewController alloc]init];
    cimd.messageDic=Adic;
    [self.navigationController pushViewController:cimd animated:YES];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static  NSString  *CellIdentiferId = @"MessageListCell";
    MessageListCell  *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentiferId];
    if (cell == nil) {
        cell=[[MessageListCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentiferId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    };
    cell.titleLb.text=@"广州最新教育用广州最新教育用广州最新教育用";
    if (indexPath.row==0) {
    cell.headIcon.image=[UIImage imageNamed:@"nothing"];
    }else{
       cell.headIcon.image=[UIImage imageNamed:@"user"];
    }
    
    cell.personNameLB.text=@"吴中找工作";
    cell.timeLB.text=@"2017-10-18";
    cell.departmentNameLB.text=@"人事部";
    return  cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _allArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
    
}
-(void)getAllData{
    
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.hud.labelText = @"数据获取中";
        __weak __typeof(self) weakSelf = self;
        [MyRequest getRequestWithUrl:[HostMangager noticeList] andPara:nil isAddUserId:YES Success:^(NSDictionary *dict, BOOL success) {
            weakSelf.allArray=[dict[@"result"] mutableCopy];
            [weakSelf.demoTableView reloadData];
            [weakSelf.hud hide:YES];
    
        } fail:^(NSError *error) {
            [weakSelf.hud hide:YES];
    
        }];
}
-(void)updateMessageStatue:(NSString*)messageId{
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText = @"数据获取中";
    __weak __typeof(self) weakSelf = self;
    NSDictionary *para=@{@"noticeId":messageId};
    [MyRequest getRequestWithUrl:[HostMangager noticeUpdateViewStatus] andPara:para isAddUserId:YES Success:^(NSDictionary *dict, BOOL success) {
        weakSelf.allArray=[dict[@"result"] mutableCopy];
        [weakSelf.demoTableView reloadData];
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
