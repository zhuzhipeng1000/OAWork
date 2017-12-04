//
//  NHPopoverViewController.h
//  bsl
//
//  Created by FanFrank on 14/11/3.
//
//

#import <UIKit/UIKit.h>

@class NHPopoverViewController;

@protocol NHPopoverViewControllerDelegate <NSObject>

@optional
/**
 * 点击背景或关闭按钮时关闭Popover时调用
 * 调用dismiss方法关闭Popover时不调用
 */
- (void)didDismissNHPopover:(NHPopoverViewController *)popoverController;

@end

@interface NHPopoverViewController : UIView
{
    CGSize constrainedSize;
    BOOL _isClickBgClose;
}


@property (nonatomic, retain, readonly) UIView *background;
@property (nonatomic, assign) id<NHPopoverViewControllerDelegate> delegate;
@property (nonatomic,retain) UIWindow* lastWindow;//弹出页面的WINDOW
@property (nonatomic, copy) void(^dissmissBlock)();
- (id)initWithController:(UIViewController *)viewController contentSize:(CGSize)contentSize;

- (id)initWithController:(UIViewController *)viewController contentSize:(CGSize)contentSize autoClose:(BOOL)clickBgClose;

- (id)initWithView:(UIView *)view contentSize:(CGSize)contentSize autoClose:(BOOL)clickBgClose;

// 显示
- (void)show;

// 显示
- (void)showWithCloseBtn:(BOOL)showCloseBtn;

// 隐藏
- (void)dismiss;

//隐藏但不释放
-(void)hiddeWindow;
//从隐藏状态重新显示
-(void)showFromHidden;
@end
