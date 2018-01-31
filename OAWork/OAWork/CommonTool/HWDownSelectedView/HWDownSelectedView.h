//
//  HWDownSelectedView.h
//  HWDownSelectedTF
//
//  Created by HanWei on 15/12/15.
//  Copyright © 2015年 AndLiSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,HWDownType) {
    HWDownTypeCanEdit =0,         // slow at beginning and end
    HWDownTypeNoEdit,
};
@class HWDownSelectedView;
@protocol HWDownSelectedViewDelegate <NSObject>

@required
- (void)downSelectedView:(HWDownSelectedView *)selectedView didSelectedAtIndex:(NSIndexPath *)indexPath;
-(void)downSelectedView:(UIView *)aView WillShow:(BOOL)show orClose:(BOOL)close;
@end

@interface HWDownSelectedView : UIView

@property (nonatomic, weak) id <HWDownSelectedViewDelegate> delegate;
@property (nonatomic, strong) NSArray<NSString *> *listArray;

/// 一些控件属性
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, assign) NSTextAlignment textAlignment;
@property (nonatomic, copy) NSString *placeholder;

@property (nonatomic, copy, readonly) NSString *text;
@property (nonatomic,assign) HWDownType type;
@property (nonatomic,assign) NSInteger currentIndex;

- (void)show;
- (void)close;

@end

