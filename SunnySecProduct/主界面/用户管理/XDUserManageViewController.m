//
//  XDUserManageViewController.m
//  SunnySecProduct
//
//  Created by Huuuuuuj on 2017/12/15.
//  Copyright © 2017年 SunnySec. All rights reserved.
//

#import "XDUserManageViewController.h"
#import "Config.h"
#import "XDMainTableViewCell.h"
#import "XDMainFirstTableViewCell.h"
#import "XDUserManageViewController.h"
#import "XDUserinfoViewController.h"
#import "XDAddNewUserViewController.h"
#import "XDUserModel.h"
@interface XDUserManageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray * userDataMutArray;
@property(nonatomic,strong)UITableView * myTable;
@end

@implementation XDUserManageViewController

-(NSMutableArray *)userDataMutArray{
    if (!_userDataMutArray) {
        _userDataMutArray = [NSMutableArray array];
    }
    return _userDataMutArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.leftButton.hidden = NO;
    self.navigationBar.rightButton = [YCNavigationBar createBarItemWithImage:@"add_user_72px_508414_easyicon" imgHighlight:@"add_user_72px_508414_easyicon" target:self action:@selector(addNewAccount)];
    self.title = @"用户管理";
    [self addTableView];
}

-(void)addNewAccount{
    XDAddNewUserViewController * xda = [[XDAddNewUserViewController alloc]init];
    [self.navigationController pushViewController:xda animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.userDataMutArray removeAllObjects];
   NSMutableArray * dbArray =  [[XDDataBase sharedDataBase] getAllUser];
   
    for (XDUserModel * model  in dbArray) {
        [self.userDataMutArray addObject:model];
    }
    [self.myTable reloadData];
}

-(void)addTableView{
    UITableView * myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64,SCREEN_WIDTH , SCREENH_HEIGHT- 64) style:UITableViewStyleGrouped];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.rowHeight = 50;
    myTableView.backgroundColor = [UIColor colorWithExadecimalString:@"efeff4"];
    self.myTable = myTableView;
    [self.view addSubview:myTableView];
}

#pragma mark -- TableviewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    return self.userDataMutArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        XDMainFirstTableViewCell * fcell = [[NSBundle mainBundle]loadNibNamed:@"XDMainFirstTableViewCell" owner:self options:nil].firstObject;
        fcell.selectionStyle = 0;
        return fcell;
        
    }else{
        XDMainTableViewCell * scell = [[NSBundle mainBundle]loadNibNamed:@"XDMainTableViewCell" owner:self options:nil].firstObject;
          scell.selectionStyle = 0;
          scell.CImageView.image = [UIImage imageNamed:@"user_72px_508421_easyicon"];
        [scell cellLoadWithUserModel:self.userDataMutArray[indexPath.row]];
        return scell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 1) {

            XDUserinfoViewController * xdu = [[XDUserinfoViewController alloc]init];
           xdu.xduserModel = self.userDataMutArray[indexPath.row];
            [self.navigationController pushViewController:xdu animated:YES];
    }
}


@end
