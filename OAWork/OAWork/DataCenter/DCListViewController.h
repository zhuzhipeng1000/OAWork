//
//  DCListViewController.h
//  OAWork
//
//  Created by james on 2017/12/7.
//  Copyright © 2017年 james. All rights reserved.
//

#import "BaseViewController.h"
typedef NS_ENUM(NSInteger, DCListType) {
    DCListOrder =0,
    DCListSave ,
    DCListRecommend,
};
@interface DCListViewController : BaseViewController
@property (nonatomic,assign) DCListType type;
@end
