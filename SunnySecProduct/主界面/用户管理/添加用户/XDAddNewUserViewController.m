//
//  XDAddNewUserViewController.m
//  SunnySecProduct
//
//  Created by Huuuuuuj on 2017/12/15.
//  Copyright © 2017年 SunnySec. All rights reserved.
//

#import "XDAddNewUserViewController.h"
#import "XDAddNewUserHeaderView.h"
#import "Config.h"
@interface XDAddNewUserViewController ()

@end

@implementation XDAddNewUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加新用户";
    self.view.backgroundColor = [UIColor colorWithExadecimalString:@"efeff4"];
    [self addTableView];
}

-(void)addTableView{
    
    UITableView * myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREENH_HEIGHT - 64) style:UITableViewStylePlain];
    myTable.tableHeaderView = [self createHeaderView];
    myTable.backgroundColor = [UIColor colorWithExadecimalString:@"efeff4"];
    myTable.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:myTable];
}

-(UIView *)createHeaderView{
    XDAddNewUserHeaderView * anu = [[NSBundle mainBundle]loadNibNamed:@"XDAddNewUserHeaderView" owner:self options:nil].firstObject;
    anu.frame = CGRectMake(0, 0, SCREEN_WIDTH, 290);
    kWS(weakSelf)
    anu.addUserBlock = ^(XDUserModel *userModel) {
        if ([[XDDataBase sharedDataBase]addUser:userModel]) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:@"失败了兄弟"];
        }
    };
    return anu;
}
@end
