//
//  XDChangePasswordViewController.m
//  SunnySecProduct
//
//  Created by Huuuuuuj on 2017/12/15.
//  Copyright © 2017年 SunnySec. All rights reserved.
//

#import "XDChangePasswordViewController.h"
#import "Config.h"
#import "XDChangePasswordHeaderView.h"
#import "XDUserModel.h"
@interface XDChangePasswordViewController ()
@property(nonatomic,weak)XDChangePasswordHeaderView * pwdHeaderView;
@end

@implementation XDChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    [self addTableview];
    self.view.backgroundColor = [UIColor colorWithExadecimalString:@"efeff4"];
}

-(void)addTableview{
    UITableView * myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 84.0, SCREEN_WIDTH, SCREENH_HEIGHT - 84.0) style:UITableViewStylePlain];
    myTable.tableHeaderView = [self createHeaderView];
    myTable.tableFooterView = [self createFooterView];
    myTable.backgroundColor = [UIColor colorWithExadecimalString:@"efeff4"];
    [self.view addSubview:myTable];
}

-(UIView *)createHeaderView{
    XDChangePasswordHeaderView * headerView = [[NSBundle mainBundle]loadNibNamed:@"XDChangePasswordHeaderView" owner:self options:nil].firstObject;
    headerView.userNameLabel.text = self.userModel.username;
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
    self.pwdHeaderView = headerView;
    return headerView;
}

-(UIView *)createFooterView{
    
    UIView * footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    footerView.backgroundColor = [UIColor colorWithExadecimalString:@"efeff4"];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(SCREEN_WIDTH/6, 20, SCREEN_WIDTH*2.0/3.0, 42);
    [button setTitle:@"修改密码" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor whiteColor]];
    [button setTitleColor:[UIColor colorWithExadecimalString:@"3399ff"] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.layer.cornerRadius = 5;
    [button addTarget:self action:@selector(changeThepwd) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:button];
    return footerView;
}
-(void)changeThepwd{
    if (self.pwdHeaderView.firstPWDTField.text.length && self.pwdHeaderView.secondPWDTField.text.length) {
//        if (self.pwdHeaderView.firstPWDTField.text isEqualToString:self.pwdHeaderView.secondPWDTField.text) {
//            self.XDUserModel.
//            
//        }
        
    }
    
    
}

@end
