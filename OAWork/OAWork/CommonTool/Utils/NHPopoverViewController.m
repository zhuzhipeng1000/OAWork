//
//  NHPopoverViewController.m
//  bsl
//
//  Created by FanFrank on 14/11/3.
//
//

#import "NHPopoverViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Utils.h"
#import "AppDelegate.h"
#define isLandscapeLeft [UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeLeft
#define isLandscapeRight [UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeRight
#define isPortraitUp [UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationPortraitUpsideDown
#define isPortraitDown [UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationPortrait

@interface NHPopoverViewController()
{
    UIButton *_closeButton;
    int _beforeStatusOrientation;
}

@property (nonatomic, retain) UIWindow *isAlertWindow;
@property (nonatomic, retain) UIView *windowBg;
@property (nonatomic, retain) UILabel *versionNoText;
@property (nonatomic, retain) UILabel *appSizeText;
@property (nonatomic, retain) UILabel *updateTitileText;

@property (nonatomic, retain) UIViewController *contentViewController;
@property (nonatomic, retain) UIView *contentView;

@end

@implementation NHPopoverViewController

-(id)initWithController:(UIViewController *)viewController contentSize:(CGSize)contentSize
{
    return [self initWithController:viewController contentSize:contentSize autoClose:NO];
}

- (id)initWithController:(UIViewController *)viewController contentSize:(CGSize)contentSize autoClose:(BOOL)clickBgClose
{
    if(self = [super init])
    {
        _beforeStatusOrientation = -1;
        UIDevice *device = [UIDevice currentDevice];
        [device beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(relayOutSubViews) name:UIDeviceOrientationDidChangeNotification object:nil];
        [device endGeneratingDeviceOrientationNotifications];
        
        _isClickBgClose = clickBgClose;
        constrainedSize = contentSize;
        viewController.view.frame = CGRectMake(0, 0, contentSize.width, contentSize.height);
        self.contentViewController = viewController;
        
        [self addWindow];
        [self addBackground];
        
        // 添加viewController
        [_background addSubview:viewController.view];
        [self rotateScreen];
    }
    return self;
}

- (id)initWithView:(UIView *)view contentSize:(CGSize)contentSize autoClose:(BOOL)clickBgClose
{
    if(self = [super init])
    {
        _beforeStatusOrientation = -1;
        UIDevice *device = [UIDevice currentDevice];
        [device beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(relayOutSubViews) name:UIDeviceOrientationDidChangeNotification object:nil];
        [device endGeneratingDeviceOrientationNotifications];
        
        _isClickBgClose = clickBgClose;
        constrainedSize = contentSize;
        view.frame = CGRectMake(0, 0, contentSize.width, contentSize.height);
        self.contentView = view;
        
        [self addWindow];
        [self addBackground];
        
        // 添加viewController
        [_background addSubview:view];
        [self rotateScreen];
    }
    return self;
}

-(void)dealloc
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    self.contentView = nil;
    self.contentViewController = nil;
}

#pragma mark - Public methods

-(void)show
{
    [self performSelectorOnMainThread:@selector(showOnMainWithCloseBtn:) withObject:nil waitUntilDone:YES];
}

- (void)showWithCloseBtn:(BOOL)showCloseBtn
{
    [self performSelectorOnMainThread:@selector(showOnMainWithCloseBtn:) withObject:[NSNumber numberWithBool:showCloseBtn] waitUntilDone:YES];
}

- (void)showOnMainWithCloseBtn:(NSNumber *)showCloseBtn
{
    [self relayOutSubViews];
    
    if ([showCloseBtn boolValue] && !_closeButton)
    {
        _closeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [self addSubview:_closeButton];
        [_closeButton setImage:[UIImage imageNamed:@"popover_close.png"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(dismissWithButton) forControlEvents:UIControlEventTouchUpInside];
    }
    float screenWidth = [UIScreen mainScreen].bounds.size.width;
    float screenHeight = [UIScreen mainScreen].bounds.size.height;
    _closeButton.frame = CGRectMake((screenWidth -constrainedSize.width)/2.0+constrainedSize.width-15, (screenHeight -constrainedSize.height)/2.0-15, 30, 30);
}

- (void)dismiss
{
    [self removeAlertView];
}
-(void)hiddeWindow
{
    if (_isAlertWindow) {
        _isAlertWindow.hidden = YES;
    }
}
-(void)showFromHidden
{
    if (_isAlertWindow) {
        _isAlertWindow.hidden = NO;
    }
}
- (void)dismissWithButton
{
    [self removeAlertView];
}

#pragma mark - Private methods

-(void)addWindow
{
    self.frame = [UIScreen mainScreen].bounds;
    
    _isAlertWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _isAlertWindow.backgroundColor = [UIColor clearColor];
    //_isAlertWindow.windowLevel = 1999;
    [_isAlertWindow makeKeyAndVisible];
    
    NSArray *windows = [UIApplication sharedApplication].windows;
    
    float bgWidth = _isAlertWindow.frame.size.width > _isAlertWindow.frame.size.height ? _isAlertWindow.frame.size.width : _isAlertWindow.frame.size.height;
    if (_isClickBgClose)
    {
        UIButton *windowBg = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, bgWidth, bgWidth)];
        [windowBg addTarget:self action:@selector(dismissWithButton) forControlEvents:UIControlEventTouchUpInside];
        windowBg.backgroundColor = [UIColor blackColor];
        windowBg.alpha = 0.4;
        _windowBg = windowBg;
    }
    else
    {
        _windowBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bgWidth, bgWidth)];
        _windowBg.backgroundColor = [UIColor blackColor];
        _windowBg.alpha = 0.4;
    }
    _windowBg.center = self.center;
    [_isAlertWindow addSubview:self];
    [self addSubview:_windowBg];
}

-(void)addBackground
{
    _background = [[UIView alloc] init];
    _background.layer.backgroundColor = [[[Utils colorWithHexString:@"#eeeeee"] colorWithAlphaComponent:1.0] CGColor];
    [self addSubview:_background];
    
    // 圆角
    _background.layer.cornerRadius = 5.0f;
    _background.clipsToBounds = YES;
}

-(void)removeAlertView
{
    [_isAlertWindow setHidden:YES];
    [_isAlertWindow resignKeyWindow];
    [_isAlertWindow removeFromSuperview];
    
    AppDelegate* delegate= (AppDelegate*)[UIApplication sharedApplication].delegate;
    [delegate.window makeKeyWindow];
    if (_lastWindow) {
        [_lastWindow makeKeyAndVisible];
    }else{
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
           [[[[UIApplication sharedApplication] delegate] window]  makeKeyAndVisible];
        }else{
            /**
             *  iPad版 获取密码选择业务密码或者e帆网后无法跳转到获取密码页面，因为Popover关闭时把其它的Window层隐藏，把主Window显示了，所以把登录窗口的window隐藏了也就无法看到跳转的页面
             */
            dispatch_async(dispatch_get_main_queue(), ^{
                NSArray *windows = [UIApplication sharedApplication].windows;
                UIWindow *keyWindow = windows[MAX(_isAlertWindow ? ([windows indexOfObject:_isAlertWindow]) - 1 : 0, 0)];
                [keyWindow makeKeyAndVisible];
            });
        }
    }
    self.isAlertWindow = nil;
    if ([_delegate respondsToSelector:@selector(didDismissNHPopover:)])
    {
        [_delegate didDismissNHPopover:self];
    }
    if (self.dissmissBlock) {
        self.dissmissBlock();
    }

}

-(void)layoutViews
{
    float screenWidth = [UIScreen mainScreen].bounds.size.width;
    float screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    if (_contentViewController)
    {
        _background.frame = CGRectMake((screenWidth -constrainedSize.width)/2.0, (screenHeight -constrainedSize.height)/2.0, constrainedSize.width, constrainedSize.height);
        _contentViewController.view.frame = CGRectMake(0, 0, constrainedSize.width, constrainedSize.height);
    }
    else
    {
        _background.frame = CGRectMake((screenWidth- constrainedSize.width)/2,150,constrainedSize.width, constrainedSize.height);
//       _contentView.frame = CGRectMake(0, screenHeight - constrainedSize.height, constrainedSize.width, constrainedSize.height);
    }
}

-(void)rotateScreen
{
    //横屏
    if (isLandscapeLeft)
    {
        self.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    else if(isLandscapeRight)
    {
        self.transform = CGAffineTransformMakeRotation(-M_PI_2);
    }
    //竖屏
    else if(isPortraitDown)
    {
        self.transform = CGAffineTransformIdentity;
    }
    else if(isPortraitUp)
    {
        self.transform = CGAffineTransformMakeRotation(-M_PI);
    }
    
    // 适配iOS8 fanlanjun 14/11/4
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8)
    {
        CGRect theFrame = [UIScreen mainScreen].bounds;;
        if (isLandscapeLeft || isLandscapeRight)
        {
            theFrame.size = CGSizeMake(theFrame.size.height, theFrame.size.width);
        }
        self.frame = theFrame;
        _isAlertWindow.frame = theFrame;
        
        float bgWidth = _isAlertWindow.frame.size.width > _isAlertWindow.frame.size.height ? _isAlertWindow.frame.size.width : _isAlertWindow.frame.size.height;
        theFrame.size = CGSizeMake(bgWidth, bgWidth);
        _windowBg.frame = theFrame;
        
        //适配ipad4 8.3偏移，iOS9系统不用添加这个适配(fanlanjun 15/11/5)
        NSString *deviceString= [Utils deviceString];
        if ([deviceString rangeOfString:@"iPad3,"].location!=NSNotFound&&[[UIDevice currentDevice].systemVersion floatValue] >= 8.3 && [[UIDevice currentDevice].systemVersion floatValue] < 9){
//            CGRect frame = self.frame;
//            frame.origin.y=-256;
//            self.frame=frame;
            CGRect isAlertWindow=_isAlertWindow.frame;
            isAlertWindow.origin.y=-256;
            _isAlertWindow.frame=isAlertWindow;
        }
        
    }
}

- (void)relayOutSubViews
{
    if (_beforeStatusOrientation == -1 || _beforeStatusOrientation != [UIApplication sharedApplication].statusBarOrientation)
    {
        _beforeStatusOrientation = [UIApplication sharedApplication].statusBarOrientation;
        [self layoutViews];
        [_contentView setNeedsLayout];
        [_contentViewController.view setNeedsLayout];
        float duration = 0.3;
        [UIView animateWithDuration:duration animations:^{
            [self rotateScreen];
        }];
    }
}

@end
