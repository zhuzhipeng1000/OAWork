//
//  UIViewController+UpResponder.h
//  BUPM-Phone
//
//  Created by Suycity on 27/12/16.
//
//

#import <UIKit/UIKit.h>

@interface UIViewController (UpResponder)
@property (nonatomic, assign) BOOL isDismissToNavigation;//是否处于从present to Navigation

/**
 查看最顶层的UIViewController
 */
- (UIViewController *)getUpResponder;
/**
 查看最顶层的UIViewController 是否是自己
 */
- (BOOL)isEqualUpResponderViewController;


/**
 UINavigationController Pop

 @param isRoot 是否直接返回到首页
 @param isAnimated 是否需要动画
 @return 是否是NavigationController ViewControllers
 */
- (BOOL)navigationControllerPopToRootViewController:(BOOL)isRoot animated:(BOOL)isAnimated;

/**
 返回到首页
 */
/**
 * 关闭 最顶层viewController 直到页面为非 GetPasswordViewController  ModifyPassWordViewController
 * @param completion 回调 
                    vc:当前UIViewController  isLoginVC : 当前是否为登陆UIViewController
 */
- (void)dismissViewController:(void (^ __nullable)(UIViewController *vc,bool isLoginVC)) completion;

/**
 回到首页
 */
- (void)dismissViewController;

/**
 回到首页是否开启动画

 @param isDismissAnimated <#isDismissAnimated description#>
 */
- (void)dismissViewControllerAnimated:(BOOL)isDismissAnimated;
@end
