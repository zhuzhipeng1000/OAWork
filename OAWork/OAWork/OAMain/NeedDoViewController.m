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
#import "User.h"
#import "RadioButton.h"

@interface NeedDoViewController ()<YZNavigationMenuViewDelegate>{
        NHPopoverViewController *ReBacInfoView;
    UITextView *_contetnView;
    UITextView *tf;
    UIView *smallView;
    NSDictionary *viewInfoDic;
    NSDictionary *currentDic;
    NSString *nextAcid;
}
@property (nonatomic ,strong) NSMutableArray *exampleArr; //用于普通显示的数据
@property (nonatomic ,strong)NSMutableArray *searchArr; //用于搜索后显示的数据
@property (nonatomic,strong) NSMutableArray *allArray;//服务返回的数据
@property (nonatomic,strong) UIScrollView* scrollView;
@end

@implementation NeedDoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=_needDoDic[@"TITLE"];
    
    [self getData];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
-(void)initView{
    if (!_scrollView) {
        self.view.backgroundColor=[Utils colorWithHexString:@"#f7f7f7"];
//        NSURL *dect=[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
//        NSURL * documentProtocolUrl =  [dect URLByAppendingPathComponent:@"www/aa.tt"];
//
//        NSString* jsonS=[NSString stringWithContentsOfURL:documentProtocolUrl encoding:NSUTF8StringEncoding error:nil];
//        NSLog(@"jsonS%@",jsonS);
//        NSDictionary *dic=[jsonS objectFromCTJSONString];
        //    self.title=dic[@"result"][@"docName"];
//        NSArray *viewInfoArray=dic[@"result"][@"lines"];
        int topHeight=0;
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, TOPBARCONTENTHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-TOPBARCONTENTHEIGHT)];
        _scrollView.showsVerticalScrollIndicator=false;
        [self.view addSubview:_scrollView];
//        viewInfoArray=@[@{@"name":@"姓名",@"value":@"张三"},@{@"name":@"部门",@"value":@"测试部"},@{@"name":@"请假类型",@"value":@"事假"},@{@"name":@"请假天数",@"value":@"1天"},@{@"name":@"开始时间",@"value":@"2017-12-30 12:30"},@{@"name":@"结束时间",@"value":@"2017-12-32 22:00"},@{@"name":@"请假事由",@"value":@"因故请假因故请假因故请假因故请假因故因故请假因故请假因故请假因故请假因故因故请假因故请假因故请假因故请假因故因故请假因故请假因故请假因故请假因故因故请假因故请假因故请假因故请假因故因故请假因故请假因故请假因故"},@{@"name":@"外出时间",@"value":@"2017-12-01"},@{@"name":@"外出地点",@"value":@"广州市教育局"},@{@"name":@"外借出证件类型",@"value":@"营业执照"},@{@"name":@"经费来源",@"value":@"广州市教育局"},@{@"name":@"外出地点",@"value":@"广州市教育局"},@{@"name":@"附件",@"value":@""}];
        
        for (int d=0; d<[viewInfoDic[@"lines"] count]; d++) {
            NSDictionary *detaiDic=viewInfoDic[@"lines"][d];
            
//            if ([detaiDic[@"TYPE"] intValue]==6&&[detaiDic.allKeys containsObject:@"value"]) {
//                 if ([detaiDic[@"TYPE"] intValue]==6) {
//                [signs addObject:detaiDic];
//                continue;
//            }
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
            
            
            if ([detaiDic[@"name"]  isEqualToString:@"开始时间"]||[detaiDic[@"name"]  isEqualToString:@"结束时间"]) {
                detaiLb.text=detaiDic[@"value"];
//                detaiLb.text=[Utils compareNowWithChineseString:[[Utils getNotNullNotNill:detaiDic[@"value"]] floatValue]/1000];
            }else{
              detaiLb.text=[NSString stringWithFormat:@"%@",[Utils getNotNullNotNill:detaiDic[@"value"]]];
            }
            
            areaView.backgroundColor=[Utils colorWithHexString:@"#f7f7f7"];
            textSize=  [Utils sizeWithText:detaiLb.text font:detaiLb.font maxSize:CGSizeMake(SCREEN_WIDTH-titleLB.right-30,200)];
            //            if (textSize.height<30) {
            //                textSize.height=30;
            //            }
            [areaView addSubview:detaiLb];
            
            
            
            detaiLb.frame=CGRectMake(titleLB.right+10,5,textSize.width,textSize.height);
            
            areaView.frame=CGRectMake(0,topHeight, SCREEN_WIDTH, detaiLb.height+10);
            //        }
            UIView *lineView=[[UIView alloc]init];
            lineView.frame=CGRectMake(0, areaView.height-1, SCREEN_WIDTH, 1);
            lineView.backgroundColor=[Utils colorWithHexString:@"#e4e4e4"];
            [areaView addSubview:lineView];
            topHeight=topHeight+areaView.height;
        }
//        NSArray *attachs=dic[@"result"][@"attachs"];
//        attachs=@[@{@"type":@"1",@"fileName":@"张三"},@{@"type":@"0",@"fileName":@"测试部"},@{@"type":@"2",@"fileName":@"事假"}];
//
//        for (int d=0; d<attachs.count; d++) {
//            NSDictionary *detaiDic=attachs[d];
//            UIView *areaView=[[UIView alloc] initWithFrame: CGRectMake(0,topHeight, SCREEN_WIDTH, 30)];
//
//            areaView.backgroundColor=[UIColor clearColor];
//            [_scrollView addSubview:areaView];
//
//            UIImageView *leftImage=[[UIImageView alloc]init];
//            leftImage.contentMode=UIViewContentModeScaleAspectFit;
//            [leftImage setImage:[UIImage imageNamed:@"w"]];
//            [areaView addSubview:leftImage];
//
//
//            UILabel *titleLB=[[UILabel alloc]init];
//            titleLB.text=detaiDic[@"fileName"];
//            titleLB.font=[UIFont systemFontOfSize:14.0F];
//            titleLB.textColor=[UIColor blackColor];
//            [areaView addSubview:titleLB];
//            CGSize textSize=  [Utils sizeWithText:titleLB.text font:titleLB.font maxSize:CGSizeMake(areaView.width-90, 60)];//20+20+20++10+20
//            if (textSize.height<40) {
//                textSize.height=40;
//            }else{
//                textSize.height=textSize.height+5;
//            }
//            leftImage.frame=CGRectMake(20,(textSize.height-20)/2, 20, 20);
//            titleLB.frame=CGRectMake(leftImage.right+10,0, textSize.width, textSize.height);
//            areaView.frame=CGRectMake(0,topHeight, SCREEN_WIDTH, titleLB.bottom);
//
//            UIImageView *_accessImage=[[UIImageView alloc]initWithFrame:CGRectMake(areaView.width-40, (titleLB.height-20)/2, 20, 20)];
//            _accessImage.contentMode=UIViewContentModeScaleAspectFit;
//            [_accessImage setImage:[UIImage imageNamed:@"arrow_down"]];
//            [areaView addSubview:_accessImage];
//            _accessImage.transform=CGAffineTransformMakeRotation((M_PI_2*3));// 像右往左转
//            _accessImage.transform=CGAffineTransformScale(_accessImage.transform, 0.5, 0.5);
//
//            UIButton *bt=[[UIButton alloc]initWithFrame:areaView.bounds];
//            [bt addTarget:self action:@selector(accessBtTaped:) forControlEvents:UIControlEventTouchUpInside];
//            [areaView addSubview:bt];
//
//            UILabel *lineLb=[[UILabel alloc]init];
//            lineLb.backgroundColor=[Utils colorWithHexString:@"#e4e4e4"];
//            [areaView addSubview:lineLb];
//            lineLb.frame=CGRectMake(0,areaView.height-1, SCREEN_WIDTH, 1);
//            topHeight=topHeight+areaView.height;
//        }
//        NSArray *signs=dic[@"result"][@"signs"];
//        attachs=@[@{@"Step":@"经理审批意见",@"content":@"统一大伟大"},@{@"Step":@"部门审批意见",@"content":@"不错，可以，同意"},@{@"Step":@"CEO意见",@"content":@"同意"}];
        
        NSMutableArray *signs=[NSMutableArray array];
        for (NSDictionary *dic in viewInfoDic[@"signs"]) {
            if ([dic isKindOfClass:[NSDictionary class]]&& [[dic allKeys] containsObject:@"CONTENT"]&&[[Utils getNotNullNotNill: dic[@"CONTENT"]] length]) {
                [signs addObject:dic];
            }
        }
        if (signs.count>0) {
            for (int d=0; d<signs.count; d++) {
                
                NSDictionary *detaiDic=signs[d];
                UIView *areaView=[[UIView alloc] initWithFrame: CGRectMake(0,topHeight, SCREEN_WIDTH, 100)];
                
                areaView.backgroundColor=[UIColor whiteColor];
                [_scrollView addSubview:areaView];
                
                UILabel *titleLB=[[UILabel alloc]init];
                titleLB.text=detaiDic[@"STEP"];//审批环节的名称（
                titleLB.font=[UIFont systemFontOfSize:14.0F];
                titleLB.textColor=[UIColor blackColor];
                titleLB.frame=CGRectMake(20,0,SCREEN_WIDTH-40,40);
                [areaView addSubview:titleLB];
                
                UILabel *contetnt=[[UILabel alloc]init];
                contetnt.text = [Utils getNotNullNotNill :detaiDic[@"CONTENT"]];//（
                contetnt.font=[UIFont systemFontOfSize:14.0F];
                contetnt.textAlignment=NSTextAlignmentLeft;
                contetnt.textColor=[Utils colorWithHexString:@"#f26c4f"];
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
//                signImage.contentMode=UIViewContentModeScaleAspectFit;
//                [signImage setImage:[UIImage imageNamed:@"arrow_down"]];
//                NSString *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES)[0];
//                NSString* signPath = [path stringByAppendingPathComponent:@"fileName"];
//                UIImage *imv=[UIImage imageWithContentsOfFile:signPath];
//                if (imv) {
//                    signImage.image=imv;
//                }
//                [areaView addSubview:signImage];
                UILabel *signLb=[[UILabel alloc]initWithFrame:signImage.frame];
                signLb.textColor=[UIColor blackColor];
                signLb.font=[UIFont systemFontOfSize:19.0];
                signLb.text=@"已签名";
                signLb.adjustsFontSizeToFitWidth=true;
                [areaView addSubview:signLb];
                
                UILabel *timeLb=[[UILabel alloc]init];
                
//                timeLb.text=[Utils dateStringFromTimeSt:detaiDic[@"DATE"]];//审批环节的名称（
                timeLb.text=[NSString stringWithFormat:@"%@",detaiDic[@"DATE"]];
//                timeLb.text=@"2017/12/13 18:20";
                timeLb.font=[UIFont systemFontOfSize:14.0F];
                timeLb.textColor=[UIColor blackColor];
                timeLb.frame=CGRectMake(SCREEN_WIDTH-130,signImage.bottom+10,120,25);
                [areaView addSubview:timeLb];
                
                UILabel *lineLb=[[UILabel alloc]init];
                lineLb.backgroundColor=[Utils colorWithHexString:@"#e4e4e4"];
                [areaView addSubview:lineLb];
                
                areaView.frame=CGRectMake(0,topHeight, SCREEN_WIDTH, timeLb.bottom+10);
                lineLb.frame=CGRectMake(0,areaView.height-1, SCREEN_WIDTH, 1);
                topHeight=topHeight+areaView.height;
                _scrollView.contentSize=CGSizeMake(SCREEN_WIDTH, areaView.bottom+30);
                
            }
        }
        
        NSArray *signsArr =viewInfoDic[@"signs"];
//        NSMutableArray *nextSteps=viewInfoDic[@"nextSteps"];
        if ([signsArr isKindOfClass:[NSArray class]]&&signsArr.count&&[[Utils getNotNullNotNill:viewInfoDic[@"bindingDataName"]] length] ) {
            for (int d=0; d<signsArr.count; d++) {
                NSDictionary *detailDic=signsArr[d];
                
                if ([detailDic[@"NAME"] isEqualToString:viewInfoDic[@"bindingDataName"]]) {
                    currentDic=detailDic;
                    UIView *areaView=[[UIView alloc] initWithFrame: CGRectMake(0,topHeight, SCREEN_WIDTH, 100)];
                    
                    areaView.backgroundColor=[UIColor whiteColor];
                    [_scrollView addSubview:areaView];
                    
                    UILabel *curentstepLB=[[UILabel alloc]init];
                    curentstepLB.text=detailDic[@"name"];//审批环节的名称（
                    curentstepLB.font=[UIFont systemFontOfSize:14.0F];
                    curentstepLB.textColor=[UIColor blackColor];
                    curentstepLB.frame=CGRectMake(20,0,SCREEN_WIDTH-40,40);
                    [areaView addSubview:curentstepLB];
                    
                    _contetnView=[[UITextView alloc]init];
                    _contetnView.frame=CGRectMake(5, curentstepLB.bottom, SCREEN_WIDTH-100, areaView.height-curentstepLB.bottom);
                    _contetnView.textColor=[Utils colorWithHexString:@"#f26c4f"];
                    [areaView addSubview:_contetnView];
                    
                    smallView=[[UIView alloc]initWithFrame:CGRectMake(areaView.width-90, areaView.height-38, 70, 28)];
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
                    NSAttributedString *countString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",detailDic[@"NAME"] ] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[Utils colorWithHexString:@"#08ba06"]}];
                    [nameString appendAttributedString:countString];
                    
                    titleLB.attributedText=nameString;
                    titleLB.frame=CGRectMake(20,areaView.bottom+20,(SCREEN_WIDTH)/2-20,40);
                    [_scrollView addSubview:titleLB];
                    
                    if (d<signsArr.count-1) {
                        NSDictionary *nextDic=signsArr[d+1];
                        
                        UILabel *nextLb=[[UILabel alloc]init];
                        NSMutableAttributedString *nextString = [[NSMutableAttributedString alloc] initWithString:@"下一环节：" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[Utils colorWithHexString:@"#363636"]}];
                        NSAttributedString *detailString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",nextDic[@"NAME"]] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[Utils colorWithHexString:@"#08ba06"]}];
                        [nextString appendAttributedString:detailString];
                        
                        nextLb.attributedText=nextString;
                        nextLb.textAlignment=NSTextAlignmentRight;
                        nextLb.frame=CGRectMake((SCREEN_WIDTH)/2,titleLB.top,(SCREEN_WIDTH)/2-20,40);
                        [_scrollView addSubview:nextLb];
                    }
                   
                    
                    UIButton *sendbt=[[UIButton alloc]initWithFrame:CGRectMake(40,titleLB.bottom+30, SCREEN_WIDTH-80, 44)];
                    sendbt.backgroundColor=[Utils colorWithHexString:@"#008fef"];
                    //    [revisePass setImage:[UIImage imageNamed:@"xiugaimima"] forState:UIControlStateNormal];
                    //    [revisePass setImage:[UIImage imageNamed:@"xiugaimima"]  forState:UIControlStateHighlighted];
                    [sendbt setTitle:@"发送" forState:UIControlStateNormal];
                    [sendbt setTitle:@"发送" forState:UIControlStateHighlighted];
                    
                    if ([viewInfoDic[@"nextSteps"] isKindOfClass:[NSArray class]]&& [viewInfoDic[@"nextSteps"] count]>0){
                        [sendbt setTitle:@"下一步" forState:UIControlStateNormal];
                        [sendbt setTitle:@"下一步" forState:UIControlStateHighlighted];
                         [sendbt addTarget:self action:@selector(nextTapped:) forControlEvents:UIControlEventTouchUpInside];
                        
                    }else{
                        [sendbt addTarget:self action:@selector(sendSign) forControlEvents:UIControlEventTouchUpInside];
                    }
                    [sendbt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [sendbt setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
                   
                    sendbt.layer.cornerRadius=sendbt.height/2;
                    sendbt.clipsToBounds=true;
                    [_scrollView addSubview:sendbt];
                    
                    
                    _scrollView.contentSize=CGSizeMake(SCREEN_WIDTH, sendbt.bottom+30);
                }
            }
        }
        
       
    }
}
-(void)getData{
    
    NSDictionary *parameters =@{@"formsetInstId":_needDoDic[@"FORMSET_INST_ID"]};
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    _hud.mode = MBProgressHUDModeAnnularDeterminate;
    self.hud.labelText = @"数据获取中";
    __weak __typeof(self) weakSelf = self;
    [MyRequest getRequestWithUrl:[HostMangager oaDetailUrl] andPara:parameters isAddUserId:true Success:^(NSDictionary *dict, BOOL success) {
        [weakSelf.hud hide:YES];
        if ([dict isKindOfClass:[NSDictionary class]]&& [dict[@"code"] intValue]==0) {
            viewInfoDic=[dict[@"result"] mutableCopy];
            [self initView];
        }else{
            
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:nil message:@"数据获取失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [al show];
            
        }
        
    } fail:^(NSError *error) {
        [weakSelf.hud hide:YES];
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:nil message:@"数据获取失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [al show];
    }];
    
}
-(void)accessBtTaped:(UIButton*)BT{
    
    
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
        [confirmBt addTarget:self action:@selector(showSignTapped:) forControlEvents:UIControlEventTouchUpInside];
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
-(void)showSignTapped:(UIButton*)bt{
    
    [self dissMissReBacInfoViewWithConfirm:true];
}
-(void)nextTapped:(UIButton*)bt{
    if ([viewInfoDic[@"nextSteps"] isKindOfClass:[NSArray class]]&& [viewInfoDic[@"nextSteps"] count]>0) {
        //        if (!ReBacInfoView) {
        UIView *aView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-40, 240)];
        aView.backgroundColor=[UIColor whiteColor];
        NSMutableArray* buttons=[NSMutableArray array];
        for (int d=0;d<[viewInfoDic[@"nextSteps"] count];d++) {
            NSDictionary *dic=viewInfoDic[@"nextSteps"][d];
            RadioButton* btn = [[RadioButton alloc] initWithFrame:CGRectMake(10,30*d, aView.width-20, 30)];
            [btn addTarget:self action:@selector(nextTapChanged:) forControlEvents:UIControlEventValueChanged];
            [btn setTitle:dic[@"NAME"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [btn setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
            [aView addSubview:btn];
            [buttons addObject:btn];
            btn.accessibilityHint=[dic JSONStringFromCT];
            
        }
        
        [buttons[0] setGroupButtons:buttons]; // Setting buttons into the group
        
        [buttons[0] setSelected:YES];
        
        
        UIButton *confirmBt=[[UIButton alloc]init];
        [confirmBt setTitle:@"确  认" forState: UIControlStateNormal];
        [confirmBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [confirmBt setTitle:@"确  认" forState: UIControlStateHighlighted];
        confirmBt.titleLabel.font=[UIFont boldSystemFontOfSize:16];
        [confirmBt setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [confirmBt setBackgroundImage:[Utils createImageWithColor:[Utils colorWithHexString:@"#008fef"]] forState:UIControlStateNormal];
        [confirmBt setBackgroundImage:[Utils createImageWithColor:[Utils colorWithHexString:@"#008fef"]] forState:UIControlStateHighlighted];
        [confirmBt addTarget:self action:@selector(sendSign) forControlEvents:UIControlEventTouchUpInside];
        confirmBt.layer.cornerRadius=35/2;
        confirmBt.clipsToBounds=true;
        confirmBt.frame=CGRectMake(aView.left+20, buttons.count*30+5, aView.width-40, 35);
        aView.frame=CGRectMake(0, 0, SCREEN_WIDTH-40, confirmBt.bottom+10);
        [aView addSubview:confirmBt];
        ReBacInfoView = [[NHPopoverViewController alloc] initWithView:aView contentSize:aView.frame.size autoClose:true];
        //        }
        
        
        [ReBacInfoView show];
        
    }
}
-(void)nextTapChanged:(UIView*)aView{
   nextAcid=[aView.accessibilityHint objectFromCTJSONString][@"ACT_ID"];
}
-(void)sendSign{
    if (!nextAcid) {
        nextAcid=viewInfoDic[@"nextSteps"][0][@"ACT_ID"];
    }
    NSDictionary *parameters =@{
        @"bindingDataName":viewInfoDic[@"bindingDataName"],
        @"content": _contetnView.text,
        @"formObjectId":[NSString stringWithFormat:@"%@", currentDic[@"FORM_OBJECT_ID"]],
        @"nextActId":[NSString stringWithFormat:@"%@",nextAcid],
        @"userId": [User shareUser].ID,
        @"workitemId":[NSString stringWithFormat:@"%@",viewInfoDic[@"workitemId"]]
    };
//    parameters=@{
//        @"bindingDataName": @"办公室意见",
//        @"content": @"我我我",
//        @"formObjectId": @"340795",
//        @"nextActId": @"32351",
//        @"userId": @"7214",
//        @"workitemId": @"404206"
//        };
    NSLog(@"%@",[parameters JSONStringFromCT]);
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    _hud.mode = MBProgressHUDModeAnnularDeterminate;
    self.hud.labelText = @"数据提交中";
    __weak __typeof(self) weakSelf = self;
    
    [MyRequest postRequestWithUrl:[HostMangager auditOAUrl] andPara:parameters isAddUserId:false Success:^(NSDictionary *dict, BOOL success) {
        [weakSelf.hud hide:YES];
        if ([dict isKindOfClass:[NSDictionary class]]&& [dict[@"code"] intValue]==0) {
            [ReBacInfoView dismiss];
           [weakSelf.view makeToast:@"提交成功" duration:1 position:CSToastPositionCenter];
             [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:nil message:@"数据提交失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [al show];
            
        }
        
    } fail:^(NSError *error) {
        [weakSelf.hud hide:YES];
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:nil message:@"数据提交失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [al show];
    }];
    
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
