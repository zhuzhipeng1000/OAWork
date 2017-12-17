//
//  EventDetailViewController.m
//  OAWork
//
//  Created by james on 2017/12/17.
//  Copyright © 2017年 james. All rights reserved.
//

#import "EventDetailViewController.h"

@interface EventDetailViewController ()
{
    UIButton* _bar;
    BOOL isEdit;
    UIButton *detailBt;
}
@end

@implementation EventDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"事件详细 2017-10-12";
    
    UITextView *tf=[[UITextView alloc]init];
    tf.frame=CGRectMake(0, TOPBARCONTENTHEIGHT, SCREEN_WIDTH, 100);
    tf.textColor=[UIColor blackColor];
    tf.text=@"中午要会见王总";
    [self.view addSubview:tf];
    
    detailBt=[[UIButton alloc]init];
    
    detailBt.frame=CGRectMake(20, tf.bottom+20, SCREEN_WIDTH-40, 44);
    
    [detailBt setTitle:@"删除" forState:UIControlStateNormal];
    [detailBt setTitle:@"删除"  forState:UIControlStateHighlighted];
    [detailBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [detailBt addTarget:self action:@selector(detailBtTapped:) forControlEvents:UIControlEventTouchUpInside];
    [detailBt setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    detailBt.titleLabel.adjustsFontSizeToFitWidth=YES;
    detailBt.titleLabel.font=[UIFont systemFontOfSize:14.0];
    detailBt.layer.cornerRadius=15;
    detailBt.layer.borderColor=[UIColor lightGrayColor].CGColor;
    detailBt.layer.borderWidth=1.0f;
    [self.view addSubview:detailBt];
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
        detailBt.hidden=YES;
    }else{
        [_bar setTitle:@"编辑" forState: UIControlStateNormal];
        [_bar setTitle:@"编辑" forState: UIControlStateHighlighted];
        detailBt.hidden=false;
    }
    
}
-(void)detailBtTapped:(UIButton*)
bt{
    
    [self.navigationController popViewControllerAnimated:YES];
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
