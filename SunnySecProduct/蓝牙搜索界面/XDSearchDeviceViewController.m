//
//  XDSearchDeviceViewController.m
//  SunnySecProduct
//
//  Created by Huuuuuuj on 2017/12/14.
//  Copyright © 2017年 SunnySec. All rights reserved.
//

#import "XDSearchDeviceViewController.h"
#import "XDSearchHeaderView.h"
#import "Config.h"
@interface XDSearchDeviceViewController ()
@property(nonatomic,strong)XDSearchHeaderView * searchHeaderView;
@end

@implementation XDSearchDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"张二狗";
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self addHeaderView];
    [self addSearchTableView];
    
}

-(void)addHeaderView{
    XDSearchHeaderView * headerView = [[NSBundle mainBundle]loadNibNamed:@"XDSearchHeaderView" owner:self options:nil].firstObject;
    headerView.frame = CGRectMake(0, 20,SCREEN_WIDTH, SCREEN_WIDTH/5);
    [self.view addSubview:headerView];
}

-(void)addSearchTableView{
    UITableView * myTable = [UITableView alloc]initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>) style:<#(UITableViewStyle)#>
    
    
}


@end
