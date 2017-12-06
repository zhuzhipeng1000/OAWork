//
//  ListSelectView.m
//  ProductAduit
//
//  Created by JIME on 2017/1/19.
//  Copyright © 2017年 JIME. All rights reserved.
//

#import "ListSelectView.h"
#import "UIView+Utils.h"

@interface ListSelectView()<UITableViewDelegate,UITableViewDataSource>{
    UIImageView *iam;
//    UILabel *label;
//    UITextField *tf;
//    UIButton *bt;
    CGRect aFrame;
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
- (instancetype)initWithSize:(CGSize)size OfViewPoint:(UIView*)aView onView:(UIView*)onView{
    
    self=[super init];
    if (self) {
        self.userInteractionEnabled=YES;
     
        UIView *aSupperView;
        if (onView) {
            aSupperView=onView;
        }else{
             UIViewController  *a= [self viewControllerOfView:aView];
            aSupperView=a.view;
        }
        CGPoint convertpoint=[aView convertPoint:CGPointZero toView:aSupperView ];
        self.frame=CGRectMake(convertpoint.x, convertpoint.y,size.width, size.height);
        [aSupperView addSubview:self];
//        label=[[UILabel alloc]initWithFrame:CGRectMake(5, 0,frame.size.width-10 , frame.size.height)];
////        label.adjustsFontSizeToFitWidth=YES;
//        label.font=[UIFont systemFontOfSize:15.0f];
//        label.textColor=[UIColor blackColor];
//        label.textAlignment=NSTextAlignmentLeft;
//        [self addSubview:label];
        
//        tf=[[UITextField alloc]initWithFrame:label.frame];
//        tf.font=[UIFont systemFontOfSize:15.0f];
//        tf.textColor=[UIColor blackColor];
//        tf.textAlignment=NSTextAlignmentLeft;
//        [self addSubview:tf];
        
        
//        iam=[[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width-10,(frame.size.height-5)/2, 8, 5)];
//        iam.image=[UIImage imageNamed:@"arrow_down"];
//        iam.transform = CGAffineTransformMakeRotation(M_PI/2);
//        [self addSubview:iam];
//
//       bt=[[UIButton alloc]initWithFrame:CGRectMake(5, 0,frame.size.width , frame.size.height)];
//        [self addSubview:bt];
//        bt.backgroundColor=[UIColor clearColor];
//        [bt  addTarget:self action:@selector(btTapped:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return self;
}
-(void)showSize:(CGSize)size OfViewPoint:(UIView*)aView onView:(UIView*)onView{
   
    UIView *aSupperView;
    if (onView) {
        aSupperView=onView;
    }else{
        UIViewController  *a= [self viewControllerOfView:aView];
        aSupperView=a.view;
    }
    CGPoint convertpoint=[aView convertPoint:CGPointZero toView:aSupperView ];
    self.frame=CGRectMake(convertpoint.x, convertpoint.y,size.width, size.height);
    if (self.superview != aSupperView) {
        [self removeFromSuperview];
    }else{
        [aSupperView bringSubviewToFront:self];
    }
    
}
- (void)setTitleArray:(NSArray *)titleArray{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:self.bounds];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.hidden=YES;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        [self addSubview:_tableView];
    }
    [self.superview bringSubviewToFront:self];
    [self bringSubviewToFront:_tableView];
    _tableView.frame=self.bounds;
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
        aLabel.textAlignment=NSTextAlignmentLeft;
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
    _labelField.text=_titleArray[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(ListSelectView:didSelecteText:andIndex:)]) {
        [self.delegate ListSelectView:self didSelecteText:_labelField.text andIndex:indexPath.row];
    }
    
    [self hiddenTableView];
}
#pragma mark  BtAction

- (void)btTapped:(UIButton*)bt{
    if (!_tableView.superview) {
        [self.superview addSubview:_tableView];
    }
    if (self.superview.superview.superview) {
        self.superview.superview.superview.userInteractionEnabled=YES;
        [self.superview.superview.superview bringSubviewToFront:self.superview.superview];
    }
    if (self.superview.superview) {
          self.superview.superview.userInteractionEnabled=YES;
        [self.superview.superview bringSubviewToFront:self.superview];
    }
    if (self.superview) {
        self.superview.userInteractionEnabled=YES;
        [self.superview bringSubviewToFront:self];
    }
    [self bringSubviewToFront:_tableView];
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
-(void)layoutSubviews{
    
    [super layoutSubviews];
    
//    if ([_titleArray isKindOfClass:[NSArray class]]&&_titleArray.count>0) {
//        _labelField.text=_titleArray[0];
//    }
//
//
//    if (self.listViewType==ListViewTextField) {
//        label.hidden=true;
//        tf.hidden=false;
//        bt.frame= CGRectMake(self.frame.size.width-self.frame.size.height, 0,self.frame.size.height , self.frame.size.height);
//
//    }else {
//        label.hidden=false;
//        tf.hidden=YES;
//        bt.frame= CGRectMake(5, 0,self.frame.size.width , self.frame.size.height);
//
//    }
}
- (UIViewController *)viewControllerOfView:(UIView*) Aview{
    for (UIView* next = [Aview superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


@end
