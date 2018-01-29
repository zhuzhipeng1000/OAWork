//
//  LoginViewController.m
//  ProductAduit
//
//  Created by JIME on 2017/1/15.
//  Copyright © 2017年 JIME. All rights reserved.
//

#import "LoginViewController.h"
#import "UIView+Utils.h"
#import "ForgetPassWordViewController.h"
#import "MyRequest.h"
#import "Desthird.h"
#import "ViewController.h"
#import "User.h"

@interface LoginViewController ()<UITextFieldDelegate>{

    UIButton *loginbt;
    UIImageView *headImage;
    UITextField *accountTF;
    UITextField *passwordTF;
    BOOL isSelectAutoLogin;
    
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"登录";
    
//    [self hiddenLineView:YES];
    
    self.view.userInteractionEnabled=YES;
    [self createNaviTopBarWithShowBackBtn:false showTitle:YES];
    
    isSelectAutoLogin=[[NSUserDefaults standardUserDefaults] boolForKey:@"isSelectAutoLogin"];
    int adjustHeight=0;
//    if (self.navigationController.viewControllers.count>1&&[self.navigationController.viewControllers[1] isKindOfClass:[LoginViewController class]]) {
        adjustHeight=70;
//    }
    
    headImage=[[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-100)/2, 20+StartHeight+adjustHeight, 100, 100)];
    headImage.image=[UIImage imageNamed:@"loginIcon"];
    [self.view addSubview:headImage];
    
    UIView *aView=[self textEditViewOfFrame:CGRectMake(0, headImage.bottom+20, SCREEN_WIDTH, 50) tag:55 text:@"账号" accessibilityHint:@"请输入您的用户名／手机号码"];
    [self.view addSubview:aView];
    
    
    UIView *secondView =[self textEditViewOfFrame:CGRectMake(0, aView.bottom, SCREEN_WIDTH, 50) tag:56 text:@"密码" accessibilityHint:@"请输入您的密码"];
    [self.view addSubview:secondView];
    
    accountTF=[self.view viewWithTag:55];
    accountTF.clearButtonMode=UITextFieldViewModeAlways;
    NSString *userName=[UD objectForKey:KuserName];
    NSString *userPass=[UD objectForKey:KuserPassWord];
    if (userName) {
//        accountTF.text=@"18922763120";
        accountTF.text=userName;
    }
    passwordTF=[self.view viewWithTag:56];
  
    passwordTF.secureTextEntry = true;
    if ([UD boolForKey:@"isSelectAutoLogin"]) {
         passwordTF.text=userPass;
    }
  
    
    loginbt=[[UIButton alloc]initWithFrame:CGRectMake(10, secondView.bottom+20, SCREEN_WIDTH-20, 45)];
    [loginbt setTitle:@"登录" forState:UIControlStateNormal];
    [loginbt setTitle:@"登录" forState:UIControlStateNormal];
    [loginbt setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    [loginbt setTitleColor:[UIColor whiteColor]  forState:UIControlStateHighlighted];
    [loginbt setBackgroundImage:[Utils createImageWithColor:[Utils colorWithHexString:@"#5dbed8"]] forState:UIControlStateNormal];
    [loginbt setBackgroundImage:[Utils createImageWithColor:[Utils colorWithHexString:@"#359eba"]] forState:UIControlStateHighlighted];
    loginbt.clipsToBounds=YES;
    loginbt.layer.cornerRadius=3.0f;
    [loginbt addTarget:self action:@selector(loginbTTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:loginbt];
    
    
    UIButton *bu=[[UIButton alloc]initWithFrame:CGRectMake(10, loginbt.bottom+20, 110, 45)];
    [bu setTitle:@"自动登录" forState:UIControlStateNormal];
    [bu setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
    [bu setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateHighlighted];
    isSelectAutoLogin= [UD boolForKey:@"isSelectAutoLogin"];
    if (isSelectAutoLogin) {
        [bu setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateNormal];
        [bu setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateHighlighted];
    }
    [bu setTitle:@"自动登录" forState:UIControlStateHighlighted];
    
    [bu setTitleColor:[UIColor lightGrayColor]  forState:UIControlStateNormal];
     [bu setTitleColor:[UIColor lightGrayColor]  forState:UIControlStateHighlighted];
    bu.backgroundColor=[UIColor whiteColor];
    bu.clipsToBounds=YES;
    bu.layer.cornerRadius=3.0f;
    [bu addTarget:self action:@selector(autoLoginbTTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bu];
    
    
//    UIButton *forgetbu=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-120, loginbt.bottom+20, 110, 45)];
//    [forgetbu setTitle:@"忘记密码？" forState:UIControlStateNormal];
//    [forgetbu setTitle:@"忘记密码？" forState:UIControlStateNormal];
//    [forgetbu setTitleColor:[Utils colorWithHexString:@"#5dbed8"]  forState:UIControlStateNormal];
//    forgetbu.backgroundColor=[UIColor whiteColor];
//    forgetbu.clipsToBounds=YES;
//    forgetbu.layer.cornerRadius=3.0f;
//    [forgetbu addTarget:self action:@selector(forgetbTTapped:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:forgetbu];
    

    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;

    self.navigationItem.hidesBackButton =YES;
    self.navigationItem.leftBarButtonItem = nil;

}
-(UIView*)textEditViewOfFrame:(CGRect)frame tag:(NSInteger)aTag text:(NSString*)aText accessibilityHint:(NSString*)accessibilityHint {
    UIView *aView=[[UIView alloc]initWithFrame:frame];
    aView.userInteractionEnabled=YES;
    aView.backgroundColor=[UIColor whiteColor];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 60, 49)];
    label.text=aText;
    label.backgroundColor=[UIColor whiteColor];
    [aView addSubview:label];
    
    UITextField *textFil=[[UITextField alloc]initWithFrame:CGRectMake(label.right, label.top, SCREEN_WIDTH-label.width-10, label.height)];
    textFil.delegate=self;
    textFil.textColor=[UIColor grayColor];
    textFil.tag=aTag;
    textFil.userInteractionEnabled=YES;
    textFil.placeholder=accessibilityHint;
    [aView addSubview:textFil];
    
    UILabel *lineLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, textFil.bottom, SCREEN_WIDTH-20, kMinPixels)];
    lineLabel.backgroundColor=[UIColor grayColor];
    [aView addSubview:lineLabel];
    
    return aView;
}
#pragma  mark BtTarget
-(void)loginbTTapped:(UIButton*)bt{
   
    
    if (!accountTF.text.length||!passwordTF.text.length) {
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:nil message:@"请输入帐号和密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [al show];
        return;
    }
    bt.userInteractionEnabled=NO;
//    NSString *paa=[Utils md5:passwordTF.text];
    NSString *paa = passwordTF.text;
    NSDictionary *parameters =@{@"account":accountTF.text,@"pwd":paa }; //[paa uppercaseString]};
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    _hud.mode = MBProgressHUDModeAnnularDeterminate;
    self.hud.labelText = @"登录中";
    __weak __typeof(self) weakSelf = self;
    [MyRequest getRequestWithUrl:[HostMangager loginUrl] andPara:parameters isAddUserId:NO Success:^(NSDictionary *dict, BOOL success) {
        bt.userInteractionEnabled=YES;
        if ([dict isKindOfClass:[NSDictionary class]]&&[dict[@"result"] isKindOfClass:[NSDictionary class]]&&[dict[@"code"] intValue]==0) {
            [weakSelf.hud hide:YES];
            NSDictionary *dic=dict[@"result"];
            if ([dic isKindOfClass:[NSDictionary class]]) {
//                [[NSUserDefaults standardUserDefaults] setNotNull:dic[@"token"] forKey:@"token"];
                [UD setObject:accountTF.text forKey:KuserName];
                [UD setObject:passwordTF.text forKey:KuserPassWord];
                NSString *LoginDic=[dic JSONStringFromCT];
                [UD setValue:LoginDic forKey:KloginInfo];
                [UD synchronize];
                User *aUser=[User shareUser];
                [aUser setInfoOfDic:dic];
            }
            if (self.navigationController.viewControllers.count>2) {
                
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                ViewController* main = [[ViewController alloc] init];
                self.navigationController.viewControllers=@[main];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }else{
            [weakSelf.hud hide:YES];
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:nil message:@"帐号或密码错误，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [al show];
//            [self goToMain];
        }
       
    } fail:^(NSError *error) {
        bt.userInteractionEnabled=YES;
//          [self goToMain];
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:nil message:@"帐号或密码错误，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [al show];
    }];
    
}
-(void)goToMain{
    return;
    ViewController* main = [[ViewController alloc] init];
    self.navigationController.viewControllers=@[main];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)autoLoginbTTapped:(UIButton*)bt{
    isSelectAutoLogin=!isSelectAutoLogin;
    [UD setBool:isSelectAutoLogin forKey:@"isSelectAutoLogin"];
    [UD synchronize];
    if (isSelectAutoLogin) {
        [bt setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateNormal];
        [bt setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateHighlighted];
    }else{
        [bt setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
        [bt setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateHighlighted];
    }
}
-(void)forgetbTTapped:(UIButton*)bt{
    
    ForgetPassWordViewController *forgetVc=[[ForgetPassWordViewController alloc]initWithNibName:@"ForgetPassWordViewController" bundle:nil];
    [self.navigationController pushViewController:forgetVc animated:YES];

}
#pragma mark  textFieldDelegate
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
