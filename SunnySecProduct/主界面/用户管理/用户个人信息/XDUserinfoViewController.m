//
//  XDUserinfoViewController.m
//  SunnySecProduct
//
//  Created by Huuuuuuj on 2017/12/15.
//  Copyright © 2017年 SunnySec. All rights reserved.
//

#import "XDUserinfoViewController.h"
#import "Config.h"
#import "XDMainTableViewCell.h"
#import "XDMainFirstTableViewCell.h"
#import "DeleteFooterView.h"
#import "XDChangeUSerNameController.h"
#import "XDChangePasswordViewController.h"
#import "XDChangelimitViewController.h"
#import "XDEnterpriseAccountViewController.h"
#import "XDUserModel.h"
@interface XDUserinfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * myTable;
@end

@implementation XDUserinfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.leftButton.hidden = NO;
    self.title = @"用户个人信息";
    [self addTableView];
}


-(void)addTableView{
    UITableView * myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64,SCREEN_WIDTH , SCREENH_HEIGHT- 64) style:UITableViewStyleGrouped];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.rowHeight = 50;
    self.myTable = myTableView;
    myTableView.tableFooterView = [self createFooterView];
    myTableView.backgroundColor = [UIColor colorWithExadecimalString:@"efeff4"];
    [self.view addSubview:myTableView];
}

-(UIView *)createFooterView{
    
    DeleteFooterView * footerView = [[NSBundle mainBundle]loadNibNamed:@"DeleteFooterView" owner:self  options:nil].firstObject;
    [footerView.deleteBut addTarget:self action:@selector(deleteThisData) forControlEvents:UIControlEventTouchUpInside];
    
    if (SCREEN_WIDTH < 375) {
        footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 52);
    }else{
        footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 60);
    }
    return footerView;
    
}

-(void)deleteThisData{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否删除该用户" preferredStyle:UIAlertControllerStyleAlert];
    kWS(weakSelf)
    UIAlertAction * cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction * delAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
             BOOL success = [[XDDataBase sharedDataBase]deleteUser:self.xduserModel];
        if (success) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:@"兄弟出错了，请稍后再试"];
        }
    }];
    
    [alertController addAction:cancleAction];
    [alertController addAction:delAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
    
   
    
}

#pragma mark -- TableviewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        XDMainFirstTableViewCell * fcell = [[NSBundle mainBundle]loadNibNamed:@"XDMainFirstTableViewCell" owner:self options:nil].firstObject;
        fcell.selectionStyle = 0;
        return fcell;
    }else{
        XDMainTableViewCell * scell = [[NSBundle mainBundle]loadNibNamed:@"XDMainTableViewCell" owner:self options:nil].firstObject;
        scell.selectionStyle = 0;
        if (indexPath.row == 0) {
            scell.CImageView.image = [UIImage imageNamed:@"user_72px_508421_easyicon"];
            scell.CTitleLabel.text = [NSString stringWithFormat:@"姓名:%@",self.xduserModel.nickname];
        }
        if (indexPath.row == 1) {
            scell.CImageView.image = [UIImage imageNamed:@"password_72px_1121320_easyicon"];
            scell.CTitleLabel.text = @"修改密码";
        }
        if (indexPath.row == 2) {
            scell.CImageView.image = [UIImage imageNamed:@"money_bag_72px_1121309_easyicon"];
            scell.CTitleLabel.text = @"签发限额(元):100000.00";
        }
        if (indexPath.row ==3) {
            scell.CImageView.image = [UIImage imageNamed:@"Account_card_72px_1104450_easyicon"];
            scell.CTitleLabel.text = @"企业账户:";
        }
        return scell;
    }
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            XDChangeUSerNameController * xdcname = [[XDChangeUSerNameController alloc]init];
            xdcname.userModel = self.xduserModel;
            kWS(weakSelf)
            xdcname.changeBlock = ^(XDUserModel *userModel) {
                weakSelf.xduserModel = userModel;
                [weakSelf.myTable reloadData];
            };
            [self.navigationController pushViewController:xdcname animated:YES];
        }
        if (indexPath.row == 1) {
            XDChangePasswordViewController * xdcpass = [[XDChangePasswordViewController alloc]init];
            [self.navigationController pushViewController:xdcpass animated:YES];
        }
        if (indexPath.row == 2) {
            XDChangelimitViewController * xdcl = [[XDChangelimitViewController alloc]init];
            [self.navigationController pushViewController:xdcl animated:YES];
        }
        if (indexPath.row == 3) {
            XDEnterpriseAccountViewController * xdcl = [[XDEnterpriseAccountViewController alloc]init];
            [self.navigationController pushViewController:xdcl animated:YES];
        }
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
    
}

@end
