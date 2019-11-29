//
//  XDBankCertificateViewController.m
//  SunnySecProduct
//
//  Created by Huuuuuuj on 2018/6/12.
//  Copyright © 2018年 SunnySec. All rights reserved.
//

#import "XDBankCertificateViewController.h"
#import "Config.h"
#import "XDMainTableViewCell.h"
#import "XDMainFirstTableViewCell.h"
#import "XDAddNewCerViewController.h"
@interface XDBankCertificateViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * myTable;
@end
static NSString * const reuseCellID = @"cell";

@implementation XDBankCertificateViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"银行凭证";
    [self addTableView];
        self.navigationBar.rightButton = [YCNavigationBar createBarItemWithTitle:@"添加凭证" target:self action:@selector(addNewCer)];
}

-(void)addTableView{
    UITableView * myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar,SCREEN_WIDTH , SCREENH_HEIGHT- Height_NavBar) style:UITableViewStyleGrouped];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.separatorColor = [UIColor colorWithExadecimalString:@"eeeeee"];
    myTableView.rowHeight = 50;
    myTableView.backgroundColor = [UIColor colorWithExadecimalString:@"eeeeee"];
    [self.view addSubview:myTableView];
}

#pragma mark -- TableviewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return 5;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        return YES;
    }
    return NO;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        XDMainFirstTableViewCell * cell = [[NSBundle mainBundle]loadNibNamed:@"XDMainFirstTableViewCell" owner:self options:nil].firstObject;
        cell.selectionStyle = 0;
        cell.firstLabel.text = [NSString stringWithFormat:@"%@凭证列表:",self.bankName];
        cell.secondLabel.text = @"";
        cell.selectionStyle = 0;
        return cell;
    }
    
    XDMainTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"XDMainTableViewCell" owner:self options:nil].firstObject;
    }
    cell.selectionStyle = 0;
    cell.CImageView.image =  [UIImage imageNamed:@"Issue_Icon_type"];
    cell.CTitleLabel.text = @"85253633852536338525363385253633";
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    XDAddNewCerViewController * xda = [[XDAddNewCerViewController alloc]init];
    xda.heheTitle = @"凭证详情";
    
    [self.navigationController pushViewController:xda animated:YES];
    
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //可在此对点击cell右边出现的按钮进行逻辑处理
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否要删除该条凭证信息" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction * delAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [SVProgressHUD showSuccessWithStatus:@"删除成功"];
    }];
    [alertController addAction:cancleAction];
    [alertController addAction:delAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

//设置左滑删除按钮的文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置右边按钮的文字
    return @"删除";
}


-(void)addNewCer{
//    [SVProgressHUD showWithStatus:@"正在添加新的凭证"];
    XDAddNewCerViewController * xda = [[XDAddNewCerViewController alloc]init];
     xda.heheTitle = @"添加凭证";
    [self.navigationController pushViewController:xda animated:YES];
    
}

@end
