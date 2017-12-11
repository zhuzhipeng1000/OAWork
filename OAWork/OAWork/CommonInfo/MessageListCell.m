//
//  MessageListCell.m
//  ProductAduit
//
//  Created by JIME on 2017/1/25.
//  Copyright © 2017年 JIME. All rights reserved.
//

#import "MessageListCell.h"
#import "Utils.h"

@implementation MessageListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      
        UIView*lineview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,1)];
        lineview.backgroundColor=[Utils colorWithHexString:@"#e4e4e4"];
        [self.contentView addSubview:lineview];
        
        
        self.headIcon=[[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 80, 80)];
        [self.contentView addSubview:self.headIcon];
        
        self.titleLb=[[UILabel alloc]initWithFrame:CGRectMake(self.headIcon.right+10, self.headIcon.top,SCREEN_WIDTH-self.headIcon.right+10, 50)];//给宽110
        self.titleLb.backgroundColor=[UIColor whiteColor];
        self.titleLb.font=[UIFont systemFontOfSize:14.0f];
        self.titleLb.numberOfLines=0;
        self.titleLb.lineBreakMode=NSLineBreakByWordWrapping;
        self.titleLb.textColor=[UIColor blackColor];
        [self.contentView addSubview:self.titleLb];
        
       
        
        self.personNameLB=[[UILabel alloc]initWithFrame:CGRectMake(self.titleLb.left, self.titleLb.bottom,self.titleLb.width, 20)];
        self.personNameLB.backgroundColor=[UIColor whiteColor];
        self.personNameLB.font=[UIFont systemFontOfSize:14.0f];
        self.personNameLB.textColor=[UIColor blackColor];
        [self.contentView addSubview:self.personNameLB];
        
        self.departmentNameLB=[[UILabel alloc]initWithFrame:CGRectMake(self.personNameLB.left, self.personNameLB.bottom,self.titleLb.width, 20)];
        self.departmentNameLB.backgroundColor=[UIColor whiteColor];
        self.departmentNameLB.textAlignment=NSTextAlignmentLeft;
        self.departmentNameLB.textColor=[Utils colorWithHexString:@"#636363"];
        [self.contentView  addSubview:self.departmentNameLB];
    
        
        self.timeLB=[[UILabel alloc]initWithFrame:CGRectMake(self.departmentNameLB.left, self.departmentNameLB.bottom, self.titleLb.width-60, 20)];
        self.timeLB.backgroundColor=[UIColor whiteColor];
        self.timeLB.textAlignment=NSTextAlignmentLeft;
        self.timeLB.font=[UIFont systemFontOfSize:14.0f];
        self.timeLB.textColor=[Utils colorWithHexString:@"#636363"];
        [self.contentView  addSubview:self.timeLB];
        
       
        
        self.unreadLb=[[UILabel alloc]initWithFrame:CGRectMake(self.timeLB.right, self.timeLB.top, 50,self.timeLB.height)];
        self.unreadLb.backgroundColor=[Utils colorWithHexString:@"#f26522"];
        self.unreadLb.layer.cornerRadius=3.5;
        self.unreadLb.font=[UIFont systemFontOfSize:14.0f];
        self.unreadLb.clipsToBounds=YES;
        [self.contentView addSubview:self.unreadLb];


    }
    
    return self;
}

- (void)layoutSubviews{
    
    if ([[_infoDic allKeys] containsObject:@"readStatus"]) {
        _unreadLb.text=@"已读";
    }else{
        _unreadLb.text=@"未读";
    }


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
