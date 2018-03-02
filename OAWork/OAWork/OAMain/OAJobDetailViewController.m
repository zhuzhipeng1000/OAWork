//
//  OAJobDetailViewController.m
//  OAWork
//
//  Created by james on 2017/11/30.
//  Copyright © 2017年 james. All rights reserved.
//

#import "OAJobDetailViewController.h"
#import <RadioButton/RadioButton.h>
#import "ITTPickView.h"
#import "YZNavigationMenuView.h"
#import "NHPopoverViewController.h"
#import "HWDownSelectedView.h"
#import "OAprogressMonitorViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <AVFoundation/AVFoundation.h>
#import "WQAlert.h"
#import "SelectFileViewController.h"
#import "PreviewViewController.h"
#import "ELCImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>


@interface OAJobDetailViewController ()<ITTPickViewDelegate,HWDownSelectedViewDelegate,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,SelectFileViewControllerDelegate>
{
    ITTPickView *_datePicker;
//    ListSelectView *_listView;
    UITableView *_aaaatableView;
    UIButton *_bar;
    YZNavigationMenuView *_menuView;

    UIScrollView *_scrollView;
    UIButton *_confirmBt;
    int type;
    NSMutableArray *viewInfoArray;
    NSArray *nextActList;
    NHPopoverViewController *ReBacInfoView;
    NHPopoverViewController *DetailInfoView;
     NSString *nextStepId;
    NSArray  *_selectedImvs;
    UILabel * selectedFileLb;
    NSMutableArray *_uploadFileInfo;
    int _uploadFinishCount;
}
@end

@implementation OAJobDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
      self.title=_categoryDic[@"DOCTYPENAME"];
    type=[_categoryDic[@"DOCID"] intValue];
//    if ([_categoryDic[@"DOCTYPENAME"] isEqualToString:@"通知"]) {
//        type=2;
//    }else if ([_categoryDic[@"DOCTYPENAME"] isEqualToString:@"互相交流"]) {
//        type=1;
//    }else if ([_categoryDic[@"DOCTYPENAME"] isEqualToString:@"会议室预约登记表"]) {
//        type=3;
//    }else if ([_categoryDic[@"DOCTYPENAME"] isEqualToString:@"工会请款"]) {
//        type=4;
//    }else if ([_categoryDic[@"DOCTYPENAME"] isEqualToString:@"工会发文"]) {
//        type=3;
//    }
    [self getData];
    
    self.view.backgroundColor=[Utils colorWithHexString:@"#f7f7f7"];
    NSURL *dect=[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL * documentProtocolUrl =  [dect URLByAppendingPathComponent:@"www/aa.tt"];
    
    NSString* jsonS=[NSString stringWithContentsOfURL:documentProtocolUrl encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"jsonS%@",jsonS);
    NSDictionary *dic=[jsonS objectFromCTJSONString];
//    self.title=dic[@"result"][@"docName"];
   

    
    // Do any additional setup after loading the view from its nib.
}
-(void)initView{
//    NSArray *viewInfoArray=dic[@"result"][@"formData"];
    int topHeight=0;
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, TOPBARCONTENTHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-TOPBARCONTENTHEIGHT)];
    _scrollView.showsVerticalScrollIndicator=false;
    [self.view addSubview:_scrollView];
    NSString *headText=[NSString stringWithFormat:@"广州市教育评估和教师继续教育指导中心%@",self.title];
    NSDictionary *dic=@{@"TYPE":@"150",@"name":headText,@"BINDING_DATA_NAME":headText};
    NSDictionary *attachdic=@{@"TYPE":@"250",@"name":@"附件",@"BINDING_DATA_NAME":@"附件"};

    [viewInfoArray insertObject:dic atIndex:0];
     [viewInfoArray addObject:attachdic];
    NSArray *departMentArr=@[@"拟稿部门",@"使用部门",@"部门",@"上报部门",@"部门名称",@"部室名称"];
    NSArray *personArray=@[@"拟稿人",@"上报人",@"经办人",@"申请人",@"提出人",@"姓名"];
    for (int d=0; d<viewInfoArray.count; d++) {
        NSDictionary *detaiDic=viewInfoArray[d];
        if ([detaiDic[@"TYPE"] intValue]==6) {
            continue;
        }
        //        input 普通输入框
        //        date 时间控件(提交的时候提交 毫秒数)
        //        spin 下拉选择控件（下拉选项在options参数中测试）
        //        spinInput 下拉选择类型再加text 输入框（例如：选择身份证、户照之后再输证件号码）
        //        dateInput 时间+输入框的组合控件，请假单中有（时间/地点），复核控件在接口中用逗号隔开，具体在新建公文接口示例。
        //        attach 附件
        //        radioButton 单项列表
        //        "name": "姓名",
        //        "type": "input",
        //        "inputType": "text",
        //        "requestKey": "userName",
        //        "default": {
        //            "k": "1234（userid）",
        //            "v": "王小二"
        //        }
        UIView *areaView=[[UIView alloc] initWithFrame: CGRectMake(0,topHeight, SCREEN_WIDTH, 30)];
        areaView.tag=1000+d;
        areaView.accessibilityHint=[detaiDic JSONStringFromCT];
        areaView.backgroundColor=[UIColor whiteColor];
        [_scrollView addSubview:areaView];
        
        UILabel *titleLB=[[UILabel alloc]init];
        titleLB.text=detaiDic[@"BINDING_DATA_NAME"];
        titleLB.font=[UIFont systemFontOfSize:14.0F];
        titleLB.textColor=[UIColor blackColor];
        [areaView addSubview:titleLB];
        CGSize textSize=  [Utils sizeWithText:titleLB.text font:titleLB.font maxSize:CGSizeMake(areaView.width, 30)];
        
        titleLB.frame=CGRectMake(20,0, textSize.width+10, 30);
        CGRect nextFrame=CGRectMake(titleLB.right, titleLB.top, areaView.width-titleLB.right-20, titleLB.height);
        
        if ([detaiDic[@"TYPE"] intValue]==150) {
            titleLB.backgroundColor=[UIColor clearColor];
            titleLB.numberOfLines=0;
            titleLB.font=[UIFont systemFontOfSize:18.0f];
            titleLB.lineBreakMode=NSLineBreakByWordWrapping;
            titleLB.textAlignment=NSTextAlignmentCenter;
            areaView.backgroundColor=[Utils colorWithHexString:@"#f7f7f7"];
            textSize=  [Utils sizeWithText:titleLB.text font:titleLB.font maxSize:CGSizeMake(SCREEN_WIDTH-40, 30)];
            if ([detaiDic[@"name"] isEqualToString:@""]||[detaiDic[@"name"] isKindOfClass:[NSNull class]]) {
                textSize.height=20;
            }else{
                textSize.height += textSize.height+10;
                titleLB.frame=CGRectMake(20,0,SCREEN_WIDTH-40,textSize.height);
            }
            areaView.frame=CGRectMake(0,topHeight, SCREEN_WIDTH, textSize.height);
            
        }else if ([detaiDic[@"TYPE"] intValue]==2) {
            HWDownSelectedView *aVie=[[HWDownSelectedView alloc]initWithFrame:nextFrame];
            aVie.placeholder = @"spin";
            aVie.listArray = [detaiDic[@"ATT1"] componentsSeparatedByString:@";"];
            aVie.delegate=self;
            aVie.tag=2000+d;
            aVie.accessibilityHint=[detaiDic JSONStringFromCT];
            [areaView addSubview:aVie];
            
            //            UILabel *lb=[[UILabel alloc]initWithFrame:nextFrame];
            //            lb.text=@"spin";
            //            lb.textColor=[UIColor blackColor];
            //            lb.tag=102;
            //            lb.font=[UIFont systemFontOfSize:14.0f];
            //            lb.userInteractionEnabled=true;
            //            [areaView addSubview:lb];
            //
            //            UIImageView *im=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow_down"]];
            //            im.frame=CGRectMake(lb.width-10, (lb.height-5)/2, 8, 5);
            //            [lb addSubview:im];
            //
            //
            //            UIButton *bt=[[UIButton alloc]initWithFrame:lb.bounds];
            //            [lb addSubview:bt];
            //            bt.backgroundColor=[UIColor clearColor];
            //            [bt addTarget:self action:@selector(listBtTapped:) forControlEvents:UIControlEventTouchUpInside];
            //            ListSelectView *aList=[[ListSelectView alloc]];
            //            if ([detaiDic[@"type"] isEqualToString:@"spinInput"]) {
            //                aList.listViewType=ListViewTextField;
            //            }
            //            [areaView addSubview:aList];
            //            aList.titleArray=@[@"全部",@"工程审计",@"跟踪审计",@"专项审计"];
        }else if ([detaiDic[@"type"] isEqualToString:@"spinInput"]) {
            
            HWDownSelectedView *aVie=[[HWDownSelectedView alloc]initWithFrame:nextFrame];
            aVie.placeholder = @"spinInput";
            aVie.listArray = @[@"22", @"23", @"24", @"25", @"26"];
            aVie.type=HWDownTypeCanEdit;
            aVie.delegate=self;
            aVie.tag=2000+d;
            [areaView addSubview:aVie];
            
            //             \ *tf=[[UITextField alloc]initWithFrame:nextFrame];
            //            tf.font=[UIFont systemFontOfSize:15.0f];
            //            tf.text=@"spinInput";
            //            tf.tag=102;
            //            tf.font=[UIFont systemFontOfSize:14.0f];
            //            tf.userInteractionEnabled=true;
            //            [areaView addSubview:tf];
            //
            //            UIImageView *im=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow_down"]];
            //            im.frame=CGRectMake(tf.width-10, (tf.height-5)/2, 8, 5);
            //            [tf addSubview:im];
            //
            //
            //            UIButton *bt=[[UIButton alloc]initWithFrame:CGRectMake(tf.width-tf.height,0, tf.height, tf.height)];
            //            [tf addSubview:bt];
            //            bt.backgroundColor=[UIColor clearColor];
            //            [bt addTarget:self action:@selector(listBtTapped:) forControlEvents:UIControlEventTouchUpInside];
                                                  //地点类型                         ／／是否类型
        }else if ([detaiDic[@"TYPE"] intValue]==1) {
            
            UITextField *tf=[[UITextField alloc]init];
            tf.accessibilityHint=detaiDic[@"default"];
            tf.textColor=[UIColor blackColor];
            tf.font=[UIFont systemFontOfSize:14.0f];
            tf.frame=nextFrame;
            tf.tag=2000+d;
            [areaView addSubview:tf];
            if ([departMentArr containsObject:detaiDic[@"BINDING_DATA_NAME"]]) {
                tf.text=[User shareUser].ORG_NAME;
            }else if ([personArray containsObject:detaiDic[@"BINDING_DATA_NAME"]]){
                tf.text=[User shareUser].NAME;
            }
            
        }else if ([detaiDic[@"TYPE"] intValue]==6) {//text
            UITextView *tf=[[UITextView alloc]init];
            int line=1;
            if ([[detaiDic allKeys] containsObject:@"lines"]) {
                line=[detaiDic[@"lines"] intValue];
            }
            tf.font=[UIFont systemFontOfSize:14.0f];
            tf.accessibilityHint=detaiDic[@"default"];
            tf.textColor=[UIColor blackColor];
            tf.tag=2000+d;
            tf.frame=CGRectMake(nextFrame.origin.x, nextFrame.origin.y, nextFrame.size.width, nextFrame.size.height+25*(line-1));
            areaView.frame=CGRectMake(0,topHeight, SCREEN_WIDTH, tf.bottom);
            [areaView addSubview:tf];
            
        }else if ([detaiDic[@"TYPE"] intValue]==16) {//日期类
            UILabel *lb=[[UILabel alloc]initWithFrame:nextFrame];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            NSDate *date = [NSDate date];
            lb.font=[UIFont systemFontOfSize:14.0f];
            lb.userInteractionEnabled=true;
           
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSString *dateString=[dateFormatter stringFromDate:date];
            lb.text=dateString;
           lb.text=@"请选择日期";
            lb.tag=2000+d;
            UIButton *bt=[[UIButton alloc]initWithFrame:lb.bounds];
            [lb addSubview:bt];
            bt.backgroundColor=[UIColor clearColor];
            [bt addTarget:self action:@selector(dateBtTapped:) forControlEvents:UIControlEventTouchUpInside];
            [areaView addSubview:lb];
        }else if ([detaiDic[@"TYPE"] intValue]==160) { //日期输入框
            UITextField *lb=[[UITextField alloc]initWithFrame:nextFrame];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            NSDate *date = [NSDate date];
            lb.font=[UIFont systemFontOfSize:14.0f];
            lb.userInteractionEnabled=true;
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSString *dateString=[dateFormatter stringFromDate:date];
            lb.text=dateString;
             lb.tag=2000+d;
            lb.text=@"请选择日期";
            [areaView addSubview:lb];
            
            UIImageView *im=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow_down"]];
            im.frame=CGRectMake(lb.width-10, (lb.height-5)/2, 8, 5);
            [lb addSubview:im];
            
            
            UIButton *bt=[[UIButton alloc]initWithFrame:CGRectMake(lb.width-lb.height,0, lb.height, lb.height)];
            [lb addSubview:bt];
            bt.backgroundColor=[UIColor clearColor];
            [bt addTarget:self action:@selector(dateBtTapped:) forControlEvents:UIControlEventTouchUpInside];
            
        }else  if ([detaiDic[@"TYPE"] intValue]==4) {
            NSMutableArray* buttons = [NSMutableArray array];
             NSArray *optionTitles=[detaiDic[@"ATT1"] componentsSeparatedByString:@";"];
            CGRect btnRect = CGRectMake(nextFrame.origin.x, nextFrame.origin.y, 100, nextFrame.size.height);
           
            for (int k=0;k<optionTitles.count;k++) {
                NSString* optionTitle= optionTitles[k];
                RadioButton* btn = [[RadioButton alloc] initWithFrame:btnRect];
                [btn addTarget:self action:@selector(onRadioButtonValueChanged:) forControlEvents:UIControlEventValueChanged];
               
                CGSize atextSize=  [Utils sizeWithText:optionTitle font:btn.titleLabel.font maxSize:CGSizeMake(areaView.width,30)];
                if ((btnRect.origin.x+atextSize.width+50)>areaView.width) {
                    btnRect.origin.x=titleLB.right+10;
                    btnRect.origin.y += 40;
                }else{
                    btnRect.origin.x += atextSize.width+50;
                    
                }
                btn.tag=5000+k;
                [btn setTitle:optionTitle forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:14];
                [btn setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
                btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                btn.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
                [areaView addSubview:btn];
                areaView.frame=CGRectMake(0,topHeight, SCREEN_WIDTH, btn.bottom);
                [buttons addObject:btn];
                
            }
            
            [buttons[0] setGroupButtons:buttons]; // Setting buttons into the group
            
            [buttons[0] setSelected:YES];
        }else if ([detaiDic[@"TYPE"] intValue]==250){
            areaView.userInteractionEnabled=true;
            titleLB.userInteractionEnabled=true;
            selectedFileLb=[[UILabel alloc]initWithFrame:CGRectMake(titleLB.right,titleLB.top, areaView.width-90-titleLB.right, titleLB.height)];
            selectedFileLb.font=[UIFont systemFontOfSize:12.0f];
            selectedFileLb.textColor=[UIColor blackColor];
            [areaView addSubview:selectedFileLb];
            
            UIButton *bt=[[UIButton alloc]initWithFrame:CGRectMake(areaView.width-90,titleLB.top, 80, titleLB.height)];
            [bt setTitle:@"添加附件" forState:UIControlStateNormal];
            [bt setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            bt.titleLabel.font=[UIFont systemFontOfSize:13.0f];
            bt.backgroundColor=[UIColor clearColor];
            [bt addTarget:self action:@selector(headBtTapped:) forControlEvents:UIControlEventTouchUpInside];
            [areaView addSubview:bt];
//            NSArray *selectedFiles=[User shareUser].selectdFiles;
//            for (int k=0;k<selectedFiles.count;k++) {
//                NSString* filePath= selectedFiles[k];
//                UIButton *bt=[[UIButton alloc]initWithFrame:CGRectMake(titleLB.left,titleLB.height+30*k, 30, titleLB.width)];
//                [bt setTitle:[[filePath componentsSeparatedByString:@"/"] lastObject] forState:UIControlStateNormal];
//                [bt setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//                bt.accessibilityHint=filePath;
//                bt.titleLabel.textAlignment=NSTextAlignmentLeft;
//                bt.backgroundColor=[UIColor clearColor];
//                [bt addTarget:self action:@selector(fileTapped:) forControlEvents:UIControlEventTouchUpInside];
//                [titleLB addSubview:bt];
//                [areaView addSubview:bt];
//
//            }
//            areaView.frame=CGRectMake(0,topHeight, SCREEN_WIDTH,titleLB.height+ selectedFiles.count*30);
           
        }
        UIView *bottomLineView=[[UIView alloc]init];
        bottomLineView.backgroundColor=[Utils colorWithHexString:@"#e4e4e4"];
        [areaView addSubview:bottomLineView];
        topHeight=areaView.bottom+1;
        
    }
    _confirmBt=[[UIButton alloc]init];
    [_confirmBt setTitle:@"发送" forState: UIControlStateNormal];
    [_confirmBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_confirmBt setTitle:@"发送" forState: UIControlStateHighlighted];
    _confirmBt.titleLabel.font=[UIFont boldSystemFontOfSize:16];
    [_confirmBt setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_confirmBt setBackgroundImage:[Utils createImageWithColor:[Utils colorWithHexString:@"#008fef"]] forState:UIControlStateNormal];
    [_confirmBt setBackgroundImage:[Utils createImageWithColor:[Utils colorWithHexString:@"#008fef"]] forState:UIControlStateHighlighted];
    [_confirmBt addTarget:self action:@selector(nextTapped:) forControlEvents:UIControlEventTouchUpInside];
    _confirmBt.layer.cornerRadius=40/2;
    _confirmBt.clipsToBounds=true;
    _confirmBt.frame=CGRectMake(20, topHeight+20,SCREEN_WIDTH-40, 40);
     [_scrollView addSubview:_confirmBt];
    if (nextActList.count>0) {
       [_confirmBt setTitle:@"下一步" forState: UIControlStateNormal];
       [_confirmBt setTitle:@"下一步" forState: UIControlStateHighlighted];
    }
    
    [_scrollView addSubview:_confirmBt];
    _scrollView.contentSize=CGSizeMake(SCREEN_WIDTH, _confirmBt.bottom+20);
}
-(void)fileTapped:(UIButton*)bt{
    PreviewViewController *previewVC = [[PreviewViewController alloc]init];
    NSURL *url = [NSURL fileURLWithPath:bt.accessibilityHint];
    previewVC.url = url;
    [self.navigationController  pushViewController:previewVC animated:YES];
    
}
-(void)nextTapped:(UIButton*)bt{
    if (nextActList.count>0) {
//        if (!ReBacInfoView) {
            UIView *aView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-40, 240)];
            aView.backgroundColor=[UIColor whiteColor];
            NSMutableArray* buttons=[NSMutableArray array];
            for (int d=0;d<nextActList.count;d++) {
                NSDictionary *dic=nextActList[d];
                RadioButton* btn = [[RadioButton alloc] initWithFrame:CGRectMake(10,30*d, aView.width-20, 30)];
                [btn addTarget:self action:@selector(nextTapChanged:) forControlEvents:UIControlEventValueChanged];
                [btn setTitle:dic[@"nextActName"] forState:UIControlStateNormal];
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
            [confirmBt addTarget:self action:@selector(confirmedTapped:) forControlEvents:UIControlEventTouchUpInside];
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
-(void)confirmedTapped:(UIButton*)bt{
   
    [ReBacInfoView dismiss];
    ReBacInfoView=nil;
    NSMutableArray *arr=[NSMutableArray array];
    NSString *title=@"";
    for (UIView *areaView in _scrollView.subviews) {
    
        if (areaView.tag>1000&& areaView.subviews.count>1) {
             NSMutableDictionary *mudic=[NSMutableDictionary dictionary];
            NSDictionary *detaiDic =[areaView.accessibilityHint objectFromCTJSONString];
            [mudic setObject:detaiDic[@"BINDING_DATA_NAME"] forKey:@"bindingDataName"];
             [arr addObject:mudic];
             BOOL shouldAlert=false;
            UILabel *valueView=[areaView viewWithTag:(1000+areaView.tag)];
            if ([detaiDic[@"TYPE"]  intValue]==16&&([valueView isKindOfClass:[UILabel class]]||[valueView isKindOfClass:[UITextField class]])) {
                    UITextField *textView=(UITextField*)valueView;
                    if (textView.accessibilityHint.length<1) {
                        shouldAlert=true;
                    }else{
                    NSString *timeInterval=textView.accessibilityHint;;
                    [mudic setObject:timeInterval forKey:@"value"];
                    
                   }
                }else if ([valueView isKindOfClass:[UITextField class]]||[valueView isKindOfClass:[UITextView class]]) {
                    UITextField *textView=(UITextField*)valueView;
                    if (!textView.text||textView.text.length<1) {
                        shouldAlert=true;
                    }else{
                        [mudic setObject:textView.text forKey:@"value"];
                        if ([detaiDic[@"BINDING_DATA_NAME"] isEqualToString:@"标题"]) {
                            title=textView.text;
                        }
                        
                    }
                }else if ([detaiDic[@"TYPE"]  intValue]==4){
                    NSArray *optionTitles=[detaiDic[@"ATT1"] componentsSeparatedByString:@";"];
                    for (int d=0;d< optionTitles.count;d++) {
                        RadioButton  *radioButton=[areaView viewWithTag:5000+d];
                        if ([radioButton isKindOfClass:[radioButton class]]&&radioButton.isSelected) {
                             [mudic setObject:[radioButton titleForState:UIControlStateNormal] forKey:@"value"];
                        }
                    }
                }else if ([valueView isKindOfClass:[HWDownSelectedView class]]){
                    HWDownSelectedView* DownSelectedView=(HWDownSelectedView*)valueView;
//                     *dic=[DownSelectedView.accessibilityHint objectFromCTJSONString];
                    [mudic setObject:DownSelectedView.text forKey:@"value"];
                }
                if (shouldAlert) {
                    UIAlertController *al=[UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"请输入%@",detaiDic[@"BINDING_DATA_NAME"]] preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        NSLog(@"OK Action");
                    }];
                    [al addAction:okAction];
                    [self presentViewController:al animated:YES completion:nil];
                    return;
                }
            
        }
    }
    if (!nextStepId) {
        nextStepId=nextActList[0][@"nextActId"];
    }
    
  
    NSDictionary *para=@{@"docId":_categoryDic[@"DOCID"],@"formDatas":arr,@"sendFlag":@true,@"userId":[User shareUser].ID,@"nextActId":nextStepId,@"title":title,@"fileList":_uploadFileInfo};
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    _hud.mode = MBProgressHUDModeAnnularDeterminate;
    self.hud.labelText = @"提交数据中";
    __weak __typeof(self) weakSelf = self;
  
   
    [MyRequest postRequestWithUrl:[HostMangager submitOptionUrl] andPara:para isAddUserId:false Success:^(NSDictionary *dict, BOOL success) {
        [weakSelf.hud hide:YES];
        if ([dict isKindOfClass:[NSDictionary class]]&& [dict[@"code"] intValue]==0) {
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:nil message:@"提交成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            al.accessibilityHint=@"提交";
            [al show];
            
        }else{
            
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:nil message:@"提交失败，请重试" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            al.accessibilityHint=@"提交";
            [al show];
            
        }
        
    } fail:^(NSError *error) {
        [weakSelf.hud hide:YES];
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:nil message:@"提交失败，请重试" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
         al.accessibilityHint=@"提交";
        [al show];
    }];
    
}
-(void)getData{
    
    NSDictionary *parameters =@{@"docId":[NSNumber numberWithInt:type]};
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    _hud.mode = MBProgressHUDModeAnnularDeterminate;
    self.hud.labelText = @"数据获取中";
    __weak __typeof(self) weakSelf = self;
    [MyRequest getRequestWithUrl:[HostMangager newOaUrl] andPara:parameters isAddUserId:true Success:^(NSDictionary *dict, BOOL success) {
        [weakSelf.hud hide:YES];
        if ([dict isKindOfClass:[NSDictionary class]]&& [dict[@"code"] intValue]==0&&[dict[@"result"][@"formData"] isKindOfClass:[NSArray class]]) {
            viewInfoArray=[dict[@"result"][@"formData"] mutableCopy];
            nextActList=dict[@"result"][@"nextActList"];
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
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!_bar) {
        _bar=[[UIButton alloc]init];
        [_bar setTitle:@"+" forState: UIControlStateNormal];
        [_bar setTitleColor:[Utils colorWithHexString:@"#008fef"] forState:UIControlStateNormal];
        [_bar setTitle:@"+" forState: UIControlStateHighlighted];
        _bar.titleLabel.font=[UIFont boldSystemFontOfSize:24];
        [_bar setTitleColor:[Utils colorWithHexString:@"#008fef"] forState:UIControlStateHighlighted];
        [_bar addTarget:self action:@selector(editTapped:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* barButton = [[UIBarButtonItem alloc] initWithCustomView:_bar];
        self.navigationItem.rightBarButtonItem = barButton;
    }
    
    
}


- (void)editTapped:(UIButton*)bt{
    
    if (!_menuView) {
        //        NSArray *imageArray = @[@"newInfo_whiteBack",@"newPro_whiteBack",@"edit_whiteBack"];
        NSArray *imageArray = @[@"liuchengjiankong",@"baocun"];
        
        _menuView= [[YZNavigationMenuView alloc] initWithPositionOfDirection:CGPointMake(SCREEN_WIDTH -34,BOTTOMBARHEIGHT+25) images:imageArray titleArray:@[@"流程监控",@"保存"] andType :0];
        _menuView.cellColor=[UIColor whiteColor];
        _menuView.delegate = self;
        _menuView.textLabelTextAlignment=NSTextAlignmentLeft;
    }else{
      _menuView.hidden=!_menuView.isHidden;
    }
    [self.view addSubview:_menuView];
       
    
}
-(void) dateBtTapped:(UIButton*)bt{
    
    if (!_datePicker) {
        _datePicker = [[ITTPickView alloc] initDatePickWithDate:[NSDate date] datePickerMode:UIDatePickerModeDateAndTime isHaveNavControler:NO];
    }
    _datePicker.defaulDate=[NSDate date];
    _datePicker.delegate=self;
    _datePicker.textView=(UILabel*)bt.superview;
    [_datePicker showView];
    [self textFieldUserEnable:false OfView:self.view];
    
}
//-(void) listBtTapped:(UIButton*)bt{
//    UIView *aView=bt.superview;
//    CGPoint convertpoint=[aView convertPoint:CGPointZero toView:self.view ];
//     CGRect frame=CGRectMake(convertpoint.x, convertpoint.y+aView.height,aView.width,100);
//    _aaaatableView=[[UITableView alloc]initWithFrame:frame];
//    _aaaatableView.dataSource=self;
//    _aaaatableView.delegate=self;
//    _aaaatableView.backgroundColor=[UIColor whiteColor];
//    _aaaatableView.separatorStyle=UITableViewCellSeparatorStyleNone;
//    [self.view addSubview:_aaaatableView];
//
//
//}

-(void)textFieldUserEnable:(BOOL)userEnable OfView:(UIView*)aView{
    for (UIView  *Aview in aView.subviews) {
        if ([Aview isKindOfClass:[UITextField class]]||[Aview isKindOfClass:[UITextView class]]) {
            Aview.userInteractionEnabled=userEnable;

        }else{
            [self textFieldUserEnable:userEnable OfView:Aview];
        }
    }
}
-(void)onRadioButtonValueChanged:(RadioButton*)BT{
//    for (UIView *Aview in BT.groupButtons) {
//        Aview.accessibilityHint=nil;
//    }
//
//    BT.accessibilityHint=[BT titleForState:UIControlStateNormal];
}
-(void)nextTapChanged:(UIButton *)bt{
    nextStepId=[bt.accessibilityHint objectFromCTJSONString][@"nextActId"];
}
-(void)headBtTapped:(UIButton*)bt{
    [self.view endEditing:YES];
//    UIAlertView *al=[[UIAlertView alloc]initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"相册中选择",@"应用中选择", nil];
//    al.accessibilityHint=@"附件选择";
//    [al show];
    [self selecteFromLib];
    
//    if (!DetailInfoView) {
//        UIView *headTapPopView=[[UIView alloc]initWithFrame:CGRectMake(20, 0,SCREEN_WIDTH-40, 120)];
//        NSArray *titles=@[@"从手机相册中选择",@"从应用中选择",@"取消"];
//        for (int d=0; d<titles.count; d++) {
//            UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
//            [button2 setTitle:titles[d] forState:UIControlStateNormal];
//            [button2 setTitle:titles[d] forState:UIControlStateHighlighted];
//            button2.tag=1000+d;
//            [button2 setTitleColor:[Utils colorWithHexString:@"#363636"] forState:UIControlStateNormal];
//            [button2 addTarget:self action:@selector(chooseImage:)
//              forControlEvents:UIControlEventTouchUpInside];
//            button2.frame=CGRectMake(0,40*d, headTapPopView.width, 40);
//            [headTapPopView addSubview:button2];
//            UIView *bottomStrait=[[UIView alloc]initWithFrame:CGRectMake(0,headTapPopView.bottom-1, headTapPopView.width, 1)];
//            bottomStrait.backgroundColor=[Utils colorWithHexString:@"#e4e4e4"];
//            if (d!=(titles.count-1)) {
//                [headTapPopView addSubview:bottomStrait];
//            }
//
////        }
//        DetailInfoView = [[NHPopoverViewController alloc] initWithView:headTapPopView contentSize:headTapPopView.frame.size autoClose:FALSE];
//
//    }
//    [DetailInfoView show];
}

-(void)gotoDownFile{
    NSString *filepath= [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    SelectFileViewController *sc=[[SelectFileViewController alloc]init];
    sc.filePath=filepath;
    sc.delegate=self;
    [self.navigationController pushViewController:sc animated:YES];
    
}
-(void)selecteFromLib{
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
    //Set the maximum number of images to select to 100
    elcPicker.maximumImagesCount =10;
    
    //Only return the fullScreenImage, not the fullResolutionImage
 
    elcPicker.returnsOriginalImage = YES;
    
    //Return UIimage if YES. If NO, only return asset location information
    //是否返回只图片地址，
    elcPicker.returnsImage = NO;
    
    //For multiple image selection, display and return order of selected images
    //是否显示选中的图片序号 如果没有配置 默认为 YES

    elcPicker.onOrder = YES;
    
    //Supports image and
    elcPicker.mediaTypes = @[(NSString *)kUTTypeImage, (NSString *)kUTTypeMovie];
    elcPicker.imagePickerDelegate = (id<ELCImagePickerControllerDelegate>)self;
    elcPicker.referenceURLInfo = _selectedImvs;
    
    elcPicker.isThumbSmall = false;
    elcPicker.isBase64Result = false;
    elcPicker.thumScale = 1024;
    elcPicker.maxSize = 1.0;
    elcPicker.maxPixel = 5000;
    elcPicker.isPersistence =false;
    
    [self.navigationController presentViewController:elcPicker animated:YES completion:^{
        
    }];
    
    
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
-(void)uploadAllAttach{
    if (_selectedImvs.count) {
        for (int d=0; d<_selectedImvs.count; d++) {
            [self uploadAttach:_selectedImvs[d][@"pic"]];
        }
    }else{
        [self confirmedTapped:nil];
    }
    
}
-(NSString*)mineNameOfFilepath:(NSString*)filePath{
    
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)[filePath pathExtension], NULL);
    
    CFStringRef MIMEType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
    NSLog(@"MIMEType%@",MIMEType);
    NSString* strNS = (__bridge NSString *)MIMEType;
    return strNS;
}
-(void)uploadAttach:(NSString*)filePath{
    
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
//        UIImage *imv=[UIImage imageWithContentsOfFile:filePath];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
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
        if (!_uploadFileInfo) {
            _uploadFileInfo=[NSMutableArray array];
        }
        NSMutableDictionary *dic=[NSMutableDictionary dictionary];
//        {
//            "contentType": "string",
//            "fileName": "string",
//            "objectType": 0,
//            "realPath": "string",
//            "title": "string"
//        }
        [dic setObject:@"image/jpeg" forKey:@"contentType"];
        [dic setObject:[[filePath componentsSeparatedByString:@"/"] lastObject] forKey:@"fileName"];
        [dic setObject:@0 forKey:@"objectType"];
         [dic setObject:responseObject[@"result"][0][@"filePath"] forKey:@"realPath"];
         [dic setObject:[[filePath componentsSeparatedByString:@"/"] lastObject] forKey:@"title"];
        [_uploadFileInfo addObject:dic];
        _uploadFinishCount++;
        NSLog(@"上传成功%@",responseObject);
         [self.view makeToast:[NSString stringWithFormat:@"%@上传成功",dic[@"fileName"]] duration:1 position:CSToastPositionCenter];
        if (_uploadFinishCount==_selectedImvs.count) {
            [self confirmedTapped:nil];
        }
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError * _Nonnull error) {
        //上传失败
        NSLog(@"上传失败");
        _uploadFinishCount++;
         [self.view makeToast:[NSString stringWithFormat:@"%@上传失败",[[filePath componentsSeparatedByString:@"/"] lastObject]] duration:1 position:CSToastPositionCenter];
        if (_uploadFinishCount==_selectedImvs.count) {
            [self confirmedTapped:nil];
        }
    }];
    [task  resume];
}
#pragma  mark DataPickDelgate
-(void)toobarDonBtnHaveClick:(ITTPickView *)pickView resultString:(NSString *)resultString{
  
    if (resultString.length) {
        pickView.textView.text=resultString;
        pickView.textView.accessibilityHint=[NSString stringWithFormat:@"%.0lf000", pickView.datePicker.date.timeIntervalSince1970];
    }
    [self textFieldUserEnable:true OfView:self.view];
    
}
#pragma mark HWDownDelegate
- (void)downSelectedView:(HWDownSelectedView *)selectedView didSelectedAtIndex:(NSIndexPath *)indexPath{
    _scrollView.scrollEnabled=true;
    [self textFieldUserEnable:true OfView:self.view];
    
}
-(void)downSelectedView:(UIView *)aView WillShow:(BOOL)show orClose:(BOOL)close{
    if (show) {
        _scrollView.scrollEnabled=false;
          [self textFieldUserEnable:false OfView:self.view];

    }else{
        _scrollView.scrollEnabled=true;
          [self textFieldUserEnable:true OfView:self.view];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     NSArray* _titleArray=@[@"全部",@"工程审计",@"跟踪审计",@"专项审计"];
    return _titleArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        UILabel *aLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 0, 70, 28)];
        aLabel.textAlignment=NSTextAlignmentLeft;
        aLabel.tag=10000;
        aLabel.textColor=[UIColor blackColor];
        [cell.contentView addSubview:aLabel];
        aLabel.font = [UIFont systemFontOfSize:15.0];
        
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0,29, 85, 1)];
        lineView.backgroundColor=[UIColor lightGrayColor];
        [cell.contentView addSubview:lineView];
    }
    UILabel *aLabel=[cell viewWithTag:10000];
    NSArray* _titleArray=@[@"全部",@"工程审计",@"跟踪审计",@"专项审计"];
    aLabel.text = [_titleArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
    
    [tableView removeFromSuperview];
}
#pragma mark -YZNavigationMenuViewDelegate
- (void)navigationMenuView:(YZNavigationMenuView *)menuView clickedAtIndex:(NSInteger)index{
    
   
    switch (index) {
           
        case 0:
        {
            OAprogressMonitorViewController *moct=[[OAprogressMonitorViewController alloc]init];
            [self.navigationController pushViewController:moct animated:YES];
        }
            break;
        case 1:
        {
           
        }
            break;
            
            
        default:
            break;
    }
    _menuView.hidden=YES;
    
   
}
#pragma mark - alertdelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([alertView.accessibilityHint isEqualToString:@"提交"]) {
        if (buttonIndex==0) {
             [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self confirmedTapped:nil];
        }
    }else if ([alertView.accessibilityHint isEqualToString:@"附件选择"]){
        if (buttonIndex==1) {
            [self selecteFromLib];
        }else if (buttonIndex==2) {
            [self gotoDownFile];
        }
        
    }
  
}
#pragma  mark SelectFileViewControllerDelegate
-(void)confirmBtTappedWithFile:(NSArray *)files onController:(SelectFileViewController *)avct{
    
    
}
#pragma mark - ELCImagePickerDelegate
- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    //NSMutableArray *images = [NSMutableArray array];
    NSMutableArray *result= [NSMutableArray array];
    //保存图片占用线程时间长，改异步
    if(picker.returnsImage){
        for (NSDictionary *dict in info) {
            if (([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto)&&([dict objectForKey:UIImagePickerControllerOriginalImage])){
                [result addObject:dict[@"imgName"]];
            }
        }
    }else{
        [result addObjectsFromArray:info];;
    }
    _selectedImvs=result;
    if (_selectedImvs.count>0) {
        selectedFileLb.text=[NSString stringWithFormat:@"已选%ld项文件",_selectedImvs.count];
    }
    NSLog(@"%@",result);
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
//        [self uploadAllAttach];
    }];
}


- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
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
