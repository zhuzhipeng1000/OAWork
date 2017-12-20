//
//  CIMessageDetailViewController.m
//  OAWork
//
//  Created by james on 2017/12/11.
//  Copyright © 2017年 james. All rights reserved.
//

#import "CIMessageDetailViewController.h"

@interface CIMessageDetailViewController ()
{
    
    
}
@end

@implementation CIMessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"销售弄长跑";
    
    UIImageView *imv=[[UIImageView alloc]initWithFrame:CGRectMake(0,TOPBARCONTENTHEIGHT, SCREEN_WIDTH, (200*SCREEN_WIDTH)/758)];
    imv.backgroundColor=[UIColor whiteColor];
    imv.contentMode=UIViewContentModeScaleAspectFit;
    imv.image=[UIImage imageNamed:@"user_copy"];
    [self.view addSubview:imv];
    
    UILabel* titleLB=[[UILabel alloc]init];
    titleLB.backgroundColor=[UIColor clearColor];
    titleLB.numberOfLines=0;
    titleLB.text=@"丽思卡尔顿酒店集团总裁兼首席运营官何威乐（Hervé Humler）先生表示：“海南岛现已成为亚太地区最振奋人心的新兴旅行目的地之一。我们将与合作伙伴— 观澜湖集团携手打造全世界最引人入胜的挥杆及休闲旅行体验。海南岛拥有绚烂多姿的地方文化，其与众不同的旅行体验为旅行者呈现前所未见的中华风貌，可谓家庭游客及与亲朋好友一道游览探索的理想之地。海口丽思卡尔顿酒店设有175间客房和16间套房，坐落于素有“东方夏威夷”美誉的海南岛，这里全年阳光充沛，拥有浓郁鲜明的热带气息。酒店毗邻占地350英亩的黑石球场（Blackstone Course），赫赫有名的观澜湖高尔夫球会环绕四周，建于火山喷发形成的基岩之上，集嶙峋的岩层地貌、丛林植被、广袤的湖泊及大片湿地于一体，以其绚丽多姿的壮美景观著称。下榻海口丽思卡尔顿的客人可在任意一间客房内欣赏窗外的秀美风光，感受大自然的杰作与馈赠。 酒店的建筑与设计由AECOM集团一手操刀，细节之处无不彰显对高尔夫传统的致敬；酒店的内部设计则充满典雅雍容的高尔夫会所风格，由赫希贝德纳联合有限公司(HBA)洛杉矶分公司全权负责。客房所采用的纺织品及图案体现了复古高尔夫元素，且设计上绝无重复之处。墙板及灯具萃取手工高尔夫球鞋拼接图案之灵感，客床上古风皮革的设计来自复古款高尔夫球袋，地板上的花呢格纹则令客人想到高尔夫的发源地—苏格兰。";
    titleLB.font=[UIFont systemFontOfSize:16.0f];
    titleLB.lineBreakMode=NSLineBreakByWordWrapping;
    titleLB.textAlignment=NSTextAlignmentCenter;
    titleLB.backgroundColor=[Utils colorWithHexString:@"#f7f7f7"];
    CGSize textSize=  [Utils sizeWithText:titleLB.text font:titleLB.font maxSize:CGSizeMake(SCREEN_WIDTH, 100)];
    
    titleLB.frame=CGRectMake(0,imv.bottom, SCREEN_WIDTH, textSize.height+10);
    [self.view addSubview:titleLB];
    // Do any additional setup after loading the view.
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
