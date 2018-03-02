//
//  SelectFileViewController.m
//  图片选择器以及文件选择器上传
//
//  Created by 李骏 on 2018/2/12.
//  Copyright © 2018年 李骏. All rights reserved.
//

#import "SelectFileViewController.h"

#import "SelectedFileCollectionViewCell.h"
#import "AnimatedAlert.h"
#import "PreviewViewController.h"
#import "OAJobDetailViewController.h"
#import "NeedDoViewController.h"
#import "User.h"
#import <AFNetworking/AFNetworking.h>

@interface SelectFileViewController ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (strong ,nonatomic)UICollectionView *fileCV;
@property (strong ,nonatomic)NSMutableArray *fileArray;
@property (strong ,nonatomic)NSMutableArray *flagArray;
@property (strong ,nonatomic)UIButton *bar;
@end

@implementation SelectFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    if(self.delegate){
        [User shareUser].selectdFiles=[NSMutableArray array];
    }
    self.title =[NSString stringWithFormat: @"已选文件（%lu）",(unsigned long)[User shareUser].selectdFiles.count];

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.itemSize = CGSizeMake(144, 144);
    self.fileCV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, TOPBARCONTENTHEIGHT, self.view.frame.size.width, SCREEN_HEIGHT-TOPBARCONTENTHEIGHT) collectionViewLayout:flowLayout];
    self.fileCV.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.fileCV];
    
    [self.fileCV registerNib:[UINib nibWithNibName:@"SelectedFileCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"fileCellID"];
    self.fileCV.delegate = self;
    self.fileCV.dataSource = self;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    self.fileArray = [[NSMutableArray alloc]initWithArray:[fileManager contentsOfDirectoryAtPath:_filePath error:nil]];
    NSLog(@"%@",self.fileArray);
    
    [self.fileCV reloadData];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!_bar) {
        _bar=[[UIButton alloc]init];
        [_bar setTitle:@"确定" forState: UIControlStateNormal];
        [_bar setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_bar setTitle:@"确定" forState: UIControlStateHighlighted];
        [_bar setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [_bar addTarget:self action:@selector(confirmTapped:) forControlEvents:UIControlEventTouchUpInside];
//        _bar.frame=CGRectMake(SCREEN_WIDTH-60, 20, 60, 44);
//        [self.view addSubview:_bar];
        UIBarButtonItem* barButton = [[UIBarButtonItem alloc] initWithCustomView:_bar];
        self.navigationItem.rightBarButtonItem = barButton;
    }
    _bar.hidden=false;
    
}
-(void)confirmTapped:(UIButton*)bt{
    NeedDoViewController *targetVct;
    for (UIViewController *avct in self.navigationController.viewControllers) {
        if ([avct isKindOfClass:[OAJobDetailViewController class]]||[avct isKindOfClass:[NeedDoViewController class]]) {
            targetVct=(NeedDoViewController*)avct;
        }
    }
    if(self.delegate&&[self.delegate respondsToSelector:@selector(confirmBtTappedWithFile:onController:)]){
        [self.delegate confirmBtTappedWithFile:[User shareUser].selectdFiles onController:self];
    }
    if (targetVct) {
    
        [self.navigationController popToViewController:targetVct animated:YES];
    }
    
        
}
//标志位数组初始化
- (NSMutableArray *)flagArray
{
    if (!_flagArray) {
        _flagArray = [NSMutableArray array];
        for (int i = 0; i < self.fileArray.count; i++) {
            [self.flagArray addObject:@0];
        }
    }
    return _flagArray;
}
//点击目标给数组内的对象取反
- (void)getOpposedObject:(NSInteger)index
{
    if ([self.flagArray[index] isEqual:@0]) {
        self.flagArray[index] = @1;
    }else{
        self.flagArray[index] = @0;
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

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    SelectedFileCollectionViewCell *fileCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"fileCellID" forIndexPath:indexPath];
    fileCell.fileNameLbl.text = self.fileArray[indexPath.row];
    NSString *filePath=[NSString stringWithFormat:@"%@/%@",_filePath,fileCell.fileNameLbl.text];
    BOOL isDirectory=false;
    [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
    if (isDirectory) {
        fileCell.selectIV.hidden=YES;
    }
    
    if ([[User shareUser].selectdFiles containsObject:filePath]) {
        fileCell.selectIV.image = [UIImage imageNamed:@"xuanzhe"];
       
    }else{
         fileCell.selectIV.image = [UIImage imageNamed:@"weixuanzhe"];
    }
    //添加长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
    [fileCell.contentView addGestureRecognizer:longPress];
    
    return fileCell;
}
- (void)longPressAction:(UILongPressGestureRecognizer *)longPress
{
    __weak typeof(self)weakSelf = self;
    if ([longPress state] == UIGestureRecognizerStateBegan) {
        CGPoint p = [longPress locationInView:self.fileCV];
        NSLog(@"press at %f,%f",p.x,p.y);
        NSIndexPath *indexPath = [self.fileCV indexPathForItemAtPoint:p];
        NSString *str =[NSString stringWithFormat:@"%@/%@",_filePath,weakSelf.fileArray[indexPath.row]];
        PreviewViewController *previewVC = [[PreviewViewController alloc]init];
                    NSURL *url = [NSURL fileURLWithPath:str];
                    previewVC.url = url;
        [self.navigationController pushViewController:previewVC animated:YES];
        
//        AnimatedAlert *animateAlert = [[AnimatedAlert alloc]initWithFrame:CGRectMake(0, 0, 300, 150) leftTitle:@"查看" rightTitle:@"删除" contentText:@"您要删除这个文件吗？" cancel:^(UIView *animateAlert) {
//            PreviewViewController *previewVC = [[PreviewViewController alloc]init];
//            NSURL *url = [NSURL fileURLWithPath:str];
//            previewVC.url = url;
//            [weakSelf presentViewController:previewVC animated:YES completion:^{
//                [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
//                    animateAlert.transform =CGAffineTransformMakeScale(0.1, 0.1);
//                    animateAlert.alpha = 0;
//                } completion:^(BOOL finished) {
//                    [animateAlert removeFromSuperview];
//                }];
//            }];
//        } confirm:^(UIView *animateAlert) {
//            //删除文件
//            [[NSFileManager defaultManager]removeItemAtPath:str error:nil];
//            NSArray *tempArr = [[NSArray alloc]initWithArray:[[NSFileManager defaultManager] contentsOfDirectoryAtPath:_filePath error:nil]];
//            NSLog(@"%@",tempArr);
//            //把数据源数组删除
//            [weakSelf.fileArray removeObjectAtIndex:indexPath.row];
//            //把对应的flag也删除
//            [weakSelf.flagArray removeObjectAtIndex:indexPath.row];
//            //刷新collectionview
//            [weakSelf.fileCV reloadData];
//            [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
//                animateAlert.transform =CGAffineTransformMakeScale(0.1, 0.1);
//                animateAlert.alpha = 0;
//            } completion:^(BOOL finished) {
//                [animateAlert removeFromSuperview];
//            }];
//        }];
//        [self.view addSubview:animateAlert];
    }
}
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.fileArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(144, 144);
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 15;
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
//点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL isDirectory=false;
    NSString *filePath=[NSString stringWithFormat:@"%@/%@",_filePath,self.fileArray[indexPath.row]];
    [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
    if (isDirectory) {
        SelectFileViewController *sel=[[SelectFileViewController alloc]init];
        sel.filePath=[NSString stringWithFormat:@"%@/%@",_filePath,self.fileArray[indexPath.row]];
        [self.navigationController pushViewController:sel animated:YES];
        return;
    }
    if ([[User shareUser].selectdFiles containsObject:filePath]) {
        [[User shareUser].selectdFiles removeObject:filePath];
        
    }else{
         [[User shareUser].selectdFiles addObject:filePath];
    }
    self.title =[NSString stringWithFormat: @"已选文件（%lu）",(unsigned long)[User shareUser].selectdFiles.count];
    [self getOpposedObject:indexPath.row];
    [self.fileCV reloadData];
   
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
        NSData *data = [NSData dataWithContentsOfFile:[User shareUser].selectdFiles[0]];
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
@end
