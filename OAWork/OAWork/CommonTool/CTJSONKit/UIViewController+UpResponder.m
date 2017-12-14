//
//  UIViewController+UpResponder.m
//  BUPM-Phone
//
//  Created by Suycity on 27/12/16.
//
//

#import "UIViewController+UpResponder.h"
#import <objc/runtime.h>

@implementation UIViewController (UpResponder)

/**
 UINavigationController Pop
 
 @param isRoot 是否直接返回到首页
 @param isAnimated 是否需要动画
 @return 是否是NavigationController ViewControllers
 */
- (BOOL)navigationControllerPopToRootViewController:(BOOL)isRoot animated:(BOOL)isAnimated{
    if (self.navigationController && self.navigationController.topViewController == self.navigationController.visibleViewController) {
        if ([self.navigationController.viewControllers count] > 1) {
            if(isRoot){
                [self.navigationController popToRootViewControllerAnimated:isAnimated];
            }else{
                [self.navigationController popToViewController:self.navigationController.viewControllers[MAX(0, self.navigationController.viewControllers.count - 1)]
                                                      animated:isAnimated];
            }
        }
        return YES;
    }
    else{
        return NO;
    }
}
/**
 查看最顶层的UIViewController
 */
- (UIViewController *)getUpResponder{
    UIViewController *viewController = self;
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        viewController = [[(UINavigationController *)viewController viewControllers] lastObject];
    }else if (viewController && viewController.navigationController){
        viewController= [[[viewController navigationController] viewControllers] lastObject];
    }
    return  [self getUpResponder:viewController];
}
- (UIViewController *)getUpResponder:(UIViewController *)nextResponder{
    UIViewController *viewController = nextResponder;
    while (viewController) {
        if ([viewController presentedViewController]) {
            viewController = [viewController presentedViewController];
        }else{
            /**
             *  @author Suycity, 2016/04/27
             *
             *  当要获取最顶级的ViewController的时候，还要判断这个ViewController是否正在消失
             */
            if ([viewController isBeingDismissed]) {
                viewController = [viewController presentingViewController];
                if ([viewController isKindOfClass:[UINavigationController class]]) {
                    viewController = [[(UINavigationController *)viewController viewControllers] lastObject];
                }
                return viewController;
            }else
                return viewController;
            
        }
    }
    return viewController;
}
/**
 查看最顶层的UIViewController 是否是自己
 */
- (BOOL)isEqualUpResponderViewController{
    return [self isKindOfClass:[[[[[UIApplication sharedApplication].delegate window] rootViewController] getUpResponder] class]];
}

/**
 返回到首页
 */
- (void)dismissViewController{
    [self dismissViewControllerAnimated:YES];
}
- (void)dismissViewControllerAnimated:(BOOL)isDismissAnimated{
    UIViewController *upResponder = [self getUpResponder];
    if (![upResponder navigationControllerPopToRootViewController:isDismissAnimated animated:YES]) {
        BOOL isAnimated = YES;
        BOOL isStopWhile = NO;
        
        while (!isStopWhile) {
            UIViewController *presenting = [upResponder presentingViewController];
            if (presenting) {
                upResponder = presenting;
            }else
                isStopWhile = YES;
            
            if ([upResponder isKindOfClass:[UINavigationController class]]) {
                NSArray *viewControllers = [(UINavigationController *)presenting viewControllers];
                upResponder = [viewControllers lastObject];
                if([viewControllers count] >= 2)isAnimated = NO;
                isStopWhile = YES;
            }
        }
        upResponder.isDismissToNavigation = YES;
        [upResponder dismissViewControllerAnimated:isDismissAnimated ? isAnimated : isDismissAnimated completion:^{
            upResponder.isDismissToNavigation = NO;
            [upResponder dismissViewController];
        }];
    }
}

- (void)dismissViewController:(void (^ __nullable)(UIViewController *vc,bool isLoginVC)) completion{
    UIViewController *topFoolrController = [self getUpResponder];
    if (topFoolrController){
        if([topFoolrController isKindOfClass:NSClassFromString(@"LoginViewController")]){//如果是登陆界面
            completion(topFoolrController,true);
        }else if([topFoolrController isKindOfClass:NSClassFromString(@"GetPasswordViewController")] || [topFoolrController isKindOfClass:NSClassFromString(@"ModifyPassWordViewController")]){//如果是修改页面或者是忘记密码界面
            UIViewController *upResponder = [topFoolrController presentingViewController];
            [topFoolrController dismissViewControllerAnimated:upResponder?NO:YES completion:^{
                if(upResponder){
                    [upResponder dismissViewController:completion];
                }else{
                    completion(upResponder,false);
                }
            }];
        }else{
            completion(topFoolrController,false);
        }
    }else{
        completion(topFoolrController,false);
    }
}

#pragma mark - Set/Get
static const char YC_BOOL_isDismissToNavigation = '\0';
- (void)setIsDismissToNavigation:(BOOL)isDismissToNavigation{
    if (isDismissToNavigation != self.isDismissToNavigation) {
        // 存储新的
        [self willChangeValueForKey:@"isDismissToNavigation"]; // KVO
        objc_setAssociatedObject(self, &YC_BOOL_isDismissToNavigation,
                                 @(isDismissToNavigation), OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"isDismissToNavigation"]; // KVO
    }
}
- (BOOL)isDismissToNavigation{
    return [objc_getAssociatedObject(self, &YC_BOOL_isDismissToNavigation) boolValue];
}

@end
