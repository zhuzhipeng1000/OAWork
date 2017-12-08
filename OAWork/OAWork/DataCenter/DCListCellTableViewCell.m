//
//  DCListCellTableViewCell.m
//  OAWork
//
//  Created by james on 2017/12/8.
//  Copyright © 2017年 james. All rights reserved.
//

#import "DCListCellTableViewCell.h"

@implementation DCListCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _rightView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 55)];
        [self.contentView addSubview:_rightView];
        _selectImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 18, 17, 17)];
        _selectImageView.userInteractionEnabled=YES;
        [_selectImageView setImage:[UIImage imageNamed:@"project_unselected"]];
        [self.contentView addSubview:_selectImageView];
    
        _selectBt=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 55, 55)];
        _selectBt.backgroundColor=[UIColor clearColor];
        [_selectBt addTarget:self action:@selector(btTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_selectBt];
     
        _isAddInto=NO;
        _isStartEdit=NO;
        
        self.headIcon=[[UIImageView alloc]initWithFrame:CGRectMake(12, 10, 35, 35)];
        [_rightView addSubview:self.headIcon];
        
        self.titleLB=[[UILabel alloc]initWithFrame:CGRectMake(self.headIcon.right+10, self.headIcon.top,_rightView.width-self.headIcon.right-50, 20)];
        self.titleLB.backgroundColor=[UIColor whiteColor];
        self.titleLB.font=[UIFont systemFontOfSize:14.0f];
        self.titleLB.textColor=[UIColor blackColor];
        [_rightView addSubview:self.titleLB];
        
        _accessImage=[[UIImageView alloc]initWithFrame:CGRectMake(self.titleLB.right, 18, 20, 14)];
        
        [_accessImage setImage:[UIImage imageNamed:@"arrow_down"]];
        [_rightView addSubview:_accessImage];
        
        _accessButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, _rightView.height, 55)];
        _accessButton.backgroundColor=[UIColor clearColor];
        
        [_accessButton addTarget:self action:@selector(_accessButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [_rightView addSubview:_selectBt];
        
    }
    
    return self;
}
-(void)btTapped:(UIButton*)bt{
    _isAddInto=!_isAddInto;
    
    if ([self.delegate respondsToSelector:@selector(dic:isSelected:)]) {
        [self.delegate dic:_infoDic isSelected:_isAddInto];
    }
    if (_isAddInto) {
        [_selectImageView setImage:[UIImage imageNamed:@"project_didselected"]];
    }else{
        [_selectImageView setImage:[UIImage imageNamed:@"project_unselected"]];
    }
}
-(void)setIsAddInto:(BOOL)isAddInto{
    _isAddInto=isAddInto;
    if (_isAddInto) {
        [_selectImageView setImage:[UIImage imageNamed:@"project_didselected"]];
    }else{
        [_selectImageView setImage:[UIImage imageNamed:@"project_unselected"]];
    }
}
-(void)_accessButton:(UIButton*)bt{
    
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
        [_selectImageView setImage:[UIImage imageNamed:@"project_didselected"]];
    }else{
        [_selectImageView setImage:[UIImage imageNamed:@"project_unselected"]];
    }
    _rightView.frame=CGRectMake(_isStartEdit, 0, SCREEN_WIDTH, 55);
    
    
}

@end
