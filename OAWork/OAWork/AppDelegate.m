//
//  AppDelegate.m
//  OAWork
//
//  Created by james on 2017/11/23.
//  Copyright © 2017年 james. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "ViewController.h"
#import "OAJobDetailViewController.h"
#import "OAMainViewController.h"
#import "TestViewController.h"
#import "UIViewController+UpResponder.h"
#import "User.h"
#import "LaunchViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
   
    self.navi=[[UINavigationController alloc]init];
    self.window.rootViewController=self.navi;
    [self.navi setNavigationBarHidden:true];
//     OAMainViewController*a=[[OAMainViewController alloc]init];
//    self.navi.viewControllers=@[a];
    if ([UD objectForKey:@"isSelectAutoLogin"]) {
        LaunchViewController *a=[[LaunchViewController alloc]init];
        self.navi.viewControllers=@[a];
//
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
              [self login];
        });
    }else{
        [self goToLogin];
    }
    
    
    self.window.rootViewController=self.navi;
    [self.navi setNavigationBarHidden:true];
    // Override point for customization after application launch.
    return YES;
}
+ (AppDelegate *) shareAppDeleage{
    
   return (AppDelegate *)[[UIApplication sharedApplication] delegate];;
}
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    if (window && [application.windows firstObject] == window) {
        
        UIViewController *viewController = [window.rootViewController getUpResponder];
        UIInterfaceOrientationMask orientationMask = [viewController supportedInterfaceOrientations];
        return orientationMask;
    }else if(window){
        UIWindow *upResponderWindow = [application.windows firstObject];
        UIViewController *viewController = [upResponderWindow.rootViewController getUpResponder];
        UIInterfaceOrientationMask orientationMask = [viewController supportedInterfaceOrientations];
        return orientationMask;
    }
    return UIInterfaceOrientationMaskPortrait;
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}
-(void)login{
//    __weak __typeof(self) weakSelf = self;
  NSString *userName=  [UD objectForKey:KuserName];
   NSString *userPassWord= [UD objectForKey:KuserPassWord];
    NSDictionary *parameters =@{@"account":userName,@"pwd":userPassWord };
    [MyRequest getRequestWithUrl:[HostMangager loginUrl] andPara:parameters isAddUserId:NO Success:^(NSDictionary *dict, BOOL success) {

        if ([dict isKindOfClass:[NSDictionary class]]&&[dict[@"result"] isKindOfClass:[NSDictionary class]]&&[dict[@"code"] intValue]==0) {
    NSDictionary *dic=dict[@"result"];
            if ([dic isKindOfClass:[NSDictionary class]]) {
 
              
                NSString *LoginDic=[dic JSONStringFromCT];
                [UD setValue:LoginDic forKey:KloginInfo];
                [UD synchronize];
                User *aUser=[User shareUser];
                [aUser setInfoOfDic:dic];
            }
            [self goToMain];
        }else{
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:nil message:@"帐号或密码错误，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [al show];
             [self goToLogin];
        }
        
    } fail:^(NSError *error) {
        
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:nil message:@"帐号或密码错误，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [al show];
        [self goToLogin];
    }];
    
}
-(void)goToLogin{
    
    LoginViewController *login=[[LoginViewController alloc]init];
    self.navi.viewControllers=@[login];
    
}
-(void)goToMain{
    ViewController *mainvc=[[ViewController alloc]init];
    self.navi.viewControllers=@[mainvc];
    
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
