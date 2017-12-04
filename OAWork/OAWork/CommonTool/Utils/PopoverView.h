//
//  PopoverView.h
//  OAWork
//
//  Created by james on 2017/12/4.
//  Copyright © 2017年 james. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class PopoverView;

@protocol PopoverViewDelagate <NSObject>
- (void)didDismissNHPopover:(PopoverView *)popoverView ;
@optional

@end
@interface PopoverView : UIView
- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles;
- (id)initWithController:(UIViewController *)viewController contentSize:(CGSize)contentSize;

- (id)initWithController:(UIViewController *)viewController contentSize:(CGSize)contentSize autoClose:(BOOL)clickBgClose;

- (id)initWithView:(UIView *)view contentSize:(CGSize)contentSize autoClose:(BOOL)clickBgClose;
// 显示
- (void)show;

// 显示
- (void)showWithCloseBtn:(BOOL)showCloseBtn;

// 隐藏
- (void)dismiss;
@end
