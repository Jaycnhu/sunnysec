//
//  XDAddNewCerViewController.m
//  SunnySecProduct
//
//  Created by Huuuuuuj on 2018/6/13.
//  Copyright © 2018年 SunnySec. All rights reserved.
//

#import "XDAddNewCerViewController.h"
#import "Config.h"
#import "CerDetialHeaderView.h"
#import "CerDetialFooterView.h"
#import "XDChoiceIssueTypeViewController.h"
@interface XDAddNewCerViewController ()

@end

@implementation XDAddNewCerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    UITableView * myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, SCREEN_WIDTH, SCREENH_HEIGHT - Height_NavBar) style:UITableViewStylePlain];
    myTable.tableHeaderView = [self createHeaderView];
    self.title = self.heheTitle;
    NSLog(@"mytitle = %@",self.heheTitle);
    if ([self.heheTitle isEqualToString:@"凭证详情"]) {
        self.navigationBar.rightButton = [YCNavigationBar createBarItemWithTitle:@"修改凭证" target:self action:@selector(changeCer)];
         myTable.tableFooterView  = [UIView new];
    }else{
    myTable.tableFooterView  = [self createFooterView];
    }
    [myTable setContentInset:UIEdgeInsetsMake(35.0, 0, 0, 0)];
    myTable.backgroundColor = [UIColor colorWithExadecimalString:@"eeeeee"];
    [self.view addSubview:myTable];
}

-(UIView *)createFooterView{
     CerDetialFooterView * sld = [[NSBundle mainBundle]loadNibNamed:@"CerDetialFooterView" owner:self options:nil].firstObject;
    if ([self.heheTitle isEqualToString:@"删除凭证"]) {
    sld.viewState = footerViewStateDelete;
    }else if ([self.heheTitle isEqualToString:@"修改凭证"]){
          sld.viewState = footerViewStateChange;
    }else{
          sld.viewState = footerViewStateDefalut;
    }
   
    sld.frame = CGRectMake(0, 0, SCREEN_WIDTH, 60);
    return sld;
}

-(UIView *)createHeaderView{
     CerDetialHeaderView * sld = [[NSBundle mainBundle]loadNibNamed:@"CerDetialHeaderView" owner:self options:nil].firstObject;
    kWS(weakSelf)
    sld.tBlock = ^{
        XDChoiceIssueTypeViewController * hh = [[XDChoiceIssueTypeViewController alloc]init];
        hh.typeBlock = ^(NSInteger row,NSString * typeStr) {
         
            
            
        };
        [weakSelf.navigationController pushViewController:hh animated:YES];
        
        
    };
    
    if ([self.heheTitle isEqualToString:@"凭证详情"]) {
        sld.showBoder = NO;
    }else{
        sld.showBoder = YES;
        
    }
    
    sld.frame = CGRectMake(0, 20, SCREEN_WIDTH, 300);
    return sld;
}

-(void)changeCer{
    XDAddNewCerViewController * xda = [[XDAddNewCerViewController alloc]init];
    xda.heheTitle = @"修改凭证";
    [self.navigationController pushViewController:xda animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
