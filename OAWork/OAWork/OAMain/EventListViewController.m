//
//  EventListViewController.m
//  OAWork
//
//  Created by james on 2017/12/17.
//  Copyright © 2017年 james. All rights reserved.
//

#import "EventListViewController.h"


@interface EventListViewController ()
{
    
    UIButton* _bar;
    BOOL isEdit;
}
@end

@implementation EventListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"事件列表";
    isEdit=false;
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
        _bar.frame=CGRectMake(SCREEN_WIDTH-60, 20, 60, 44);
        [self.view addSubview:_bar];
    }
    _bar.hidden=false;
    
}
-(void)editTapped:(UIButton*)bt{
    isEdit=!isEdit;
    if (isEdit) {
        [_bar setTitle:@"完成" forState: UIControlStateNormal];
        [_bar setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_bar setTitle:@"完成" forState: UIControlStateHighlighted];
    }else{
        [_bar setTitle:@"编辑" forState: UIControlStateNormal];
        [_bar setTitle:@"编辑" forState: UIControlStateHighlighted];
    }
    
}
#pragma mark UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static  NSString  *CellIdentiferId = @"EventListCell";
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentiferId];
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentiferId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    };
    cell.textLabel.text=@"中午要会见王总";
    cell.detailTextLabel.text=@"2017-10-12";
    return  cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
    
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
