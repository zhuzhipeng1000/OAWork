//
//  MessageListCell.h
//  ProductAduit
//
//  Created by JIME on 2017/1/25.
//  Copyright © 2017年 JIME. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageListCell : UITableViewCell

@property (nonatomic,strong) UILabel *unreadLb;
@property (nonatomic,strong) UIImageView *headIcon;
@property (nonatomic,strong) UILabel *personNameLB;
@property (nonatomic,strong) UILabel *departmentNameLB;
@property (nonatomic,strong) UILabel *timeLB;
@property (nonatomic,strong) UILabel *titleLb;
@property (nonatomic,strong) NSDictionary *infoDic;



@end
