//
//  ListSelectView.m
//  ProductAduit
//
//  Created by JIME on 2017/1/19.
//  Copyright © 2017年 JIME. All rights reserved.
//

#import "ListSelectView.h"

@interface ListSelectView()<UITableViewDelegate,UITableViewDataSource>{
    UIImageView *iam;
    UILabel *label;

}

@end

@implementation ListSelectView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled=YES;
        
        
        label=[[UILabel alloc]initWithFrame:CGRectMake(5, 0,frame.size.width-10 , frame.size.height)];
//        label.adjustsFontSizeToFitWidth=YES;
        label.font=[UIFont systemFontOfSize:15.0f];
        label.textColor=[UIColor blackColor];
        label.textAlignment=NSTextAlignmentCenter;
        [self addSubview:label];
        
        iam=[[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width-10,(frame.size.height-5)/2, 8, 5)];
        iam.image=[UIImage imageNamed:@"arrow_down"];
//        iam.transform = CGAffineTransformMakeRotation(M_PI/2);
        [self addSubview:iam];
        
        UIButton *bt=[[UIButton alloc]initWithFrame:CGRectMake(5, 0,frame.size.width , frame.size.height)];
        [self addSubview:bt];
        bt.backgroundColor=[UIColor clearColor];
        [bt  addTarget:self action:@selector(btTapped:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return self;
}
- (void)setTitleArray:(NSArray *)titleArray{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y+self.frame.size.height, self.frame.size.width, 100)];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.hidden=YES;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        [self.superview addSubview:_tableView];
    }
    if ([titleArray isKindOfClass:[NSArray class]]&&titleArray.count>0) {
        label.text=titleArray[0];
    }
    _titleArray=titleArray;
    [_tableView reloadData];
}
#pragma mark TableViewDataSourceDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        UILabel *aLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 0, 70, 28)];
        aLabel.textAlignment=NSTextAlignmentCenter;
        aLabel.tag=10000;
        [cell.contentView addSubview:aLabel];
        aLabel.font = [UIFont systemFontOfSize:15.0];
        
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0,29, 85, 1)];
        lineView.backgroundColor=[UIColor lightGrayColor];
        [cell.contentView addSubview:lineView];
    }
    UILabel *aLabel=[cell viewWithTag:10000];
    aLabel.text = [_titleArray objectAtIndex:indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    label.text=_titleArray[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(ListSelectView:didSelecteText:andIndex:)]) {
        [self.delegate ListSelectView:self didSelecteText:label.text andIndex:indexPath.row];
    }
    
    [self hiddenTableView];
}
#pragma mark  BtAction

- (void)btTapped:(UIButton*)bt{
    if (!_tableView.superview) {
        [self.superview addSubview:_tableView];
    }
    [self.superview bringSubviewToFront:_tableView];
    _tableView.hidden=!_tableView.isHidden;
//    [UIView animateWithDuration:0.2 animations:^{
//        if (_tableView.hidden) {
//            iam.transform = CGAffineTransformMakeRotation(M_PI*3/2);
//        } else {
//            iam.transform = CGAffineTransformMakeRotation(M_PI/2);
//        }
//    } completion:nil];
    
}
-(void)hiddenTableView{
    [UIView animateWithDuration:0.2 animations:^{
        _tableView.hidden=YES;
//        iam.transform = CGAffineTransformMakeRotation(M_PI*3/2);
    } completion:nil];
}


@end
