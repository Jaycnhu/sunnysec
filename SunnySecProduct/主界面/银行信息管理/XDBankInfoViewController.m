//
//  XDBankInfoViewController.m
//  SunnySecProduct
//
//  Created by Huuuuuuj on 2018/6/12.
//  Copyright © 2018年 SunnySec. All rights reserved.
//

#import "XDBankInfoViewController.h"
#import "Config.h"
#import "XDMainTableViewCell.h"
#import "XDBankCertificateViewController.h"
@interface XDBankInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * myTable;
@property(nonatomic,strong)NSMutableArray * bankNames;
@property(nonatomic,strong)NSMutableArray * bankIcons;
@end
static NSString * const reuseCellID = @"cell";

@implementation XDBankInfoViewController

-(NSMutableArray *)bankIcons{
    if (!_bankIcons) {
        _bankIcons =  [NSMutableArray array];
    }
    return _bankIcons;
}

-(NSMutableArray *)bankNames{
    if (!_bankNames) {
        _bankNames =  [NSMutableArray array];
    }
    return _bankNames;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"银行信息";
    [self addTableView];
   NSArray * haha = [NSArray arrayWithObjects:@"中国银行",@"农业银行",@"工商银行",@"建设银行",@"交通银行", nil];
     NSArray * hehe = [NSArray arrayWithObjects:@"cbc",@"abccon",@"cbec",@"ccbc",@"boc", nil];
    [self.bankNames  addObjectsFromArray:haha];
    [self.bankIcons addObjectsFromArray:hehe];
       self.navigationBar.rightButton = [YCNavigationBar createBarItemWithTitle:@"添加银行信息" target:self action:@selector(addNewCer)];
}

-(void)addTableView{
    UITableView * myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar,SCREEN_WIDTH , SCREENH_HEIGHT- Height_NavBar) style:UITableViewStyleGrouped];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.separatorColor = [UIColor colorWithExadecimalString:@"eeeeee"];
    myTableView.rowHeight = 50;
    myTableView.backgroundColor = [UIColor colorWithExadecimalString:@"eeeeee"];
    self.myTable = myTableView;
    [self.view addSubview:myTableView];
}

#pragma mark -- TableviewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.bankNames.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XDMainTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"XDMainTableViewCell" owner:self options:nil].firstObject;
    }
    cell.selectionStyle = 0;
    cell.CTitleLabel.text =  self.bankNames[indexPath.row];
    cell.CImageView.contentMode = UIViewContentModeScaleAspectFit;
    if (indexPath.row > (self.bankIcons.count - 1)) {
           cell.CImageView.image = [UIImage imageNamed:@""];
    }else{
    cell.CImageView.image = [UIImage imageNamed:self.bankIcons[indexPath.row]];
    }
    return  cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    XDBankCertificateViewController * xdsl = [[XDBankCertificateViewController alloc]init];
    xdsl.bankName = self.bankNames[indexPath.row];
    [self.navigationController pushViewController:xdsl animated:YES];
    
}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
        return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //可在此对点击cell右边出现的按钮进行逻辑处理
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否要删除该条银行信息" preferredStyle:UIAlertControllerStyleAlert];
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
    //添加银行信息
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"添加银行信息" message:@"请输入要添加的银行名称" preferredStyle:UIAlertControllerStyleAlert];
        //以下方法就可以实现在提示框中输入文本；
        
        //在AlertView中添加一个输入框
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            
            textField.placeholder = @"请输入银行名称";
        }];
        
        //添加一个确定按钮 并获取AlertView中的第一个输入框 将其文本赋值给BUTTON的title
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UITextField *envirnmentNameTextField = alertController.textFields.firstObject;
            
            
#pragma mark -- 向蓝牙发送请求 添加银行
            
            [self.bankNames addObject:envirnmentNameTextField.text];
            [self.myTable reloadData];
//
//            //将 BUTTON 的名称设置为输入的内容
//            [self.btn setTitle:envirnmentNameTextField.text forState:(UIControlStateNormal)];
//
//            //输出 检查是否正确无误
            NSLog(@"你输入的文本%@",envirnmentNameTextField.text);
            
        }]];
        
        //添加一个取消按钮
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
        
        //present出AlertView
        [self presentViewController:alertController animated:true completion:nil];

}

@end
