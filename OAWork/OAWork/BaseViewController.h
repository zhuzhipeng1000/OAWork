//
//  BaseViewController.h
//  OAWork
//
//  Created by james on 2017/11/24.
//  Copyright © 2017年 james. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "HostMangager.h"
#import "MyRequest.h"

@interface BaseViewController : UIViewController
@property (nonatomic,strong) MBProgressHUD *hud;
@end
