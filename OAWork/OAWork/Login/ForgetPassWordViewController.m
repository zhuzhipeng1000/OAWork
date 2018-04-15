//
//  ForgetPassWordViewController.m
//  ProductAduit
//
//  Created by JIME on 2017/1/15.
//  Copyright © 2017年 JIME. All rights reserved.
//

#import "ForgetPassWordViewController.h"
#import "LoginViewController.h"

@interface ForgetPassWordViewController ()
{

    UITextField *textFil;
    UITextField *confirmtf;
    UITextField *reConfirmtf;
    UIButton *loginbt;
    NSMutableDictionary *paraDic;
}

@end

@implementation ForgetPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"修改密码";
    UIView *backview=[[UIView alloc]initWithFrame:CGRectMake(00, TOPBARCONTENTHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-TOPBARCONTENTHEIGHT)];
    backview.backgroundColor=[Utils colorWithHexString:@"#f7f7f7"];
    [self.view addSubview:backview];
    
    UILabel *titleLB=[[UILabel alloc]init];
    titleLB.text=@"  修改个人登陆密码";
    titleLB.font=[UIFont systemFontOfSize:14.0F];
    titleLB.textColor=[Utils colorWithHexString:@"#f7f7f7"];
    titleLB.frame=CGRectMake(0, TOPBARCONTENTHEIGHT, SCREEN_WIDTH, 44);
    titleLB.textColor=[Utils colorWithHexString:@"#898989"];
    [self.view addSubview:titleLB];
   
    UIView *Aview=[[UIView alloc]initWithFrame:CGRectMake(0, titleLB.bottom, SCREEN_WIDTH, 50)];
    Aview.backgroundColor=[Utils colorWithHexString:@"#ffffff"];
    [self.view addSubview:Aview];
    
    textFil=[[UITextField alloc]initWithFrame:CGRectMake(20, titleLB.bottom, SCREEN_WIDTH-20, 50)];
    textFil.userInteractionEnabled=YES;
    textFil.textColor=[UIColor grayColor];
      textFil.font=[UIFont systemFontOfSize:14.0F];
    textFil.placeholder=@" 请输入登录密码";
    textFil.backgroundColor=[Utils colorWithHexString:@"#ffffff"];
    [self.view addSubview:textFil];
    
    UIView *sview=[[UIView alloc]initWithFrame:CGRectMake(0, textFil.bottom+20, SCREEN_WIDTH, 50)];
    sview.backgroundColor=[Utils colorWithHexString:@"#ffffff"];
    [self.view addSubview:sview];
    
    confirmtf=[[UITextField alloc]initWithFrame:CGRectMake(20, textFil.bottom+20, SCREEN_WIDTH-40, 50)];
    confirmtf.userInteractionEnabled=YES;
    confirmtf.textColor=[UIColor grayColor];
    confirmtf.placeholder=@" 请输入新密码";
    confirmtf.font=[UIFont systemFontOfSize:14.0F];
    confirmtf.backgroundColor=[Utils colorWithHexString:@"#ffffff"];
    [self.view addSubview:confirmtf];
    
    UIView *tview=[[UIView alloc]initWithFrame:CGRectMake(0, confirmtf.bottom+1, SCREEN_WIDTH, 50)];
    tview.backgroundColor=[Utils colorWithHexString:@"#ffffff"];
    [self.view addSubview:tview];
    
    reConfirmtf=[[UITextField alloc]initWithFrame:CGRectMake(20, confirmtf.bottom+1, SCREEN_WIDTH-40, 50)];
    reConfirmtf.userInteractionEnabled=YES;
    reConfirmtf.textColor=[UIColor grayColor];
    reConfirmtf.font=[UIFont systemFontOfSize:14.0F];
    reConfirmtf.placeholder=@" 请再次输入新密码";
    reConfirmtf.backgroundColor=[Utils colorWithHexString:@"#ffffff"];
    [self.view addSubview:reConfirmtf];
    
    
    loginbt=[[UIButton alloc]initWithFrame:CGRectMake(40, reConfirmtf.bottom+20, SCREEN_WIDTH-80, 45)];
    [loginbt setTitle:@"确 定" forState:UIControlStateNormal];
    [loginbt setTitle:@"确 定" forState:UIControlStateNormal];
    [loginbt setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    [loginbt setTitleColor:[UIColor whiteColor]  forState:UIControlStateHighlighted];
    [loginbt setBackgroundImage:[Utils createImageWithColor:[Utils colorWithHexString:@"#008fef"]] forState:UIControlStateNormal];
    [loginbt setBackgroundImage:[Utils createImageWithColor:[Utils colorWithHexString:@"#008fef"]] forState:UIControlStateHighlighted];

    loginbt.clipsToBounds=YES;
    loginbt.layer.cornerRadius=loginbt.height/2;
    [loginbt addTarget:self action:@selector(nextBTTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginbt];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
}

-(void)dataReuest{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText = @"数据提交中";
    __weak __typeof(self) weakSelf = self;
    [MyRequest getRequestWithUrl:[HostMangager resetPasswdUrl] andPara:@{@"newPwd":reConfirmtf.text,@"account":self.account} isAddUserId:YES Success:^(NSDictionary *dict, BOOL success) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.view makeToast:@"修改成功" duration:1 position:CSToastPositionCenter];
            [weakSelf.navigationController popViewControllerAnimated:YES];
            [weakSelf.hud hide:YES];
        });
        
        
    } fail:^(NSError *error) {
        [weakSelf.hud hide:YES];
        
    }];
}

- (IBAction)nextBTTapped:(UIButton *)sender {

    if (!textFil.text.length||!confirmtf.text.length||!reConfirmtf.text.length) {
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:nil message:@"请输入完整信息" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [al show];
        return;
    }if (![confirmtf.text isEqualToString:reConfirmtf.text]) {
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:nil message:@"两次密码不一致" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [al show];
        return;
    }else{
        [self dataReuest];
    }
  
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
