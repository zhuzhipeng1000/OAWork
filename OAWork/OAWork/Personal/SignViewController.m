

//
//  SignViewController.m
//  UIViewTool
//
//  Created by 李志华 on 2017/3/29.
//  Copyright © 2017年 李志华. All rights reserved.
//

#import "SignViewController.h"
#import "UIView+Helper.h"

@interface SignViewController ()
@property(nonatomic, strong) UIImageView *signImageView;
@property (nonatomic, strong) UILabel *placeHoalderLabel;
@property(nonatomic, assign) CGPoint lastPoint;
@property(nonatomic, assign) BOOL isSwiping;
@property(nonatomic, strong) NSMutableArray *pointXs;
@property(nonatomic, strong) NSMutableArray *pointYs;

@property (nonatomic, copy) SignResult result;

@end

@implementation SignViewController
-(NSMutableArray*)pointXs {
    if (!_pointXs) {
        _pointXs=[[NSMutableArray alloc]initWithCapacity:0];
    }
    return _pointXs;
}
-(NSMutableArray*)pointYs {
    if (!_pointYs) {
        _pointYs=[[NSMutableArray alloc]initWithCapacity:0];
    }
    return _pointYs;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)viewWillLayoutSubviews {
    [self layoutSubviews];
}
- (NSDictionary *)RGBDictionaryByColor:(UIColor *)color {
    CGFloat red = 0, green = 0, blue = 0, alpha = 0;
    if ([self respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [color getRed:&red green:&green blue:&blue alpha:&alpha];
    } else {
       const CGFloat *compoments = CGColorGetComponents(color.CGColor);
        red = compoments[0];
        green = compoments[1];
        blue = compoments[2];
        alpha = compoments[3];
    }
    return @{@"red":@(red), @"green":@(green), @"blue":@(blue), @"alpha":@(alpha)};
}
- (void)layoutSubviews {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 44)];
    UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
    line.y = topView.bottom;
    line.width = topView.width;
    line.height = 1;
    line.backgroundColor = [UIColor colorWithRed:0.8 green:0 blue:0 alpha:0.8];
    [self.view addSubview:line];
    [self.view addSubview:topView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 100, 44);
    [backBtn setTitle:@" <返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backBtn];
    //
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.width = 100;
    titleLabel.height = 44;
    titleLabel.center = topView.center;
    titleLabel.text = @"电子签名";
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = [UIColor blackColor];
    [topView addSubview:titleLabel];
    //
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.x = 10;
    imageView.y = topView.bottom + 10;
    imageView.width = self.view.width - 20;
    imageView.height = self.view.height - (topView.bottom + 20 + 50);
    imageView.layerCornerRadius = 10;
    imageView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.signImageView = imageView;
    [self.view addSubview:imageView];
    UILabel *placeHoalderLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    placeHoalderLabel.width = imageView.width;
    placeHoalderLabel.height = 100;
    placeHoalderLabel.center = imageView.center;
    placeHoalderLabel.textAlignment = NSTextAlignmentCenter;
    if (self.signPlaceHoalder) {
        placeHoalderLabel.text = self.signPlaceHoalder;
    } else {
        placeHoalderLabel.text = @"签名区域";
    }
    placeHoalderLabel.font = [UIFont systemFontOfSize:35];
    placeHoalderLabel.alpha = 0.8;
    placeHoalderLabel.textColor = [UIColor grayColor];
    self.placeHoalderLabel = placeHoalderLabel;
    [self.view addSubview:placeHoalderLabel];
    //
    UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clearBtn.frame = CGRectZero;
    clearBtn.y = imageView.bottom + 10;
    clearBtn.width = self.view.width / 2;
    clearBtn.height = 50;
    clearBtn.layer.borderColor = [UIColor redColor].CGColor;
    clearBtn.layer.borderWidth = 1.0;
    NSString *title = @"清除";
    if (self.signImage) {
        title = @"修改";
        imageView.image = self.signImage;
        placeHoalderLabel.hidden = YES;
    }
    [clearBtn setTitle:title forState:UIControlStateNormal];
    [clearBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [clearBtn addTarget:self action:@selector(clearSignAction:) forControlEvents:UIControlEventTouchUpInside];
    clearBtn.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.8];
    [self.view addSubview:clearBtn];
    
    UIButton *signDone = [UIButton buttonWithType:UIButtonTypeCustom];
    signDone.frame = clearBtn.frame;
    signDone.x = clearBtn.right;
    signDone.layer.borderColor = [UIColor redColor].CGColor;
    signDone.layer.borderWidth = 1.0;
    [signDone setTitle:@"完成" forState:UIControlStateNormal];
    [signDone setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [signDone addTarget:self action:@selector(signDoneAction:) forControlEvents:UIControlEventTouchUpInside];
    signDone.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:signDone];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.isSwiping = NO;
    UITouch * touch = touches.anyObject;
    self.lastPoint = [touch locationInView:self.signImageView];
    if (self.lastPoint.x > 0) {
        self.placeHoalderLabel.text = nil;
    }
    [self.pointXs addObject:[NSNumber numberWithFloat:self.lastPoint.x]];
    [self.pointYs addObject:[NSNumber numberWithFloat:self.lastPoint.y]];
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.isSwiping = YES;
    UITouch * touch = touches.anyObject;
    CGPoint currentPoint = [touch locationInView:self.signImageView];
    UIGraphicsBeginImageContext(self.signImageView.frame.size);
    [self.signImageView.image drawInRect:(CGRectMake(0, 0, self.signImageView.frame.size.width, self.signImageView.frame.size.height))];
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), self.lastPoint.x, self.lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(),kCGLineCapRound);
    CGFloat lineWidth = 3.3;
    if (self.signLineWidth) {
        lineWidth = self.signLineWidth;
    }
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), lineWidth);
    CGFloat red = 0.0, green = 0.0, blue = 0.0;
    if (self.signLineColor) {
        NSDictionary *rgbDic = [self RGBDictionaryByColor:self.signLineColor];
        red = [rgbDic[@"red"] floatValue];
        green = [rgbDic[@"green"] floatValue];
        blue = [rgbDic[@"blue"] floatValue];
    }
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(),red, green, blue, 1.0);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.signImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.lastPoint = currentPoint;
    [self.pointXs addObject:[NSNumber numberWithFloat:self.lastPoint.x]];
    [self.pointYs addObject:[NSNumber numberWithFloat:self.lastPoint.y]];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if(!self.isSwiping) {
        UIGraphicsBeginImageContext(self.signImageView.frame.size);
        [self.signImageView.image drawInRect:(CGRectMake(0, 0, self.signImageView.frame.size.width, self.signImageView.frame.size.height))];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 3.0);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 1.0);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), self.lastPoint.x, self.lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), self.lastPoint.x, self.lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        self.signImageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
}
#pragma mark getter && setter

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)backAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)signResultWithBlock:(SignResult)result {
    self.result = result;
}
- (void)signDoneAction:(UIButton *)sender {
    if (self.result) {
        self.result(self.signImageView.image);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)clearSignAction:(UIButton *)sender {
    self.signImageView.image = nil;
    self.placeHoalderLabel.hidden = NO;
    if (self.signPlaceHoalder) {
        self.placeHoalderLabel.text = self.signPlaceHoalder;
    } else {
        self.placeHoalderLabel.text = @"签名区域";
    }
}
-(BOOL)shouldAutorotate{
    return NO;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeLeft;
}


@end
