//
//  NeedDoViewController.m
//  OAWork
//
//  Created by james on 2017/11/30.
//  Copyright © 2017年 james. All rights reserved.
//

#import "NeedDoViewController.h"
#import "NeedDoTableViewCell.h"
#import "OAJobDetailViewController.h"
#import "YZNavigationMenuView.h"
#import "NHPopoverViewController.h"

@interface NeedDoViewController ()<YZNavigationMenuViewDelegate>{
        NHPopoverViewController *ReBacInfoView;
    UITextView *_contetnView;
    UITextView *tf;
}
@property (nonatomic ,strong) NSMutableArray *exampleArr; //用于普通显示的数据
@property (nonatomic ,strong)NSMutableArray *searchArr; //用于搜索后显示的数据
@property (nonatomic,strong) NSMutableArray *allArray;//服务返回的数据
@property (nonatomic,strong) UIScrollView* scrollView;
@end

@implementation NeedDoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"请假审批";
    self.view.backgroundColor=[Utils colorWithHexString:@"#f7f7f7"];
    NSURL *dect=[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL * documentProtocolUrl =  [dect URLByAppendingPathComponent:@"www/aa.tt"];
    
    NSString* jsonS=[NSString stringWithContentsOfURL:documentProtocolUrl encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"jsonS%@",jsonS);
    NSDictionary *dic=[jsonS objectFromCTJSONString];
    //    self.title=dic[@"result"][@"docName"];
    NSArray *viewInfoArray=dic[@"result"][@"lines"];
    int topHeight=0;
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, TOPBARCONTENTHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-TOPBARCONTENTHEIGHT)];
    _scrollView.showsVerticalScrollIndicator=false;
    [self.view addSubview:_scrollView];
    viewInfoArray=@[@{@"name":@"姓名",@"value":@"张三"},@{@"name":@"部门",@"value":@"测试部"},@{@"name":@"请假类型",@"value":@"事假"},@{@"name":@"请假天数",@"value":@"1天"},@{@"name":@"开始时间",@"value":@"2017-12-30 12:30"},@{@"name":@"结束时间",@"value":@"2017-12-32 22:00"},@{@"name":@"请假事由",@"value":@"因故请假因故请假因故请假因故请假因故因故请假因故请假因故请假因故请假因故因故请假因故请假因故请假因故请假因故因故请假因故请假因故请假因故请假因故因故请假因故请假因故请假因故请假因故因故请假因故请假因故请假因故"},@{@"name":@"外出时间",@"value":@"2017-12-01"},@{@"name":@"外出地点",@"value":@"广州市教育局"},@{@"name":@"外借出证件类型",@"value":@"营业执照"},@{@"name":@"经费来源",@"value":@"广州市教育局"},@{@"name":@"外出地点",@"value":@"广州市教育局"},@{@"name":@"附件",@"value":@""}];
    
    for (int d=0; d<viewInfoArray.count; d++) {
        NSDictionary *detaiDic=viewInfoArray[d];
        UIView *areaView=[[UIView alloc] initWithFrame: CGRectMake(0,topHeight, SCREEN_WIDTH, 30)];
        
        areaView.backgroundColor=[UIColor whiteColor];
        [_scrollView addSubview:areaView];
        
        UILabel *titleLB=[[UILabel alloc]init];
        titleLB.text=detaiDic[@"name"];
        titleLB.font=[UIFont systemFontOfSize:14.0F];
        titleLB.textColor=[UIColor blackColor];
        [areaView addSubview:titleLB];
        CGSize textSize=  [Utils sizeWithText:titleLB.text font:titleLB.font maxSize:CGSizeMake(areaView.width, 30)];
        
        titleLB.frame=CGRectMake(20,5, textSize.width+10, textSize.height);
//        CGRect nextFrame=CGRectMake(titleLB.right, titleLB.top, areaView.width-titleLB.right-20, titleLB.height);
        
//        if ([detaiDic[@"type"] isEqualToString:@"area"]) {
            UILabel *detaiLb=[[UILabel alloc]init];
            detaiLb.backgroundColor=[UIColor clearColor];
            detaiLb.numberOfLines=0;
            detaiLb.font=[UIFont systemFontOfSize:14.0f];
            detaiLb.lineBreakMode=NSLineBreakByWordWrapping;
            detaiLb.textAlignment=NSTextAlignmentLeft;
            detaiLb.text=detaiDic[@"value"];
            areaView.backgroundColor=[Utils colorWithHexString:@"#f7f7f7"];
            textSize=  [Utils sizeWithText:detaiLb.text font:detaiLb.font maxSize:CGSizeMake(SCREEN_WIDTH-titleLB.right-50,200)];
//            if (textSize.height<30) {
//                textSize.height=30;
//            }
        [areaView addSubview:detaiLb];
        
       
        
        detaiLb.frame=CGRectMake(titleLB.right+10,5,SCREEN_WIDTH-textSize.width,textSize.height);
        
        areaView.frame=CGRectMake(0,topHeight, SCREEN_WIDTH, detaiLb.height+10);
//        }
        UIView *lineView=[[UIView alloc]init];
        lineView.frame=CGRectMake(0, areaView.height-1, SCREEN_WIDTH, 1);
        lineView.backgroundColor=[UIColor whiteColor];
        
        topHeight=topHeight+areaView.height;
    }
    NSArray *attachs=dic[@"result"][@"attachs"];
    attachs=@[@{@"type":@"1",@"fileName":@"张三"},@{@"type":@"0",@"fileName":@"测试部"},@{@"type":@"2",@"fileName":@"事假"}];
    
    for (int d=0; d<attachs.count; d++) {
        NSDictionary *detaiDic=attachs[d];
        UIView *areaView=[[UIView alloc] initWithFrame: CGRectMake(0,topHeight, SCREEN_WIDTH, 30)];
        
        areaView.backgroundColor=[UIColor clearColor];
        [_scrollView addSubview:areaView];
        
        UIImageView *leftImage=[[UIImageView alloc]init];
        leftImage.contentMode=UIViewContentModeScaleAspectFit;
        [leftImage setImage:[UIImage imageNamed:@"w"]];
        [areaView addSubview:leftImage];
        
        
        UILabel *titleLB=[[UILabel alloc]init];
        titleLB.text=detaiDic[@"fileName"];
        titleLB.font=[UIFont systemFontOfSize:14.0F];
        titleLB.textColor=[UIColor blackColor];
        [areaView addSubview:titleLB];
        CGSize textSize=  [Utils sizeWithText:titleLB.text font:titleLB.font maxSize:CGSizeMake(areaView.width-80, 60)];//20+20+20+20
        if (textSize.height<40) {
            textSize.height=40;
        }else{
            textSize.height=textSize.height+5;
        }
        leftImage.frame=CGRectMake(20,(textSize.height-20)/2, 20, 20);
        titleLB.frame=CGRectMake(leftImage.right,0, textSize.width, textSize.height);
        areaView.frame=CGRectMake(0,topHeight, SCREEN_WIDTH, titleLB.bottom);
        
        UIImageView *_accessImage=[[UIImageView alloc]initWithFrame:CGRectMake(areaView.width-40, (titleLB.height-20)/2, 20, 20)];
        _accessImage.contentMode=UIViewContentModeScaleAspectFit;
        [_accessImage setImage:[UIImage imageNamed:@"arrow_down"]];
        [areaView addSubview:_accessImage];
        _accessImage.transform=CGAffineTransformMakeRotation((M_PI_2*3));// 像右往左转
        _accessImage.transform=CGAffineTransformScale(_accessImage.transform, 0.5, 0.5);
        
        UIButton *bt=[[UIButton alloc]initWithFrame:areaView.bounds];
        [bt addTarget:self action:@selector(accessBtTaped:) forControlEvents:UIControlEventTouchUpInside];
        [areaView addSubview:bt];
        topHeight=topHeight+areaView.height;
    }
    NSArray *signs=dic[@"result"][@"signs"];
    attachs=@[@{@"Step":@"经理审批",@"content":@"统一大伟大"},@{@"Step":@"部门审批",@"content":@"不错，可以，同意"},@{@"Step":@"CEO",@"content":@"同意"}];
    
    for (int d=0; d<attachs.count; d++) {
        
        NSDictionary *detaiDic=attachs[d];
        UIView *areaView=[[UIView alloc] initWithFrame: CGRectMake(0,topHeight, SCREEN_WIDTH, 100)];
        
        areaView.backgroundColor=[UIColor whiteColor];
        [_scrollView addSubview:areaView];
        
        UILabel *titleLB=[[UILabel alloc]init];
        titleLB.text=detaiDic[@"Step"];//审批环节的名称（
        titleLB.font=[UIFont systemFontOfSize:14.0F];
        titleLB.textColor=[UIColor blackColor];
        titleLB.frame=CGRectMake(20,0,SCREEN_WIDTH-40,40);
        [areaView addSubview:titleLB];
        
        UILabel *contetnt=[[UILabel alloc]init];
        contetnt.text=detaiDic[@"content"];//（
        contetnt.font=[UIFont systemFontOfSize:14.0F];
        contetnt.textAlignment=NSTextAlignmentLeft;
        contetnt.textColor=[UIColor blackColor];
        contetnt.frame=CGRectMake(20,titleLB.bottom,SCREEN_WIDTH-40,40);
        [areaView addSubview:contetnt];
    
        CGSize textSize=  [Utils sizeWithText:contetnt.text font:contetnt.font maxSize:CGSizeMake(areaView.width-40, 100)];
        if (textSize.height<30) {
            textSize.height=30;
        }else{
            textSize.height=textSize.height+5;
        }
        contetnt.frame=CGRectMake(20,titleLB.bottom, textSize.width, textSize.height);
       
    
       
        
        UIImageView *signImage=[[UIImageView alloc]initWithFrame:CGRectMake(areaView.width-73, contetnt.bottom, 53, 26)];
        signImage.contentMode=UIViewContentModeScaleAspectFit;
        [signImage setImage:[UIImage imageNamed:@"arrow_down"]];
        NSString *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES)[0];
       NSString* signPath = [path stringByAppendingPathComponent:@"fileName"];
        UIImage *imv=[UIImage imageWithContentsOfFile:signPath];
        if (imv) {
            signImage.image=imv;
        }
        [areaView addSubview:signImage];
        
      
        UILabel *timeLb=[[UILabel alloc]init];
        timeLb.text=@"2017-13-12 19:23";//审批环节的名称（
        timeLb.font=[UIFont systemFontOfSize:14.0F];
        timeLb.textColor=[UIColor blackColor];
        timeLb.frame=CGRectMake(SCREEN_WIDTH-120,signImage.bottom+10,100,25);
        [areaView addSubview:timeLb];
        
         areaView.frame=CGRectMake(0,topHeight, SCREEN_WIDTH, timeLb.bottom+10);
        topHeight=topHeight+areaView.height;
    }
    
    UIView *areaView=[[UIView alloc] initWithFrame: CGRectMake(0,topHeight, SCREEN_WIDTH, 100)];
    
    areaView.backgroundColor=[UIColor clearColor];
    [_scrollView addSubview:areaView];
    
    UILabel *curentstepLB=[[UILabel alloc]init];
    curentstepLB.text=@"部门意见";//审批环节的名称（
    curentstepLB.font=[UIFont systemFontOfSize:14.0F];
    curentstepLB.textColor=[UIColor blackColor];
    curentstepLB.frame=CGRectMake(20,0,SCREEN_WIDTH-40,40);
    [areaView addSubview:curentstepLB];
    
    _contetnView=[[UITextView alloc]init];
    _contetnView.frame=CGRectMake(5, curentstepLB.bottom, SCREEN_WIDTH-100, areaView.height-10);
    [areaView addSubview:_contetnView];
    
    UIView *smallView=[[UIView alloc]initWithFrame:CGRectMake(areaView.width-90, areaView.height-38, 70, 28)];
    smallView.layer.cornerRadius=smallView.height/2;
    smallView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    smallView.layer.borderWidth=1.0f;
    [areaView addSubview:smallView];
    
    UIImageView *signImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, (smallView.height-13)/2, 13, 13)];
    signImage.contentMode=UIViewContentModeScaleAspectFit;
    [signImage setImage:[UIImage imageNamed:@"pen"]];
    [smallView addSubview:signImage];
    
    UILabel *signLb=[[UILabel alloc]init];
    signLb.text=@"签名";//审批环节的名称（
    signLb.font=[UIFont systemFontOfSize:14.0F];
    signLb.textColor=[Utils colorWithHexString:@"#08ba06"];
    signLb.frame=CGRectMake(signImage.right+5,0,smallView.width-signImage.right,smallView.height);
    [smallView addSubview:signLb];
    
    UIButton *signBt=[[UIButton alloc]initWithFrame:areaView.bounds];
    signBt.backgroundColor=[UIColor clearColor];
    [signBt addTarget:self action:@selector(signBttaped:) forControlEvents:UIControlEventTouchUpInside];
    [areaView addSubview:signBt];
    
    
    
    UILabel *titleLB=[[UILabel alloc]init];
    NSMutableAttributedString *nameString = [[NSMutableAttributedString alloc] initWithString:@"当前环节：" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[Utils colorWithHexString:@"#363636"]}];
    NSAttributedString *countString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",@"分管领导审批"] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[Utils colorWithHexString:@"#08ba06"]}];
    [nameString appendAttributedString:countString];
   
    titleLB.attributedText=nameString;
    titleLB.frame=CGRectMake(20,areaView.bottom+20,(SCREEN_WIDTH)/2-20,40);
    [_scrollView addSubview:titleLB];
    
    UILabel *nextLb=[[UILabel alloc]init];
    NSMutableAttributedString *nextString = [[NSMutableAttributedString alloc] initWithString:@"下一环节：" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[Utils colorWithHexString:@"#363636"]}];
    NSAttributedString *detailString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",@"人力审批"] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[Utils colorWithHexString:@"#08ba06"]}];
    [nextString appendAttributedString:detailString];
    
    nextLb.attributedText=nextString;
    nextLb.textAlignment=NSTextAlignmentRight;
    nextLb.frame=CGRectMake((SCREEN_WIDTH)/2,titleLB.top,(SCREEN_WIDTH)/2-20,40);
    [_scrollView addSubview:nextLb];
    
    UIButton *sendbt=[[UIButton alloc]initWithFrame:CGRectMake(40,nextLb.bottom+30, SCREEN_WIDTH-80, 44)];
    sendbt.backgroundColor=[Utils colorWithHexString:@"#008fef"];
    //    [revisePass setImage:[UIImage imageNamed:@"xiugaimima"] forState:UIControlStateNormal];
    //    [revisePass setImage:[UIImage imageNamed:@"xiugaimima"]  forState:UIControlStateHighlighted];
        [sendbt setTitle:@"发送" forState:UIControlStateNormal];
        [sendbt setTitle:@"发送" forState:UIControlStateHighlighted];
        [sendbt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
         [sendbt setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [sendbt addTarget:self action:@selector(sendbttaped:) forControlEvents:UIControlEventTouchUpInside];
    sendbt.layer.cornerRadius=sendbt.height/2;
    sendbt.clipsToBounds=true;
    [_scrollView addSubview:sendbt];
    
    
    _scrollView.contentSize=CGSizeMake(SCREEN_WIDTH, sendbt.bottom+30);
    
    // Do any additional setup after loading the view from its nib.
}
-(void)accessBtTaped:(UIButton*)BT{
    
    
}
-(void)sendbttaped:(UIButton*)BT{
    
    
}
-(void)signBttaped:(UIButton*)bt{
    
    [self showReBacInfoView];
}
- (void)showReBacInfoView{
    if (!ReBacInfoView) {
        UIView *aView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-40, 240)];
        aView.backgroundColor=[UIColor whiteColor];
        
        UILabel *titleLb=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, aView.width-80, 40)];
        titleLb.text=@"评论详细";
        titleLb.textColor=[UIColor lightGrayColor];
        [aView addSubview:titleLb];
        
        UIImageView *imv=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"x"]];
        
        imv.frame=CGRectMake(aView.width-16-titleLb.left,titleLb.top+(titleLb.height-16)/2 , 16, 16);
        [aView addSubview:imv];
        
        UIButton *bt=[[UIButton alloc]init];
        //        [bt setImage:[UIImage imageNamed:@"x"]  forState: UIControlStateNormal];
        //        [bt setTitleColor:[Utils colorWithHexString:@"#008fef"] forState:UIControlStateNormal];
        //        [bt setImage:[UIImage imageNamed:@"x"]  forState: UIControlStateHighlighted];
        //        bt.titleLabel.font=[UIFont boldSystemFontOfSize:24];
        //        [bt setTitleColor:[Utils colorWithHexString:@"#008fef"] forState:UIControlStateHighlighted];
        [bt addTarget:self action:@selector(cancelBtTapped:) forControlEvents:UIControlEventTouchUpInside];
        bt.frame=CGRectMake(titleLb.right, titleLb.top, aView.width-titleLb.right, titleLb.height);
        [aView addSubview:bt];
        
        tf=[[UITextView alloc]init];
        tf.font=[UIFont systemFontOfSize:14.0f];
        tf.textColor=[UIColor blackColor];
        tf.layer.cornerRadius=5.0f;
        tf.layer.borderWidth=0.5;
        tf.layer.borderColor=[Utils colorWithHexString:@"#b7b7b7"].CGColor;
        tf.frame=CGRectMake(titleLb.left, titleLb.bottom, aView.width-2*(titleLb.left), 100);
        [aView addSubview:tf];
        
        UIButton *confirmBt=[[UIButton alloc]init];
        [confirmBt setTitle:@"确  认" forState: UIControlStateNormal];
        [confirmBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [confirmBt setTitle:@"确  认" forState: UIControlStateHighlighted];
        confirmBt.titleLabel.font=[UIFont boldSystemFontOfSize:16];
        [confirmBt setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [confirmBt setBackgroundImage:[Utils createImageWithColor:[Utils colorWithHexString:@"#008fef"]] forState:UIControlStateNormal];
        [confirmBt setBackgroundImage:[Utils createImageWithColor:[Utils colorWithHexString:@"#008fef"]] forState:UIControlStateHighlighted];
        [confirmBt addTarget:self action:@selector(confirmedTapped:) forControlEvents:UIControlEventTouchUpInside];
        confirmBt.layer.cornerRadius=titleLb.height/2;
        confirmBt.clipsToBounds=true;
        confirmBt.frame=CGRectMake(tf.left+20, tf.bottom+20, aView.width-2*(tf.left+20), titleLb.height);
        [aView addSubview:confirmBt];
        ReBacInfoView = [[NHPopoverViewController alloc] initWithView:aView contentSize:aView.frame.size autoClose:FALSE];
    }
    if (_contetnView.text) {
        tf.text=_contetnView.text;
    }
    
    [ReBacInfoView show];
    
}
-(void)cancelBtTapped:(UIButton*)bt{
    [self dissMissReBacInfoViewWithConfirm:false];
}
-(void)confirmedTapped:(UIButton*)bt{
    [self dissMissReBacInfoViewWithConfirm:true];
}
-(void)dissMissReBacInfoViewWithConfirm:(BOOL)confirmed{
    if (confirmed) {
        _contetnView.text=tf.text;
    }else{
        tf.text=@"";
    }
    [ReBacInfoView dismiss];
    ReBacInfoView=nil;
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
