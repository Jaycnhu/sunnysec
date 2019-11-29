//
//  XDChangelimitViewController.m
//  SunnySecProduct
//
//  Created by Huuuuuuj on 2017/12/15.
//  Copyright © 2017年 SunnySec. All rights reserved.
//

#import "XDChangelimitViewController.h"
#import "XDChangeLimitHeaderView.h"
#import "Config.h"
@interface XDChangelimitViewController ()

@end

@implementation XDChangelimitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改前发限额";
    [self addTableview];
    self.view.backgroundColor = [UIColor colorWithExadecimalString:@"efeff4"];
}

-(void)addTableview{
    UITableView * myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 84.0, SCREEN_WIDTH, SCREENH_HEIGHT - 84.0) style:UITableViewStylePlain];
    myTable.tableHeaderView = [self createHeaderView];
    myTable.tableFooterView = [[UIView alloc]init];
    myTable.backgroundColor = [UIColor colorWithExadecimalString:@"efeff4"];
    [self.view addSubview:myTable];
}

-(UIView *)createHeaderView{
    XDChangeLimitHeaderView * headerView = [[NSBundle mainBundle]loadNibNamed:@"XDChangeLimitHeaderView" owner:self options:nil].firstObject;
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 242);
    return headerView;
}





@end
