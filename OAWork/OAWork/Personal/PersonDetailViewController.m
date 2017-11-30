//
//  PersonDetailViewController.m
//  OAWork
//
//  Created by james on 2017/11/30.
//  Copyright © 2017年 james. All rights reserved.
//

#import "PersonDetailViewController.h"
#import "OaMainCellTableViewCell.h"
#import "PersonTableViewCell.h"

@interface PersonDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *allArray;


@end

@implementation PersonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _allArray = [@[@"头像",@"姓名",@"性别",@"手机号码",@"邮箱",@"部门",@"个人签名"] mutableCopy];
    
    _demoTableView=[[UITableView alloc]initWithFrame:CGRectMake(10, self.navigationController.navigationBar.bottom, SCREEN_WIDTH-20, SCREEN_HEIGHT-50)];
    [_demoTableView registerNib:[UINib nibWithNibName:@"PersonTableViewCell" bundle:nil] forCellReuseIdentifier:@"PersonTableViewCell"];
    _demoTableView.delegate=self;
    _demoTableView.dataSource=self;
    _demoTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_demoTableView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *avc;
    if (indexPath.row==0) {
//        avc=[[PersonDetailViewController alloc]initWithNibName:@"PersonDetailViewController" bundle:nil];
        
    }else if (indexPath.row==1) {
//        avc=[[ForgetPassWordViewController alloc]initWithNibName:@"ForgetPassWordViewController" bundle:nil];
        
    }
    if (avc) {
        [self.navigationController pushViewController:avc animated:YES];
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static  NSString  *CellIdentiferId = @"PersonTableViewCell";
    PersonTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentiferId];
    if (cell == nil) {
        cell=[[PersonTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentiferId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    };
    cell.titleLb.text=_allArray[indexPath.row];
    cell.imageView.image=[UIImage imageNamed:@"wifi"];
    return  cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _allArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
    
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
