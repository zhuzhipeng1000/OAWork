//
//  NeedDoViewController.m
//  OAWork
//
//  Created by james on 2017/11/30.
//  Copyright © 2017年 james. All rights reserved.
//

#import "NeedDoViewController.h"
#import "NeedDoTableViewCell.h"
#import "OAJobDetailViewController.h"

@interface NeedDoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) NSMutableArray *exampleArr; //用于普通显示的数据
@property (nonatomic ,strong)NSMutableArray *searchArr; //用于搜索后显示的数据
@property (nonatomic,strong) NSMutableArray *allArray;//服务返回的数据
@end

@implementation NeedDoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _demoTableView=[[UITableView alloc]initWithFrame:CGRectMake(10, self.navigationController.navigationBar.bottom, SCREEN_WIDTH-20, SCREEN_HEIGHT-50)];
    [_demoTableView registerNib:[UINib nibWithNibName:@"NeedDoTableViewCell" bundle:nil] forCellReuseIdentifier:@"NeedDoTableViewCell"];
    _demoTableView.delegate=self;
    _demoTableView.dataSource=self;
    _demoTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_demoTableView];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *avc;
  
        avc=[[OAJobDetailViewController alloc]initWithNibName:@"OAJobDetailViewController" bundle:nil];
    
        [self.navigationController pushViewController:avc animated:YES];
  
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static  NSString  *CellIdentiferId = @"NeedDoTableViewCell";
    NeedDoTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentiferId];
    if (cell == nil) {
        cell=[[NeedDoTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentiferId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    };
 
    return  cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _allArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
    
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
