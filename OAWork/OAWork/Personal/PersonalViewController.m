//
//  PersonalViewController.m
//  OAWork
//
//  Created by james on 2017/11/24.
//  Copyright © 2017年 james. All rights reserved.
//

#import "PersonalViewController.h"
#import "OaMainCellTableViewCell.h"
#import "ForgetPassWordViewController.h"
#import "PersonDetailViewController.h"
#import "User.h"
#import <MJRefresh/MJRefresh.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "NHPopoverViewController.h"
#import "TailoringViewController.h"
#import "WQAlert.h"
#import <AVFoundation/AVFoundation.h>
#import <AFNetworking/AFNetworking.h>
#import "SignViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"


@interface PersonalViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    UIButton *_bar;
    BOOL _isEdit;
    UIScrollView *backScroll;
    UIImageView *headImage;
    UITextField *nameTf;
    NHPopoverViewController *ReBacInfoView;
    UIImage *selectedimv;
    BOOL _isReviseHeadView;
    BOOL _isBoy;
    UIButton *firstBT;
    UIButton *secondBT;
    NSString *signPath;
    UITextField *phoneTf;
    UITextField *emailTf;
    UITextField *departTf;
    UIButton *reviseSignbt;
    UIButton *headBt;
    
}
@property (nonatomic,strong) NSMutableArray *allArray;
@property (nonatomic,strong) UIImageView *signImav;
@property (nonatomic,assign) BOOL isReviseSign;
@property (nonatomic,assign) BOOL hasRevised;

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isReviseHeadView=false;
    
     self.title=@"个人设置";
    _isEdit=false;
    _isReviseSign=false;
    NSString *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES)[0];
    signPath = [path stringByAppendingPathComponent:@"fileName"];
    self.navigationController.title=@"个人设置";
    [self createNaviTopBarWithShowBackBtn:false showTitle:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imgeFromLoacl) name:@"HEADiMAGEcHANGED" object:nil];
    
    backScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, TOPBARCONTENTHEIGHT+1, SCREEN_WIDTH, SCREEN_HEIGHT-BOTTOMBARHEIGHT)];
    backScroll.backgroundColor=[Utils colorWithHexString:@"#f7f7f7"];
    [self.view addSubview:backScroll];
    
    backScroll.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        
    }];
    
    UIView *headBack=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/3)];
    headBack.backgroundColor=[Utils colorWithHexString:@"#008fef"];
    [backScroll addSubview:headBack];
    
    headImage=[[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-186-10)/2, (headBack.height-86)/2, 86, 86)];
    [self imgeFromLoacl];
  
    [backScroll addSubview:headImage];
    
    
    
    nameTf=[[UITextField alloc]initWithFrame:CGRectMake(headImage.right+10, headImage.top+20, 100, 40)];
    nameTf.font=[UIFont systemFontOfSize:17.0f];
    nameTf.textAlignment=NSTextAlignmentLeft;
    nameTf.text=@"黄建新";
    nameTf.textColor=[Utils colorWithHexString:@"#ffffff"];
//    nameTf.text=[User shareUser].userName;
    [backScroll addSubview:nameTf];
    
    headBt=[[UIButton alloc]initWithFrame:CGRectMake(headImage.left, headImage.top, headImage.width, headImage.height)];
    headBt.backgroundColor=[UIColor clearColor];
    [headBt addTarget:self action:@selector(headBtTapped:) forControlEvents:UIControlEventTouchUpInside];
    [backScroll addSubview:headBt];
    

    
    firstBT=[[UIButton alloc]initWithFrame:CGRectMake(nameTf.left, nameTf.bottom+10,40, 16)];
    if (_isBoy) {
        [firstBT setImage:[UIImage imageNamed:@"b"] forState:UIControlStateNormal];
        [firstBT setImage:[UIImage imageNamed:@"b"] forState:UIControlStateHighlighted];
    }else{
        [firstBT setImage:[UIImage imageNamed:@"g_2"] forState:UIControlStateNormal];
        [firstBT setImage:[UIImage imageNamed:@"g_2"] forState:UIControlStateHighlighted];
    }
    [firstBT addTarget:self action:@selector(sexBtTapped:) forControlEvents:UIControlEventTouchUpInside];
    [backScroll addSubview:firstBT];
    
    secondBT=[[UIButton alloc]initWithFrame:CGRectMake(firstBT.right+20, firstBT.top,firstBT.width, firstBT.height)];
    if (_isBoy) {
        [secondBT setImage:[UIImage imageNamed:@"g"] forState:UIControlStateNormal];
        [secondBT setImage:[UIImage imageNamed:@"g"] forState:UIControlStateHighlighted];
    }else{
        [secondBT setImage:[UIImage imageNamed:@"g_2"] forState:UIControlStateNormal];
        [secondBT setImage:[UIImage imageNamed:@"g_2"] forState:UIControlStateHighlighted];
    }
    [secondBT addTarget:self action:@selector(sexBtTapped:) forControlEvents:UIControlEventTouchUpInside];
    secondBT.hidden=YES;
    [backScroll addSubview:secondBT];
    _hasRevised=false;
    _allArray = [@[@{@"name":@"手机号码",@"image":@"p"},@{@"name":@"邮箱",@"image":@"m"},@{@"name":@"部门",@"image":@"liuchengjiankong"},@{@"name":@"个人图章",@"image":@"z"}] mutableCopy];
    
    for (int d=0; d<_allArray.count; d++) {
        NSDictionary *dic=_allArray[d];
        UIView *smallBig=[[UIView alloc]initWithFrame:CGRectMake(0, 50*d+headBack.bottom, SCREEN_WIDTH, 50)];
        smallBig.backgroundColor=[UIColor whiteColor];
        [backScroll addSubview:smallBig];
        
        UIImageView *imav=[[UIImageView alloc]initWithFrame:CGRectMake(20,(smallBig.height-12)/2, 12, 12)];
        imav.image=[UIImage imageNamed:dic[@"image"]];
        imav.contentMode=UIViewContentModeScaleAspectFit;
        [smallBig addSubview:imav];
        
        UILabel *lb=[[UILabel alloc]initWithFrame:CGRectMake(imav.right+10, 0, 120, smallBig.height)];
        lb.font=[UIFont systemFontOfSize:14.0];
        lb.textColor=[UIColor blackColor];
        lb.text=dic[@"name"];
        [smallBig addSubview:lb];
        
        UITextField *nameTf=[[UITextField alloc]initWithFrame:CGRectMake(lb.right, lb.top, SCREEN_WIDTH-lb.right-20, lb.height)];
        nameTf.font=[UIFont systemFontOfSize:17.0f];
        nameTf.textAlignment=NSTextAlignmentRight;
        nameTf.text=@"19388766788";
       [smallBig addSubview:nameTf];

        if (d==0) {
            phoneTf=nameTf;
        }else if (d==1) {
            emailTf=nameTf;
            emailTf.text=@"fafaf@qq.com";
        }else if (d==2) {
            departTf=nameTf;
            departTf.text=@"人事部";
        }
        
        if (d==(_allArray.count-1)){
            nameTf.hidden=YES;
            _signImav=[[UIImageView alloc]initWithFrame:nameTf.frame];
            _signImav.image=[UIImage imageNamed:dic[@"image"]];
            NSData *imageData = [NSData dataWithContentsOfFile: signPath];
            if (imageData) {
                UIImage *image = [UIImage imageWithData: imageData];
                _signImav.image=image;
            }
            _signImav.contentMode=UIViewContentModeScaleAspectFit;
            [smallBig addSubview:_signImav];
            
            reviseSignbt=[[UIButton alloc]initWithFrame:nameTf.frame];
            reviseSignbt.backgroundColor=[UIColor clearColor];
            [reviseSignbt addTarget:self action:@selector(signVieTapped:) forControlEvents:UIControlEventTouchUpInside];
            [smallBig addSubview:reviseSignbt];
        }
        
        UIView *bottomStrait=[[UIView alloc]initWithFrame:CGRectMake(0,smallBig.height-1, smallBig.width, 1)];
        bottomStrait.backgroundColor=[Utils colorWithHexString:@"#e4e4e4"];
        if (d!=(_allArray.count-1)) {
            [smallBig addSubview:bottomStrait];
        }
    
    }
    UIButton *revisePass=[[UIButton alloc]initWithFrame:CGRectMake(0, 50*(_allArray.count)+headBack.bottom+30, SCREEN_WIDTH, 44)];
    revisePass.backgroundColor=[UIColor whiteColor];
    //    [revisePass setImage:[UIImage imageNamed:@"xiugaimima"] forState:UIControlStateNormal];
    //    [revisePass setImage:[UIImage imageNamed:@"xiugaimima"]  forState:UIControlStateHighlighted];
    //    [revisePass setTitle:@"修改密码" forState:UIControlStateNormal];
    //    [revisePass setTitle:@"修改密码" forState:UIControlStateHighlighted];
    //    [revisePass setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //     [revisePass setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [revisePass addTarget:self action:@selector(revisePass:) forControlEvents:UIControlEventTouchUpInside];
    [backScroll addSubview:revisePass];
    
    UIImageView *imav=[[UIImageView alloc]init];
    
    imav.image=[UIImage imageNamed:@"xiugaimima"];
    [revisePass addSubview:imav];
    
    UILabel *lb=[[UILabel alloc]init];
    
    lb.font=[UIFont systemFontOfSize:14.0];
    lb.textColor=[UIColor blackColor];
    lb.text=@"修改密码";
    [revisePass addSubview:lb];
    CGSize size=[Utils sizeWithText:lb.text font:lb.font maxSize:CGSizeMake(SCREEN_WIDTH, 100)];
    
    imav.frame=CGRectMake((SCREEN_WIDTH-size.width-30)/2, (44-14)/2, 14, 14);
    lb.frame=CGRectMake(imav.right+8, 0, size.width+10, 44);
    
    
    UIButton *loginOut=[[UIButton alloc]initWithFrame:CGRectMake(0, revisePass.bottom+10, SCREEN_WIDTH, 44)];
    loginOut.backgroundColor=[UIColor whiteColor];
    //    [revisePass setImage:[UIImage imageNamed:@"xiugaimima"] forState:UIControlStateNormal];
    //    [revisePass setImage:[UIImage imageNamed:@"xiugaimima"]  forState:UIControlStateHighlighted];
    //    [revisePass setTitle:@"修改密码" forState:UIControlStateNormal];
    //    [revisePass setTitle:@"修改密码" forState:UIControlStateHighlighted];
    //    [revisePass setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //     [revisePass setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [loginOut addTarget:self action:@selector(loginOut:) forControlEvents:UIControlEventTouchUpInside];
    [backScroll addSubview:loginOut];
    
    imav=[[UIImageView alloc]init];
    
    imav.image=[UIImage imageNamed:@"xiugaimima"];
    [loginOut addSubview:imav];
    
    lb=[[UILabel alloc]init];
    
    lb.font=[UIFont systemFontOfSize:14.0];
    lb.textColor=[UIColor blackColor];
    lb.text=@"退出登录";
    [loginOut addSubview:lb];
     size=[Utils sizeWithText:lb.text font:lb.font maxSize:CGSizeMake(SCREEN_WIDTH, 100)];
    
    imav.frame=CGRectMake((SCREEN_WIDTH-size.width-30)/2, (44-14)/2, 14, 14);
    lb.frame=CGRectMake(imav.right+8, 0, size.width+10, 44);
   
   
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText = @"数据获取中";
    __weak __typeof(self) weakSelf = self;
    [MyRequest getRequestWithUrl:[HostMangager projectNewUrl] andPara:nil isAddUserId:YES Success:^(NSDictionary *dict, BOOL success) {
        [weakSelf.hud hide:YES];
        
    } fail:^(NSError *error) {
        [weakSelf.hud hide:YES];
        
    }];

//    _demoTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, headBack.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-50)];
//    [_demoTableView registerNib:[UINib nibWithNibName:@"OaMainCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"OaMainCellTableViewCell"];
//    _demoTableView.delegate=self;
//    _demoTableView.dataSource=self;
//    _demoTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
//    [self.view addSubview:_demoTableView];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=true;
    if (!_bar) {
        _bar=[[UIButton alloc]init];
        [_bar setTitle:@"编辑" forState: UIControlStateNormal];
        [_bar setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_bar setTitle:@"编辑" forState: UIControlStateHighlighted];
        [_bar setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [_bar addTarget:self action:@selector(editTapped:) forControlEvents:UIControlEventTouchUpInside];
        _bar.frame=CGRectMake(SCREEN_WIDTH-60, 20, 60, 44);
        [self.view addSubview:_bar];
    }
    _bar.hidden=false;
}

-(void)editTapped:(UIButton*)bt{
    _isEdit=!_isEdit;
    if (_isEdit) {
        [bt setTitle:@"保存" forState:UIControlStateNormal];
        [bt setTitle:@"保存" forState:UIControlStateHighlighted];
        nameTf.userInteractionEnabled=YES;
        nameTf.layer.cornerRadius=5.0f;
        nameTf.layer.borderWidth=1.0f;
        nameTf.layer.borderColor=[UIColor greenColor].CGColor;
        nameTf.clipsToBounds=true;
        secondBT.hidden=false;
        if (_isBoy) {
            [firstBT setImage:[UIImage imageNamed:@"b"] forState:UIControlStateNormal];
            [firstBT setImage:[UIImage imageNamed:@"b"] forState:UIControlStateHighlighted];
            [secondBT setImage:[UIImage imageNamed:@"g"] forState:UIControlStateNormal];
            [secondBT setImage:[UIImage imageNamed:@"g"] forState:UIControlStateHighlighted];
        }else{
            [firstBT setImage:[UIImage imageNamed:@"b1"] forState:UIControlStateNormal];
            [firstBT setImage:[UIImage imageNamed:@"b1"] forState:UIControlStateHighlighted];
            [secondBT setImage:[UIImage imageNamed:@"g_2"] forState:UIControlStateNormal];
            [secondBT setImage:[UIImage imageNamed:@"g_2"] forState:UIControlStateHighlighted];
        }
        [headBt setUserInteractionEnabled: true];
        [phoneTf setUserInteractionEnabled: true];
         [emailTf setUserInteractionEnabled:true];
         [departTf setUserInteractionEnabled:true];
        [reviseSignbt setUserInteractionEnabled:true];
       
    }else{
        if (_isReviseHeadView) {
            [self uploadAttach];
        }
        _hasRevised=true;
        if (_hasRevised) {
            self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            self.hud.labelText = @"数据提交中";
            __weak __typeof(self) weakSelf = self;
            [MyRequest getRequestWithUrl:[HostMangager projectNewUrl] andPara:nil isAddUserId:YES Success:^(NSDictionary *dict, BOOL success) {
                [weakSelf.hud hide:YES];
                
            } fail:^(NSError *error) {
                [weakSelf.hud hide:YES];
                
            }];
        }
        nameTf.userInteractionEnabled=false;
        nameTf.layer.cornerRadius=0.0f;
        nameTf.layer.borderWidth=0.0f;
        [bt setTitle:@"编辑" forState:UIControlStateNormal];
        [bt setTitle:@"编辑" forState:UIControlStateHighlighted];
        secondBT.hidden=true;
        if (_isBoy) {
            [firstBT setImage:[UIImage imageNamed:@"b"] forState:UIControlStateNormal];
            [firstBT setImage:[UIImage imageNamed:@"b"] forState:UIControlStateHighlighted];
       }else{
            [firstBT setImage:[UIImage imageNamed:@"g_2"] forState:UIControlStateNormal];
            [firstBT setImage:[UIImage imageNamed:@"g_2"] forState:UIControlStateHighlighted];
           
        }
        [headBt setUserInteractionEnabled: false];
        [phoneTf setUserInteractionEnabled:false];
        [emailTf setUserInteractionEnabled:false];
        [departTf setUserInteractionEnabled:false];
        [reviseSignbt setUserInteractionEnabled:false];
    }
    
    
}
-(void)imgeFromLoacl{
    
    [headImage sd_setImageWithURL:[NSURL URLWithString:[Utils getNotNullNotNill:[User shareUser].icon]] placeholderImage:[UIImage imageNamed:@"u"]];
    headImage.layer.cornerRadius=headImage.width/2;
    headImage.clipsToBounds=YES;
}
-(void)headBtTapped:(UIButton*)bt{
    [self.view endEditing:YES];
    if (!ReBacInfoView) {
        UIView *headTapPopView=[[UIView alloc]initWithFrame:CGRectMake(20, 0,SCREEN_WIDTH-40, 120)];
        NSArray *titles=@[@"从手机相册中选择",@"拍一张图片",@"取消"];
        for (int d=0; d<titles.count; d++) {
            UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
            [button2 setTitle:titles[d] forState:UIControlStateNormal];
            [button2 setTitle:titles[d] forState:UIControlStateHighlighted];
            button2.tag=1000+d;
            [button2 setTitleColor:[Utils colorWithHexString:@"#363636"] forState:UIControlStateNormal];
            [button2 addTarget:self action:@selector(chooseImage:)
              forControlEvents:UIControlEventTouchUpInside];
            button2.frame=CGRectMake(0,40*d, headTapPopView.width, 40);
            [headTapPopView addSubview:button2];
            UIView *bottomStrait=[[UIView alloc]initWithFrame:CGRectMake(0,headTapPopView.bottom-1, headTapPopView.width, 1)];
            bottomStrait.backgroundColor=[Utils colorWithHexString:@"#e4e4e4"];
            if (d!=(titles.count-1)) {
                [headTapPopView addSubview:bottomStrait];
            }
            
        }
         ReBacInfoView = [[NHPopoverViewController alloc] initWithView:headTapPopView contentSize:headTapPopView.frame.size autoClose:FALSE];
       
    }
  [ReBacInfoView show];
}
-(void)chooseImage:(UIButton*)bt{
    
    if (bt.tag==1000) {
    
        [self selecteFromLib];
    }else if (bt.tag==1001) {
            [self takePic];
    }
    [ReBacInfoView dismiss];
    ReBacInfoView=nil;
}
-(void)sexBtTapped:(UIButton*)bt{
    if (bt==firstBT) {
        _isBoy=true;
        
    }else{
        _isBoy=false;
    }
    if (_isBoy) {
        [firstBT setImage:[UIImage imageNamed:@"b"] forState:UIControlStateNormal];
        [firstBT setImage:[UIImage imageNamed:@"b"] forState:UIControlStateHighlighted];
        [secondBT setImage:[UIImage imageNamed:@"g"] forState:UIControlStateNormal];
        [secondBT setImage:[UIImage imageNamed:@"g"] forState:UIControlStateHighlighted];
    }else{
        [firstBT setImage:[UIImage imageNamed:@"b1"] forState:UIControlStateNormal];
        [firstBT setImage:[UIImage imageNamed:@"b1"] forState:UIControlStateHighlighted];
        [secondBT setImage:[UIImage imageNamed:@"g_2"] forState:UIControlStateNormal];
        [secondBT setImage:[UIImage imageNamed:@"g_2"] forState:UIControlStateHighlighted];
    }
}
-(void)revisePass:(UIButton*)bt{
    
    UIViewController *avc=[[ForgetPassWordViewController alloc]initWithNibName:@"ForgetPassWordViewController" bundle:nil];
 
    [self.navigationController pushViewController:avc animated:YES];
}
-(void)loginOut:(UIButton*)bt{
    LoginViewController *login=[[LoginViewController alloc]init];
    
     UINavigationController* navi=[AppDelegate shareAppDeleage].navi ;
    
    navi.viewControllers=@[login];
    [navi popToViewController:login animated:YES];
    
}
-(void)signVieTapped:(UIButton*)bt{
    SignViewController *svct=[[SignViewController alloc]init];
      __weak __typeof(self) weakSelf = self;
    [svct signResultWithBlock:^(UIImage *signImage) {
      
        
        NSData *data = UIImagePNGRepresentation(signImage);
        BOOL isscuess= [data writeToFile:signPath atomically:YES];
        
        if (isscuess) {
            NSLog(@"bao chun cheng gong");
            _isReviseHeadView=YES;
        }
        weakSelf.signImav.image=signImage;
        weakSelf.isReviseSign=true;
    }];
    [self.navigationController presentViewController:svct animated:YES completion:nil];
    
}
-(void)takePic{
    {
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            if ([self checkCameraAuthorization]) {
                UIImagePickerController* picker = [[UIImagePickerController alloc] init];
                picker.delegate = self;
                picker.sourceType = sourceType;
                if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
                    self.modalPresentationStyle=UIModalPresentationOverCurrentContext;
                }
                [self presentViewController:picker animated:YES completion:^{
                }];
            }
        }
    }
}
-(void)selecteFromLib{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    UIImagePickerController* picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = sourceType;
    if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
        self.modalPresentationStyle=UIModalPresentationOverCurrentContext;
    }
    [self presentViewController:picker animated:YES completion:^{
    }];
    
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    TailoringViewController* tailoringVC = [[TailoringViewController alloc] init];
    tailoringVC.sourceImage  = info[UIImagePickerControllerOriginalImage];
    tailoringVC.picker = picker;
    tailoringVC.myBlockImage = ^ (UIImage* image){
        headImage.image = image;
        selectedimv=image;
        NSString *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES)[0];
        path = [path stringByAppendingPathComponent:@"fileName"];
        
        NSData *data = UIImagePNGRepresentation(image);
        BOOL isscuess= [data writeToFile:path atomically:YES];
        
        if (isscuess) {
            NSLog(@"bao chun cheng gong");
            _isReviseHeadView=YES;
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"HEADiMAGEcHANGED" object:nil];
    };
    [picker pushViewController:tailoringVC animated:YES];
}

- (BOOL)checkCameraAuthorization
{
    BOOL isAvalible = YES;
    //ios 7.0以上的系统新增加摄像头权限检测
    if ([Utils isIOS7]) {
        //获取对摄像头的访问权限。
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        switch (authStatus) {
            case AVAuthorizationStatusRestricted:
                break;
            case AVAuthorizationStatusDenied:
                isAvalible = NO;
                break;
            case AVAuthorizationStatusAuthorized:
                break;
            case AVAuthorizationStatusNotDetermined:
                isAvalible =[UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
                break;
            default:
                break;
        }
    }
    if (!isAvalible) {
        NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
        NSString *appName =[infoDict objectForKey:@"CFBundleDisplayName"];
        [WQAlert showAlertViewControllerWithTitle:@"" message:[NSString stringWithFormat:@"您关闭了%@的相机权限，无法进行拍照。可以在手机 > 设置 > 隐私 > 相机中开启权限。", appName] buttonTitles:@[@"确定"] showViewController:self completionBlock:^(int index) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] ];
            
        } cancleBlock:^{
            
        } preferredStyle:UIAlertControllerStyleAlert];
        
    }
    return isAvalible;
}
-(void)uploadAttach{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //接收类型不一致请替换一致text/html或别的
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    
    [dic  setObject:@"image" forKey:@"fileType"];
//    @"http:///mobile/file/upload.jhtml";
    NSURLSessionDataTask *task = [manager POST:@"http://120.78.204.130/oa/file/upload" parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
//                    NSData *data = UIImagePNGRepresentation(selectedimv);
        float kCompressionQuality = 0.3;
        NSData *data = UIImageJPEGRepresentation(selectedimv, kCompressionQuality);
        [formData appendPartWithFileData:data name:@"uploadFiles" fileName:[NSString stringWithFormat:@"%@.jpg",[Utils randomUUID]] mimeType:@"application/octet-stream"];
//
        
    } progress:^(NSProgress *_Nonnull uploadProgress) {
        NSLog(@"上传进度%@",uploadProgress);
        //打印下上传进度
    } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        //上传成功
        if ([responseObject isKindOfClass:[NSDictionary class]]&&[responseObject[@"errrorCode"] intValue]==200) {
            if ([responseObject[@"data"] isKindOfClass:[NSArray class]]&&[responseObject[@"data"] count] >0) {
                
            }
            
        }
        
        NSLog(@"上传成功%@",responseObject);
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError * _Nonnull error) {
        //上传失败
        NSLog(@"上传失败");
    }];
    [task  resume];
}
#pragma mark UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *avc;
    if (indexPath.row==0) {
        avc=[[PersonDetailViewController alloc]initWithNibName:@"PersonDetailViewController" bundle:nil];

    }else if (indexPath.row==1) {
        avc=[[ForgetPassWordViewController alloc]initWithNibName:@"ForgetPassWordViewController" bundle:nil];

    }
    if (avc) {
        [self.navigationController pushViewController:avc animated:YES];
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static  NSString  *CellIdentiferId = @"OaMainCellTableViewCell";
    OaMainCellTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentiferId];
    if (cell == nil) {
        cell=[[OaMainCellTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentiferId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    };
    cell.titleLB.text=_allArray[indexPath.row];
    cell.imageView.image=[UIImage imageNamed:@"wifi"];
    return  cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _allArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
    
}
-(BOOL)shouldAutorotate{
    return NO;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
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
