//
//  NeedDoViewController.h
//  OAWork
//
//  Created by james on 2017/11/30.
//  Copyright © 2017年 james. All rights reserved.
//

#import "BaseViewController.h"

@interface NeedDoViewController : BaseViewController
@property (nonatomic,strong) UITableView *demoTableView;
@property (nonatomic,strong) NSDictionary *needDoDic;
@property (nonatomic,strong) NSArray *selectedFiles;
@end
