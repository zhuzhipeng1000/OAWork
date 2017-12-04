//
//  PersonalViewController.m
//  OAWork
//
//  Created by james on 2017/11/24.
//  Copyright © 2017年 james. All rights reserved.
//

#import "PersonalViewController.h"
#import "OaMainCellTableViewCell.h"
#import "ForgetPassWordViewController.h"
#import "PersonDetailViewController.h"

@interface PersonalViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *allArray;

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title=@"个人设置";
    self.navigationController.title=@"个人设置";
    [self createNaviTopBarWithShowBackBtn:false showTitle:YES];

    _allArray = [@[@"个人信息",@"修改密码"] mutableCopy];
    
    _demoTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, TOPBARCONTENTHEIGHT, SCREEN_WIDTH-20, SCREEN_HEIGHT-50)];
    [_demoTableView registerNib:[UINib nibWithNibName:@"OaMainCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"OaMainCellTableViewCell"];
    _demoTableView.delegate=self;
    _demoTableView.dataSource=self;
    _demoTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_demoTableView];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=true;
}
#pragma mark UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *avc;
    if (indexPath.row==0) {
        avc=[[PersonDetailViewController alloc]initWithNibName:@"PersonDetailViewController" bundle:nil];

    }else if (indexPath.row==1) {
        avc=[[ForgetPassWordViewController alloc]initWithNibName:@"ForgetPassWordViewController" bundle:nil];

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
