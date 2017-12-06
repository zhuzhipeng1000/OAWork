//
//  ITTPickView.m
//  ProductAduit
//
//  Created by james on 2017/4/21.
//  Copyright © 2017年 JIME. All rights reserved.
//

#import "ITTPickView.h"
#import "AppDelegate.h"
#define ITTToobarHeight 40
@interface ITTPickView ()

@property (nonatomic,strong) UIDatePicker *datePicker;//datePicker控件
@property (nonatomic,assign) NSInteger pickeviewHeight;//pickerView的高度
@property (nonatomic,strong) UIToolbar *toolbar;//toolBar控件
@property (nonatomic,copy) NSString *resultString;//返回的时间字符串
@property (nonatomic,assign) NSInteger selfOriginy;//当前view的frame.origin.y
@property (nonatomic,assign) NSInteger selfViewInitH;//初始状态view的frame.origin.y
@end
@implementation ITTPickView
//初始化ITTPickView，
- (instancetype)initDatePickWithDate:(NSDate *)defaulDate datePickerMode:(UIDatePickerMode)datePickerMode isHaveNavControler:(BOOL)isHaveNavControler {
    self = [super init];
    if (self) {
        self.defaulDate = defaulDate;
        [self setUpDatePickerWithdatePickerMode:datePickerMode];
        [self setFrameWith:isHaveNavControler];
        [self setUpToolBar];
    }
    return self;
}
//设定ITTPickView的frame大小
-(void)setFrameWith:(BOOL)isHaveNavControler {
    
    CGFloat toolViewX = 0;
    CGFloat toolViewH = self.pickeviewHeight + ITTToobarHeight;
    CGFloat toolViewY;
    if (isHaveNavControler) {
        toolViewY = [UIScreen mainScreen].bounds.size.height - toolViewH - 50;
    }else {
        toolViewY = [UIScreen mainScreen].bounds.size.height - toolViewH;
    }
    CGFloat toolViewW = [UIScreen mainScreen].bounds.size.width;
    CGFloat toolViewInitH = [UIScreen mainScreen].bounds.size.height;
    self.selfViewInitH = toolViewInitH;//初始状态view的frame.origin.y
    self.selfOriginy = toolViewY;//当前view的frame.origin.y
    self.frame = CGRectMake(toolViewX, toolViewInitH, toolViewW, toolViewH);
}
//设定datePicker控件的样式以及frame大小，并作为view的子视图
-(void)setUpDatePickerWithdatePickerMode:(UIDatePickerMode)datePickerMode {
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-CN"];
    datePicker.datePickerMode = datePickerMode;
    datePicker.backgroundColor = [UIColor whiteColor];
    if (self.defaulDate) {
        [datePicker setDate:self.defaulDate];
    }
    self.datePicker = datePicker;
    datePicker.frame = CGRectMake(0, ITTToobarHeight, [UIScreen mainScreen].bounds.size.width, datePicker.frame.size.height);
//     [datePicker addTarget : self action : @selector (datePickerValueChanged:) forControlEvents : UIControlEventValueChanged ];
    self.pickeviewHeight = datePicker.frame.size.height;
    [self addSubview:datePicker];
}
//设置toolBar的各个属性，并作为view的子视图
- (void)setUpToolBar {
    self.toolbar = [self setToolbarStyle];
    [self setToolbarWithPickViewFrame];
    [self addSubview:self.toolbar];
}
//设置toolBar的样式
-(UIToolbar *)setToolbarStyle {
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@" 取消 " style:UIBarButtonItemStylePlain target:self action:@selector(removeView)];
    UIBarButtonItem *centerSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@" 确定 " style:UIBarButtonItemStylePlain target:self action:@selector(doneClick)];
    toolbar.items = @[left, centerSpace, right];
    return toolbar;
}
//设定tooBar的frame大小
- (void)setToolbarWithPickViewFrame {
    self.toolbar.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, ITTToobarHeight);
}
//点击确定按钮
-(void)doneClick {
    if (self.datePicker) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd  hh:mm";
        self.resultString = [dateFormatter stringFromDate:self.datePicker.date];
    }
    if ([self.delegate respondsToSelector:@selector(toobarDonBtnHaveClick:resultString:)]) {
        [self.delegate toobarDonBtnHaveClick:self resultString:self.resultString];
    }
    [self removeView];
}
- ( void )datePickerValueChanged:( UIDatePicker *)datePicker{
    if ([self.delegate respondsToSelector:@selector(datePickerValueChanged:)]) {
        [self.delegate datePickerValueChanged:datePicker];
    }
}
/**
 * 从窗口移除本控件
 */
- (void)removeView {
    [UIView animateWithDuration:0.25f animations:^{
        self.frame = CGRectMake(self.frame.origin.x, self.selfViewInitH, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        if (finished) {
            self.hidden=YES;
        }
    }];
}
/**
 * 在窗口显示本控件
 */
- (void)showView {
    
    [[[AppDelegate shareAppDeleage].navi.viewControllers lastObject].view addSubview:self];
    
    [UIView animateWithDuration:0.25f animations:^{
        self.frame = CGRectMake(self.frame.origin.x, self.selfOriginy, self.frame.size.width, self.frame.size.height);
        self.hidden=NO;
    } completion:^(BOOL finished) {
        
    }];
}
-(void)setDefaulDate:(NSDate *)defaulDate{
    _defaulDate=defaulDate;
    [self.datePicker setDate:defaulDate];
    
}
-(void)dealloc{
    NSLog(@"iypick dealloc");
}
@end
