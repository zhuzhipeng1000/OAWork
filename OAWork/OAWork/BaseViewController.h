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
#import "Utils.h"
#import "User.h"
#import <RAlertView/RAlertView.h>
#import <Toast/Toast.h>

@interface BaseViewController : UIViewController
@property (nonatomic,strong) MBProgressHUD *hud;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIButton *backButton;
@property (nonatomic,strong) UIButton *messageButton;
@property (nonatomic,strong) UIView *barView;
-(void)hiddenLineView:(BOOL)hidden;
-(void)keyboardWasShown:(NSNotificationCenter*)notify;
-(void)keyboardWillBeHidden:(NSNotificationCenter*)notify;
- (UIView *)createNaviTopBarWithShowBackBtn:(BOOL)showBackBtn showTitle:(BOOL)showTitle;
-(void)baseBackAction;
@end
