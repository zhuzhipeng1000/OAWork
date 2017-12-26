//
//  OaMainCellTableViewCell.h
//  OAWork
//
//  Created by james on 2017/11/27.
//  Copyright © 2017年 james. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, OAStatueType) {
    OAStatueTypeNormal = 0,
    OAStatueTypeUrget ,
    
    OAStatueTypeProier
};
@interface OaMainCellTableViewCell : UITableViewCell
@property (strong, nonatomic)  UILabel *titleLB;
@property (strong, nonatomic)  UILabel *senderLB;
@property (strong, nonatomic)  UILabel *senderTitleLB;
@property (strong, nonatomic)  UILabel *curentLB;
@property (strong, nonatomic)  UILabel *currentTitleLB;
@property (strong, nonatomic)  UILabel *timeLB;
@property (strong, nonatomic)  UIImageView *headImage;
@property (strong, nonatomic)  UIButton *returnButton;
@property (strong, nonatomic)  UIButton *deleteButton;
@property (strong, nonatomic)  UIButton *seeDetailButton;
@property (nonatomic,assign) OAStatueType type;
@property (nonatomic,strong) UIView *backView;
@end
