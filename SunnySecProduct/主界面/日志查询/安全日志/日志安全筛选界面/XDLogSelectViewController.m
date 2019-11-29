//
//  XDLogSelectViewController.m
//  SunnySecProduct
//
//  Created by Huuuuuuj on 2018/1/16.
//  Copyright © 2018年 SunnySec. All rights reserved.
//

#import "XDLogSelectViewController.h"
#import "Config.h"
#import "XDLogSelectCell.h"
@interface XDLogSelectViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray * titleArray;
@property(nonatomic,assign)NSInteger  selectIndex;
@end
static NSString * const reuseCellID = @"cell";
@implementation XDLogSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"安全日志筛选";
    self.navigationBar.rightButton = [YCNavigationBar createBarItemWithTitle:@"完成" target:self action:@selector(complete)];
    self.titleArray = @[@"登录",@"新增用户",@"删除用户",@"修改用户昵称",@"修改用户签票限额",@"修改个人口令",@"重制用户口令"];
    
    [self addTableView];
}

-(void)addTableView{
    UITableView * myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar,SCREEN_WIDTH , SCREENH_HEIGHT- Height_NavBar) style:UITableViewStyleGrouped];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.rowHeight = 50;
       myTableView.separatorStyle = 0;
    myTableView.backgroundColor = [UIColor colorWithExadecimalString:@"eeeeee"];
    [myTableView registerNib:[UINib nibWithNibName:@"XDLogSelectCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuseCellID];
    
    [self.view addSubview:myTableView];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XDLogSelectCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"XDLogSelectCell" owner:self options:nil].firstObject;
    }
    if (indexPath.row == self.selectIndex) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
         cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.CTitleLabel.text = self.titleArray[indexPath.row];
    
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectIndex = indexPath.row;
    [tableView reloadData];
}

-(void)complete{
    NSLog(@"完成");
    
}


@end
