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
    _allArray = [@[@{@"title":@"代办公文",@"normalImage":@"",@"highLightedImage":@""},@{@"title":@"待阅公文",@"normalImage":@"",@"highLightedImage":@""},@{@"title":@"流转公文",@"normalImage":@"",@"highLightedImage":@""},@{@"title":@"收件箱",@"normalImage":@"",@"highLightedImage":@""},@{@"title":@"我的收藏",@"normalImage":@"",@"highLightedImage":@""},@{@"title":@"我的订阅",@"normalImage":@"",@"highLightedImage":@""},@{@"title":@"已办公文",@"normalImage":@"",@"highLightedImage":@""},@{@"title":@"已阅公文",@"normalImage":@"",@"highLightedImage":@""},@{@"title":@"个人日程",@"normalImage":@"",@"highLightedImage":@""}] mutableCopy];
    
    UIView *aView=[UIView alloc]initWithFrame:CGRectMake(0,80 , SCREEN_WIDTH, SCREEN_WIDTH)
    for (int d=0; d<_allArray.co; <#increment#>) {
        <#statements#>
    }
    
    _demoTableView=[[UITableView alloc]initWithFrame:CGRectMake(10, self.navigationController.navigationBar.bottom, SCREEN_WIDTH-20, SCREEN_HEIGHT-50)];
    [_demoTableView registerNib:[UINib nibWithNibName:@"OaMainCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"OaMainCellTableViewCell"];
    _demoTableView.delegate=self;
    _demoTableView.dataSource=self;
    _demoTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_demoTableView];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=false;
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
