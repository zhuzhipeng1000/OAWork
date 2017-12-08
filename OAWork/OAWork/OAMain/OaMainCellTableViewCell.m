//
//  OaMainCellTableViewCell.m
//  OAWork
//
//  Created by james on 2017/11/27.
//  Copyright © 2017年 james. All rights reserved.
//

#import "OaMainCellTableViewCell.h"

@implementation OaMainCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [_accessButton addTarget:self action:@selector(accessButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (void)accessButtonTapped:(UIButton*)bt{
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)layoutSubviews{
    
    
}

@end
