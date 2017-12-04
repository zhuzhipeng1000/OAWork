//
//  ISAlertView.m
//  CustomAlertView
//
//  Created by issuser_czp on 13-6-8.
//  Copyright (c) 2013年 issuser_czp. All rights reserved.
//

#import "ISAlertView.h"
#import "Utils.h"
#import "ThemeManager.h"


#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>
#import <JCAlertController/JCAlertController.h>


#define TITLE_FONT 22.0
#define MESSAGE_FONT 17.0
#define PORTRAIT_CONSTRAINED_WIDTH 280.0
#define PORTRAIT_CONSTRAINED_HEIGHT 450.0
#define LANDSCAPE_CONSTRAINED_WIDTH 280.0
#define LANDSCAPE_CONSTRAINED_HEIGHT 450.0
#define BUTTONHEIGHT 46.0
#define BUTTONWIDTH 116.0

#define kHorMargin 15.0
#define kVerMargin 10.0
#define BUTTONGAP 10.0
#define BUTTON_BACKGROUNDIMAGE @"static.png"
#define BUTTON_BACKGROUNDIMAGE_1 @"static.png"
#define isLandscapeLeft [UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeLeft
#define isLandscapeRight [UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeRight
#define isPortraitUp [UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationPortraitUpsideDown
#define isPortraitDown [UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationPortrait

@interface ISAlertView ()

@property (nonatomic, retain) UIView *background;
@property (nonatomic, retain) UIView *textBackground;

@property (nonatomic, retain) UILabel *titleText;
@property (nonatomic, retain) UILabel *messageText;
@property (nonatomic, retain) UIScrollView *messageScrollView;
@property (nonatomic, retain) NSMutableArray *buttonArray;
@property (nonatomic, retain) NSArray *btnNameArray;
@property (nonatomic, retain) UIButton *checkBoxBtn;
@property (nonatomic, retain) UILabel *checkText;
@property (nonatomic, assign) BOOL isShowJCAlertViewBG;//是否JCAlertView 默认背景

@end

@implementation ISAlertView
@synthesize background = _background;
@synthesize textBackground = _textBackground;
@synthesize titleText = _titleText;
@synthesize messageText = _messageText;
@synthesize buttonArray = _buttonArray;
@synthesize messageScrollView = _messageScrollView;
@synthesize checkBoxBtn = _checkBoxBtn;
@synthesize checkText = _checkText;
@synthesize btnNameArray;

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles clickHandleWithIndex:(clickHandleWithIndex)clickHandle{
    self = [self initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles];
    self.clickHandle = clickHandle;
    return self;
}

-(id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)mdelegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles
{
    if(self = [self init])
    {
        _buttonArray = [[NSMutableArray alloc] init];
        
        self.delegate = mdelegate;
        self.btnNameArray = otherButtonTitles;
        isFirstLayOut = YES;
        
        self.frame = [UIScreen mainScreen].bounds;
        [self addBackground];
        [self addTitleText:title];
        [self addMessageText:message];
        [self addButtonWithCancelTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles];
        
    }
    return self;
}

-(id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)mdelegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles hasCheckBox:(BOOL)isHas
{
    if(self = [self init])
    {
        _buttonArray = [[NSMutableArray alloc] init];
        
        self.delegate = mdelegate;
        self.btnNameArray = otherButtonTitles;
        isFirstLayOut = YES;
        hasCheckBox = YES;
        
        self.frame = [UIScreen mainScreen].bounds;
        [self addBackground];
        [self addTitleText:title];
        [self addMessageText:message];
        if(hasCheckBox)
        {
            [self addCheckBox];
        }
        [self addButtonWithCancelTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles];
    }
    return self;
}
- (instancetype)init{
    self = [super init];
    return self;
}
-(void)dealloc
{
    self.buttonArray = nil;
    self.delegate = nil;
    self.btnNameArray = nil;
    self.jcAlertView = nil;
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    NSLog(@"ISALertView dealloc");
}

-(void)show
{
    [self layoutViews];
    if (!self.jcAlertView) {
        self.jcAlertView = [JCAlertController alertWithTitle:@"" contentView:self];
        
    }
   
}

-(void)addBackground
{
    _background = [[UIView alloc] init];
    _background.layer.backgroundColor = [ThemeColor(kAlertBgColor) CGColor];
    _background.layer.cornerRadius = 5.0;
    _background.clipsToBounds = YES;
    [self addSubview:_background];
    
    
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, PORTRAIT_CONSTRAINED_WIDTH, 44)];
//    imageView.backgroundColor = ThemeColor(kAlertBgColor);
//
//    [_background addSubview:imageView];
//    [imageView release];

    _textBackground = [[UIView alloc] init];
    _textBackground.layer.backgroundColor = ThemeColor(kAlertSplitColor).CGColor;
    if(_titleText){//当没有标题试 不设置分割线
        [_textBackground setHidden:NO];
    }else{
        [_textBackground setHidden:YES];
    }
    [_background addSubview:_textBackground];

}

-(void)addTitleText:(NSString *)title
{
    if (title)
    {
        
        _titleText = [[UILabel alloc] init];
        _titleText.backgroundColor = [UIColor clearColor];
        _titleText.font = [UIFont systemFontOfSize:TITLE_FONT];
        _titleText.textColor = ThemeColor(kAlertTitleColor);
        _titleText.text = title;
        _titleText.textAlignment = NSTextAlignmentCenter;
        _titleText.numberOfLines = 0;
        _titleText.lineBreakMode = NSLineBreakByWordWrapping;
        [_background addSubview:_titleText];
        if(_textBackground){//当没有标题试 不设置分割线
            [_textBackground setHidden:NO];
        }
            
    }else{
        if(_textBackground)
            [_textBackground setHidden:YES];
    }
}

-(void)addMessageText:(NSString *)message
{
    if (!message)
    {
        message = @"";
    }
    _messageScrollView = [[UIScrollView alloc] init];
    _messageScrollView.backgroundColor = [UIColor clearColor];
    _messageScrollView.bounces = NO;
    [_background addSubview:_messageScrollView];
//   [_messageScrollView release];
    
    _messageText = [[UILabel alloc] init];
    _messageText.backgroundColor = [UIColor clearColor];
    _messageText.font = [UIFont systemFontOfSize:MESSAGE_FONT];
    _messageText.textColor = ThemeColor(kAlertContentColor);
    _messageText.text = message;
    
    _messageText.textAlignment = NSTextAlignmentLeft;
    _messageText.lineBreakMode = NSLineBreakByWordWrapping;
    _messageText.numberOfLines = 0;
    [_messageScrollView addSubview:_messageText];
//    [_messageText release];
}

- (void)addCheckBox
{
    _checkText = [[UILabel alloc]init];
    _checkText.backgroundColor = [UIColor clearColor];
    _checkText.font = [UIFont systemFontOfSize:MESSAGE_FONT];
    _checkText.textColor = [UIColor whiteColor];
    _checkText.text = @"不再提示";
    _checkText.textAlignment = NSTextAlignmentLeft;
    _checkText.textColor = ThemeColor(kAlertCheckboxTitleColor);
    _checkText.numberOfLines = 0;
    _checkText.lineBreakMode = NSLineBreakByWordWrapping;
    [_background addSubview:_checkText];
//    [_checkText release];
    
    _checkBoxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_checkBoxBtn setImage:[UIImage imageNamed:@"bnt34_2.png"] forState:UIControlStateNormal];
    [_checkBoxBtn setImage:[UIImage imageNamed:@"bnt34_1.png"] forState:UIControlStateSelected];
    [_checkBoxBtn setImage:[UIImage imageNamed:@"bnt34_3.png"] forState:UIControlStateHighlighted];
    [_checkBoxBtn addTarget:self action:@selector(checkClick:) forControlEvents:UIControlEventTouchUpInside];
    [_background addSubview:_checkBoxBtn];

}

- (void)addButtonWithCancelTitle:(NSString *)cancel otherButtonTitles:(NSArray *)btns
{
    NSMutableArray *btnNames = [NSMutableArray array];
    if((cancel || [cancel isEqualToString:@""]))
    {
         [btnNames addObject:cancel];
    }
    if ([btns isKindOfClass:[NSArray class]]){
        [btnNames addObjectsFromArray:btns];
    }
    for (int i=0; i<btnNames.count; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *buttonTitle = [btnNames objectAtIndex:i];
        if (![buttonTitle isKindOfClass:[NSString class]]){
            buttonTitle = @"";
        }
        [button setTitle:buttonTitle forState:UIControlStateNormal];
        [button setTitleColor:ThemeColor(kAlertBtnColor) forState:UIControlStateNormal];
        [button setTitleColor:ThemeColor(kAlertBtnSelectColor) forState:UIControlStateHighlighted];
        [button setBackgroundImage:[Utils createImageWithColor:ThemeColor(kAlertBtnBgSelectColor)] forState:UIControlStateHighlighted];
        
        button.clipsToBounds = YES;
        button.layer.borderColor = ThemeColor(kAlertSplitColor).CGColor;
        button.layer.borderWidth = 1.0;

        [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [_background addSubview:button];
        [_buttonArray addObject:button];
    }
}

- (void)dismiss:(void(^)())success
{
    [_jcAlertView dismissViewControllerAnimated:YES completion:^{
        if (success) {
            success();
        }
    }];
//    [_jcAlertView dismissWithCompletion:^{
//        if (success) {
//            success();
//        }
//    }];
}


-(void)onClick:(id)sender
{
    __weak ISAlertView *weakSelf = self;
    [self dismiss:^{
        UIButton *button = (UIButton *)sender;
        long tag = button.tag;
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(isAlertView:didDismissWithButtonIndex:)])
        {
            [weakSelf.delegate isAlertView:weakSelf didDismissWithButtonIndex:tag];
        }
        
        if (weakSelf.clickHandle) {
            weakSelf.clickHandle(tag);
        }
    }];
}

- (void)checkClick:(id)sender
{
    _checkBoxBtn.selected = !_checkBoxBtn.selected;
    if([self.delegate respondsToSelector:@selector(isAlertView:didCheckBoxStatus:)])
    {
        [self.delegate isAlertView:self didCheckBoxStatus:_checkBoxBtn.selected];
    }
}

-(CGRect)titleRect
{
    CGSize titleSize = [self sizeLabel:_titleText size:constrainedSize];
    CGRect titleRect = CGRectMake(kHorMargin, kVerMargin, constrainedWidth-2*kHorMargin, titleSize.height);
    return titleRect;
}

-(CGRect)messageRect
{
    CGSize messageConstrainedToSize = CGSizeMake(constrainedSize.width-2*kHorMargin, constrainedSize.height);
    CGSize messageSize = [self sizeLabel:_messageText size:messageConstrainedToSize];
    CGRect messageRect = CGRectMake(kHorMargin, _titleText.frame.origin.y+_titleText.frame.size.height+kHorMargin, constrainedWidth-2*kHorMargin, messageSize.height);
    
    if (messageRect.size.height < 50) // 内容高度最少50 fanlanjun 14/11/12
        messageRect.size.height = 50;
    
    return messageRect;
}

- (void)checkBoxRect
{
    CGRect boxRect = CGRectMake(0, _messageScrollView.frame.origin.y + _messageScrollView.frame.size.height - 16 + 20,60, 50);
    [_checkBoxBtn setFrame:boxRect];
    _checkText.frame = CGRectMake(CGRectGetMaxX(boxRect)-10, _messageScrollView.frame.origin.y + _messageScrollView.frame.size.height + 20, 100, 17);
    
}

/**
 计算Label 内容大小

 @param labelView 需要计算内容的控件
 @param size 计算大小范围
 @return 返回计算后的大小
 */
-(CGSize) sizeLabel:(UILabel *) labelView size:(CGSize) size{
    CGSize newSize = CGSizeZero;
    if(labelView != nil && [labelView isKindOfClass:[UILabel class]]){
       //如果是IOS7以后调用该方法计算
            NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:labelView.text attributes:@{NSFontAttributeName: labelView.font}];
            CGRect rect = [attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:nil];
            newSize = rect.size;
            
        
    }
    
    return newSize;
}

-(float)backgroundHeight
{
    float backgoundHeight = 0;
    CGRect scrollviewFrame = _messageScrollView.frame;
    if(hasCheckBox)
    {
        scrollviewFrame = _checkText.frame;
    }
    if (_buttonArray.count <= 2)
    {
        if (_buttonArray.count == 1)
        {
            CGRect buttonRect = CGRectMake(0, scrollviewFrame.origin.y+scrollviewFrame.size.height+20, constrainedWidth, BUTTONHEIGHT);
            UIButton *button = [_buttonArray objectAtIndex:0];
            button.frame = buttonRect;
            backgoundHeight = button.frame.origin.y+button.frame.size.height;
        }
        else
        {
            float btnWidth = constrainedWidth/2.0f;
            for (int i=0; i<_buttonArray.count; i++)
            {
                
                CGRect buttonRect = CGRectMake(i*btnWidth, scrollviewFrame.origin.y+scrollviewFrame.size.height+20, btnWidth+1, BUTTONHEIGHT);
                UIButton *button = [_buttonArray objectAtIndex:i];
                button.frame = buttonRect;
                if (i==_buttonArray.count - 1)
                {
                    backgoundHeight = button.frame.origin.y+button.frame.size.height;
                }
            }

        }
        
    }
    else if(_buttonArray.count >2)
    {
        for (int i=0; i<_buttonArray.count; i++)
        {
            //int buttonWidth = constrainedWidth-2*kHorMargin;
            int orginY = scrollviewFrame.origin.y+scrollviewFrame.size.height;
            CGRect buttonRect = CGRectMake(0, orginY+(BUTTONHEIGHT-1)*i+20, constrainedWidth, BUTTONHEIGHT);
            UIButton *button = [_buttonArray objectAtIndex:i];
            button.frame = buttonRect;
            if (i==_buttonArray.count - 1)
            {
                backgoundHeight = button.frame.origin.y+button.frame.size.height;
            }
        }
    }
    return backgoundHeight;
}


-(void)layoutViews
{
    float screenWidth  = 0.0;
    float screenHeight = 0.0;
    if (isLandscapeLeft || isLandscapeRight)
    {
        constrainedHeight = LANDSCAPE_CONSTRAINED_HEIGHT;
        constrainedWidth  = LANDSCAPE_CONSTRAINED_WIDTH;
        screenHeight      = CGRectGetWidth([UIScreen mainScreen].bounds);
        screenWidth       = CGRectGetHeight([UIScreen mainScreen].bounds);
    }
    else if(isPortraitDown || isPortraitUp)
    {
        constrainedWidth  = PORTRAIT_CONSTRAINED_WIDTH;
        constrainedHeight = PORTRAIT_CONSTRAINED_HEIGHT;
        screenWidth       = CGRectGetWidth([UIScreen mainScreen].bounds);
        screenHeight      = CGRectGetHeight([UIScreen mainScreen].bounds);
    }
    
    self.frame = (CGRect){CGPointZero,screenWidth,screenHeight};
    constrainedSize = CGSizeMake(constrainedWidth, constrainedHeight);
    
    _titleText.frame = [self titleRect];
    
    CGRect messageRect = [self messageRect];
    _messageScrollView.frame = messageRect;
    messageRect.origin.x = 0;
    messageRect.origin.y = 0;
    _messageText.frame = messageRect;
    if(hasCheckBox)
    {
        [self checkBoxRect];
    }
    float backgroundHeight = [self backgroundHeight];
    if (backgroundHeight > constrainedHeight)
    {
        _background.frame = CGRectMake((screenWidth -constrainedWidth)/2.0, (screenHeight -constrainedHeight)/2.0, constrainedWidth, constrainedHeight);
        
        

        float originY = [self firstButtonOriginY];
        float messageHight = originY -(_titleText.frame.origin.y+_titleText.frame.size.height)-2*kVerMargin - kVerMargin;
        CGRect rect = _messageScrollView.frame;
        rect.size.height = messageHight;
        _messageScrollView.contentSize = CGSizeMake(constrainedWidth-2*kHorMargin, _messageText.frame.size.height);
        _messageScrollView.frame = rect;
        _textBackground.frame = CGRectMake(0, _titleText.frame.size.height+_titleText.frame.origin.y+kVerMargin, constrainedWidth, 0.5);
    }
    else
    {
        if(hasCheckBox)
        {
            _background.center = CGPointMake(screenWidth/2.0, screenHeight/2.0);
            _background.bounds =CGRectMake(0, 0, constrainedWidth, backgroundHeight);
           // _background.frame = CGRectMake(8, (screenHeight -backgroundHeight)/2.0, constrainedWidth, backgroundHeight);
            _textBackground.frame = CGRectMake(0, _titleText.frame.size.height+_titleText.frame.origin.y+kVerMargin, constrainedWidth, 0.5);
        }else
        {
            _background.frame = CGRectMake((screenWidth -constrainedWidth)/2.0, (screenHeight -backgroundHeight)/2.0, constrainedWidth, backgroundHeight);
            _textBackground.frame = CGRectMake(0, _titleText.frame.size.height+_titleText.frame.origin.y+kVerMargin, constrainedWidth, 0.5);
        }
    }
    JCAlertStyle *stype = [JCAlertStyle shareStyle];
    stype.alertView.width = self.frame.size.width;
    stype.alertView.maxHeight = self.frame.size.height;
    
    [self setNeedsDisplay];
}


-(float)firstButtonOriginY
{
    float buttonWidth = 0.0;
    float originY = 0.0;
    if (_buttonArray.count <= 2)
    {
        if (_buttonArray.count == 1)
        {
//            buttonWidth = constrainedWidth-2*kHorMargin;    // wnh 20160510
            buttonWidth = constrainedWidth;
        }
        else
        {
//            buttonWidth = (constrainedWidth-2*kHorMargin-BUTTONGAP)/2.0;  // wnh 20160510
            buttonWidth = constrainedWidth/2.0;
        }
        
        for (int i=0; i<_buttonArray.count; i++)
        {
//            CGRect buttonRect = CGRectMake(i*BUTTONGAP+kHorMargin+i*buttonWidth, _background.frame.size.height-BUTTONHEIGHT, buttonWidth, BUTTONHEIGHT);      // wnh 20160510
            CGRect buttonRect = CGRectMake(i*buttonWidth, _background.frame.size.height-BUTTONHEIGHT, buttonWidth, BUTTONHEIGHT);
            UIButton *button = [_buttonArray objectAtIndex:i];
            button.frame = buttonRect;
            if (i == _buttonArray.count -1)
            {
                originY = button.frame.origin.y;
            }
        }
    }
    else if(_buttonArray.count >2)
    {
        for (int i=0; i<_buttonArray.count; i++)
        {
//            int buttonWidth = constrainedWidth-2*kHorMargin;
            int buttonWidth = constrainedWidth;
            int orginY = _background.frame.size.height;
//            CGRect buttonRect = CGRectMake(kHorMargin, orginY-20-BUTTONHEIGHT*(i+1)-BUTTONGAP*i, buttonWidth, BUTTONHEIGHT);  // wnh 20160510
            CGRect buttonRect = CGRectMake(0, orginY-20-BUTTONHEIGHT*(i+1), buttonWidth, BUTTONHEIGHT);
            UIButton *button = [_buttonArray objectAtIndex:i];
            button.frame = buttonRect;
            if (i == _buttonArray.count -1)
            {
                originY = button.frame.origin.y;
            }

        }
    }
    return originY;
}
#pragma mark NHPopoverViewControllerDelegate

@end

@implementation JCAlertController (Ext)

/**
 设置是否自动转屏
 */
-(BOOL) shouldAutorotate{
    return NO;
}
@end



