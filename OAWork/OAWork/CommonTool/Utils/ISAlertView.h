//
//  ISAlertView.h
//  CustomAlertView
//
//  Created by issuser_czp on 13-6-8.
//  Copyright (c) 2013年 issuser_czp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JCAlertController;


@protocol ISAlertViewDelegate <NSObject>

- (void)isAlertView:(UIView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;

@optional

- (void)isAlertView:(UIView *)alertView didCheckBoxStatus:(BOOL)status;

@end

typedef void(^clickHandleWithIndex)(NSInteger index);

@interface ISAlertView : UIView
{
    UIButton *mbutton;
    float constrainedWidth;
    float constrainedHeight;
    CGSize constrainedSize;
    BOOL isFirstLayOut;
    BOOL hasCheckBox;
}


@property (nonatomic, weak) id<ISAlertViewDelegate>delegate;
@property (nonatomic, strong) JCAlertController *jcAlertView;
@property (nonatomic, copy) clickHandleWithIndex clickHandle;

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)mdelegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles;
- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles clickHandleWithIndex:(clickHandleWithIndex)clickHandle;

/**
 *带有勾选框的
 */
-(id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)mdelegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles hasCheckBox:(BOOL)isHas;
-(void)show;
- (void)dismiss:(void(^)())success;

-(void)layoutViews;

@end
