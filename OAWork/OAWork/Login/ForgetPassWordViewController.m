//
//  ForgetPassWordViewController.m
//  ProductAduit
//
//  Created by JIME on 2017/1/15.
//  Copyright © 2017年 JIME. All rights reserved.
//

#import "ForgetPassWordViewController.h"
//#import "ResetPassViewController.h"
#import "LoginViewController.h"

@interface ForgetPassWordViewController ()
{
    UIButton *loginbt;
    UITextField *accountTF;
    UITextField *veriyTf;
    UIButton *getVerifyBt;
    NSInteger count;
    NSTimer *timer;
    NSString *verifyCode;
    NSString *phoneSt;
    NSMutableDictionary *paraDic;
}

@end

@implementation ForgetPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"重置密码";
    int adjustHeight=0;
    if ([self.navigationController.viewControllers[1] isKindOfClass:[LoginViewController class]]) {
        adjustHeight=64;
    }
    UIView *aView=[self textEditViewOfFrame:CGRectMake(0, StartHeight+adjustHeight, SCREEN_WIDTH, 50) tag:55 text:@"手机号码" accessibilityHint:@"请输入您的手机号码"];

    getVerifyBt=[[UIButton alloc]initWithFrame:CGRectMake(aView.width-100,5,90,aView.height-10)];
    [getVerifyBt setTitle:@"发送验证码" forState:UIControlStateNormal];
    getVerifyBt.titleLabel.font=[UIFont systemFontOfSize:15.0f];
    [getVerifyBt setTitle:@"发送验证码" forState:UIControlStateNormal];
    [getVerifyBt setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    [getVerifyBt setTitleColor:[UIColor whiteColor]  forState:UIControlStateHighlighted];
    [getVerifyBt setBackgroundImage:[Utils createImageWithColor:[Utils colorWithHexString:@"#5dbed8"]] forState:UIControlStateNormal];
    [getVerifyBt setBackgroundImage:[Utils createImageWithColor:[Utils colorWithHexString:@"#359eba"]] forState:UIControlStateHighlighted];
    
    getVerifyBt.clipsToBounds=YES;
    getVerifyBt.layer.cornerRadius=3.0f;
    [getVerifyBt addTarget:self action:@selector(dataReuest) forControlEvents:UIControlEventTouchUpInside];
    [aView addSubview:getVerifyBt];
    
    [self.view addSubview:aView];

    accountTF=[self.view viewWithTag:55];
    accountTF.text=[UD objectForKey:KuserName];;
    
    UIView *secondView =[self textEditViewOfFrame:CGRectMake(0, aView.bottom, SCREEN_WIDTH, 50) tag:56 text:@"验证码" accessibilityHint:@"请输入您的验证码"];
    [self.view addSubview:secondView];
    
    veriyTf=[self.view viewWithTag:56];
    
    
    UILabel *lineLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, secondView.bottom, SCREEN_WIDTH-20, kMinPixels)];
    lineLabel.textColor=[Utils colorWithHexString:@"#cccccc"];
    [aView addSubview:lineLabel];
    
    UILabel *noticeLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, secondView.bottom, SCREEN_WIDTH-20, 30)];
    noticeLabel.textColor=[Utils colorWithHexString:@"#cccccc"];
    noticeLabel.text=@"请输入您的手机号码，我们将发送验证码到您绑定的手机上";
    noticeLabel.font=[UIFont systemFontOfSize:14.0f];
    noticeLabel.adjustsFontSizeToFitWidth=YES;
    [self.view addSubview:noticeLabel];
    
    loginbt=[[UIButton alloc]initWithFrame:CGRectMake(10, noticeLabel.bottom+20, SCREEN_WIDTH-20, 45)];
    [loginbt setTitle:@"下一步" forState:UIControlStateNormal];
    [loginbt setTitle:@"下一步" forState:UIControlStateNormal];
    [loginbt setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    [loginbt setTitleColor:[UIColor whiteColor]  forState:UIControlStateHighlighted];
    [loginbt setBackgroundImage:[Utils createImageWithColor:[Utils colorWithHexString:@"#5dbed8"]] forState:UIControlStateNormal];
    [loginbt setBackgroundImage:[Utils createImageWithColor:[Utils colorWithHexString:@"#359eba"]] forState:UIControlStateHighlighted];

    loginbt.clipsToBounds=YES;
    loginbt.layer.cornerRadius=3.0f;
    [loginbt addTarget:self action:@selector(nextBTTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginbt];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}
-(void)scrollTimer{
    
    [getVerifyBt setTitle:[NSString stringWithFormat:@"%lds",(long)count] forState:UIControlStateNormal];
    [getVerifyBt setTitle:[NSString stringWithFormat:@"%lds",(long)count] forState:UIControlStateHighlighted];
    [getVerifyBt setBackgroundImage:[Utils createImageWithColor:[Utils colorWithHexString:@"#b7b7b7"]] forState:UIControlStateNormal];
    [getVerifyBt setBackgroundImage:[Utils createImageWithColor:[Utils colorWithHexString:@"#b7b7b7"]] forState:UIControlStateHighlighted];
    count--;
    if (count==0||count<0) {
        
        [getVerifyBt setBackgroundImage:[Utils createImageWithColor:[Utils colorWithHexString:@"#5dbed8"]] forState:UIControlStateNormal];
        [getVerifyBt setBackgroundImage:[Utils createImageWithColor:[Utils colorWithHexString:@"#5dbed8"]] forState:UIControlStateHighlighted];
        [getVerifyBt setTitle:@"发送验证码" forState:UIControlStateNormal];
        [getVerifyBt setTitle:@"发送验证码" forState:UIControlStateNormal];
        getVerifyBt.userInteractionEnabled=YES;
        [timer invalidate];
        timer=nil;
    }
}
-(void)dataReuest{
    if (!([accountTF.text isKindOfClass:[NSString class]]&&accountTF.text.length>0)) {
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:nil message:@"请输入手机号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [al show];
        return;
    }
    paraDic=[NSMutableDictionary dictionary];
    [paraDic setObject:accountTF.text forKey:@"phone"];

    if (!timer) {
         count=120;
        timer=[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(scrollTimer) userInfo:nil repeats:YES];
        [timer fire];

        getVerifyBt.userInteractionEnabled=NO;
    }
    
    NSDictionary *parameters=@{@"phone":accountTF.text};
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText = @"验证码获取中";
    __weak __typeof(self) weakSelf = self;
    [MyRequest getRequestWithUrl:[HostMangager getValidateCodenUrl] andPara:parameters isAddUserId:NO Success:^(NSDictionary *dict, BOOL success) {
        [weakSelf.hud hide:YES];
        if ([dict isKindOfClass:[NSDictionary class]]&&[dict[@"errrorCode"] intValue]==200) {
            verifyCode=dict[@"data"];
            phoneSt=parameters[@"phone"];
        }else{
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:nil message:dict[@"msg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [al show];
        }
       
    } fail:^(NSError *error) {
        [weakSelf.hud hide:YES];
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:nil message:@"获取验证码失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [al show];
    }];
}
-(UIView*)textEditViewOfFrame:(CGRect)frame tag:(NSInteger)aTag text:(NSString*)aText accessibilityHint:(NSString*)accessibilityHint {
    UIView *aView=[[UIView alloc]initWithFrame:frame];
    aView.userInteractionEnabled=YES;
    aView.backgroundColor=[UIColor whiteColor];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, 49)];
    label.text=aText;
    label.backgroundColor=[UIColor whiteColor];
    [aView addSubview:label];
    
    UITextField *textFil=[[UITextField alloc]initWithFrame:CGRectMake(label.right, label.top, SCREEN_WIDTH-label.width-10, label.height)];
    textFil.userInteractionEnabled=YES;
    textFil.textColor=[UIColor grayColor];
    textFil.placeholder=accessibilityHint;
    textFil.tag=aTag;
    [aView addSubview:textFil];
    
    UILabel *lineLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, textFil.bottom, SCREEN_WIDTH-20, kMinPixels)];
    lineLabel.backgroundColor=[UIColor grayColor];
    [aView addSubview:lineLabel];
    
    return aView;
}

- (IBAction)nextBTTapped:(UIButton *)sender {
    NSString *inde=@"";
    if (!veriyTf.text||( [veriyTf.text isKindOfClass:[NSString class]]&&veriyTf.text.length==0)) {
       inde=@"请输入验证码";
    }
    if (!verifyCode) {
        inde=@"请先获取验证码";
    }
    
//    if (![veriyTf.text isEqualToString:verifyCode]) {//verifyCode 为 验证码发送成功！
//         inde=@"验证码不正确，请重试！";
//    }
    if (inde.length) {
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:nil message:inde delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [al show];
        
        return;
    }

    [paraDic setObject:veriyTf.text forKey:@"validationCode"];
    [paraDic setObject:accountTF.text forKey:@"phone"];
//    ResetPassViewController *rest=[[ResetPassViewController alloc]initWithNibName:@"ResetPassViewController" bundle:nil];
//    rest.dic=paraDic;
//    [self.navigationController pushViewController:rest animated:YES];
    
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
