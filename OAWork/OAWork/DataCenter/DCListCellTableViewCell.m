//
//  DCListCellTableViewCell.m
//  OAWork
//
//  Created by james on 2017/12/8.
//  Copyright © 2017年 james. All rights reserved.
//

#import "DCListCellTableViewCell.h"
#import "Utils.h"
@interface DCListCellTableViewCell()
@end
@implementation DCListCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _rightView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        [self.contentView addSubview:_rightView];
        _selectImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 18, 17, 17)];
        _selectImageView.userInteractionEnabled=YES;
        [_selectImageView setImage:[UIImage imageNamed:@"weixuanzhe"]];
        [self.contentView addSubview:_selectImageView];
    
        _selectBt=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 55, 50)];
        _selectBt.backgroundColor=[UIColor clearColor];
        [_selectBt addTarget:self action:@selector(btTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_selectBt];
     
        _isAddInto=NO;
        _isStartEdit=NO;
        
        self.headIcon=[[UIImageView alloc]initWithFrame:CGRectMake(12, 10, 20, 20)];
        [_rightView addSubview:self.headIcon];
        
        self.titleLB=[[UILabel alloc]initWithFrame:CGRectMake(self.headIcon.right+10, self.headIcon.top,_rightView.width-self.headIcon.right-30, self.headIcon.height)];
        self.titleLB.backgroundColor=[UIColor whiteColor];
        self.titleLB.font=[UIFont systemFontOfSize:14.0f];
        self.titleLB.textColor=[Utils colorWithHexString:@"#363636"];
        [_rightView addSubview:self.titleLB];
        
        _accessImage=[[UIImageView alloc]initWithFrame:CGRectMake(self.titleLB.right, 18, 20, 14)];
        
        [_accessImage setImage:[UIImage imageNamed:@"arrow_down"]];
        [_rightView addSubview:_accessImage];
        _accessImage.transform=CGAffineTransformMakeRotation((M_PI_2*3));// 像右往左转
        _accessImage.transform=CGAffineTransformScale(_accessImage.transform, 0.5, 0.5);
        
        _accessButton=[[UIButton alloc]initWithFrame:CGRectMake(self.titleLB.right-10,0, _rightView.height, 50)];
        _accessButton.backgroundColor=[UIColor clearColor];
        
        [_accessButton addTarget:self action:@selector(_accessButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [_rightView addSubview:_accessButton];
        
    }
    
    return self;
}
-(void)btTapped:(UIButton*)bt{
    _isAddInto=!_isAddInto;
    
    if ([self.delegate respondsToSelector:@selector(dic:isSelected:)]) {
        [self.delegate dic:_infoDic isSelected:_isAddInto];
    }
    if (_isAddInto) {
        [_selectImageView setImage:[UIImage imageNamed:@"xuanzhe"]];
    }else{
        [_selectImageView setImage:[UIImage imageNamed:@"weixuanzhe"]];
    }
}
-(void)setIsAddInto:(BOOL)isAddInto{
    _isAddInto=isAddInto;
    if (_isAddInto) {
        [_selectImageView setImage:[UIImage imageNamed:@"xuanzhe"]];
    }else{
        [_selectImageView setImage:[UIImage imageNamed:@"weixuanzhe"]];
    }
}
-(void)_accessButton:(UIButton*)bt{
    if (_isStartEdit>0) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(accessBTtapped:onCell:)]) {
        [self.delegate accessBTtapped:bt onCell:self];
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)layoutSubviews{
    if (_isStartEdit>0) {
        _selectBt.hidden=NO;
        _selectImageView.hidden=NO;
    }else{

        _selectBt.hidden=YES;
        _selectImageView.hidden=YES;
    }
    
    if (_isAddInto) {
        [_selectImageView setImage:[UIImage imageNamed:@"xuanzhe"]];
    }else{
        [_selectImageView setImage:[UIImage imageNamed:@"weixuanzhe"]];
    }
    _rightView.frame=CGRectMake(_isStartEdit, 0, SCREEN_WIDTH, 55);
    
    
}
- (UITableView *)viewControllerOfView:(UIView*) Aview{
    for (UIView* next = [Aview superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UITableView class]]) {
            return (UITableView *)nextResponder;
        }
    }
    return nil;
}

-(void)didiSelextNames:(NSMutableArray*)names{
    
    
}

@end
