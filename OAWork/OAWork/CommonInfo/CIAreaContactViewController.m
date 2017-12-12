//
//  CIAreaContactViewController.m
//  OAWork
//
//  Created by james on 2017/12/11.
//  Copyright © 2017年 james. All rights reserved.
//

#import "CIAreaContactViewController.h"

@interface CIAreaContactViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property (nonatomic,strong) UITableView *demoTableView;
@property (nonatomic,strong) NSMutableArray* allArray;
@property (nonatomic,strong) NSMutableArray *searchArr;
@property (nonatomic,strong) UISearchBar *searchBar;

@end

@implementation CIAreaContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _allArray=[@[@"广州",@"行政",@"人事",@"财务"]  mutableCopy];
    self.view.backgroundColor=[Utils colorWithHexString:@"#f7f7f7"];
    
    _searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(20, TOPBARCONTENTHEIGHT+10,SCREEN_WIDTH-40, 35)];
    _searchBar.delegate=self;
    UIImage* searchBarBg = [Utils GetImageWithColor:[UIColor whiteColor] andHeight:32.0f];
    //设置背景图片
    [_searchBar setBackgroundImage:searchBarBg];
    //设置背景色
    [_searchBar setBackgroundColor:[UIColor clearColor]];
    //设置文本框背景
    [_searchBar setSearchFieldBackgroundImage:searchBarBg forState:UIControlStateNormal];
    //    seach. barStyle= UIBarStyleBlack;
    _searchBar.backgroundColor=[UIColor whiteColor];
    //    _searchBar.showsCancelButton=YES;
    _searchBar.placeholder=@"请输入关键词";
    _searchBar.layer.cornerRadius=20;
    _searchBar.clipsToBounds=true;
    [self.view addSubview:_searchBar];
    
    _demoTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,_searchBar.bottom+10, SCREEN_WIDTH, SCREEN_HEIGHT-_searchBar.bottom)];
    [_demoTableView registerNib:[UINib nibWithNibName:@"OaMainCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"OaMainCellTableViewCell"];
    _demoTableView.delegate=self;
    _demoTableView.dataSource=self;
    _demoTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_demoTableView];
    // Do any additional setup after loading the view.
}
#pragma mark UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *Arra=_searchBar.text.length?_searchArr:_allArray;
    NSDictionary *Adic =Arra[indexPath.row];
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static  NSString  *CellIdentiferId = @"CIAllContactViewController";
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentiferId];
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentiferId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
       
        
        UIImageView *im=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
        im.frame=CGRectMake(15, 15, 40, 40);
        im.tag=1001;
        [cell.contentView addSubview:im];
        
        UILabel *nameLb=[[UILabel alloc]initWithFrame:CGRectMake(im.right+10, 0, SCREEN_WIDTH-im.right-10-200, im.bottom+im.top)];
        nameLb.textColor=[UIColor lightGrayColor];
        nameLb.font=[UIFont systemFontOfSize:14.0];
        nameLb.tag=1002;
        [cell.contentView addSubview:nameLb];
        
        UILabel *phoneNu=[[UILabel alloc]initWithFrame:CGRectMake(nameLb.right, 0, SCREEN_WIDTH-nameLb.right-10, 40)];
        phoneNu.textColor=[Utils colorWithHexString:@"#363636"];
        phoneNu.font=[UIFont systemFontOfSize:14.0];
        phoneNu.textAlignment=NSTextAlignmentRight;
        phoneNu.tag=1003;
        [cell.contentView addSubview:phoneNu];
        
        UILabel *emailLB=[[UILabel alloc]initWithFrame:CGRectMake(nameLb.right, phoneNu.bottom, SCREEN_WIDTH-nameLb.right-10, 30)];
        emailLB.textAlignment=NSTextAlignmentRight;
        emailLB.textColor=[Utils colorWithHexString:@"#898989"];;
        emailLB.font=[UIFont systemFontOfSize:14.0];
        emailLB.tag=1004;
        [cell.contentView addSubview:emailLB];
        
        UIView *bottomStrait=[[UIView alloc]initWithFrame:CGRectMake(0,im.bottom+im.top-1, SCREEN_WIDTH, 1)];
        bottomStrait.backgroundColor=[Utils colorWithHexString:@"#e4e4e4"];
        [cell.contentView addSubview:bottomStrait];
    };
    UIImageView *imv=[cell.contentView viewWithTag:1001];
    UILabel *nameLb=[cell.contentView viewWithTag:1002];
    UILabel *phoneNu=[cell.contentView viewWithTag:1003];
    UILabel *emailLB=[cell.contentView viewWithTag:1004];
    imv.image=[UIImage imageNamed:@"wifi"];
    nameLb.text=@"祝之洞";
    phoneNu.text=@"18565658888";
    emailLB.text=@"658723493@qq.com";
    return  cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _allArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
    
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
