//
//  DCListCellTableViewCell.h
//  OAWork
//
//  Created by james on 2017/12/8.
//  Copyright © 2017年 james. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DCListCellTableViewCell;
@protocol DCListCellTableViewCellDelegate<NSObject>
- (void)dic:(NSDictionary*)dic isSelected:(BOOL) isSelected;
@end
@interface DCListCellTableViewCell : UITableViewCell
@property (nonatomic,strong) UIView *rightView;
@property (strong, nonatomic)  UILabel *titleLB;
@property (nonatomic,strong) UIImageView *headIcon;
@property (strong, nonatomic)  UIImageView *accessImage;
@property (strong, nonatomic)  UIButton *accessButton;
@property (nonatomic,assign) int isStartEdit;
@property (nonatomic,assign) BOOL isAddInto;
@property (nonatomic,strong) NSDictionary *infoDic;
@property (nonatomic,strong)  UIButton *selectBt;
@property (nonatomic,strong)  UIImageView *selectImageView;
@property (nonatomic,weak) id delegate;
@end
