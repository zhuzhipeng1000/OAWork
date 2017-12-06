//
//  ITTPickView.h
//  ProductAduit
//
//  Created by james on 2017/4/21.
//  Copyright © 2017年 JIME. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ITTPickView;
@protocol ITTPickViewDelegate <NSObject>
@optional
-(void)toobarDonBtnHaveClick:(ITTPickView *)pickView
                resultString:(NSString *)resultString;
- ( void )datePickerValueChanged:( UIDatePicker *)datePicker;
@end
@interface ITTPickView : UIView
@property (nonatomic,weak) UILabel *textView;//选择日期后用用显示的
@property(nonatomic,weak) id<ITTPickViewDelegate> delegate;//委托
/**
 * 通过时间创建一个DatePicker
 *

 *
 * @return 带有toolbar的datePicker
 */
-(instancetype)initDatePickWithDate:(NSDate *)defaulDate
                     datePickerMode:(UIDatePickerMode)datePickerMode
                 isHaveNavControler:(BOOL)isHaveNavControler;
/**
 * 从窗口移除本控件
 */
-(void)removeView;
/**
 * 在窗口显示本控件
 */
-(void)showView;

@end

