//
//  XDEnterpriseAccountViewController.m
//  SunnySecProduct
//
//  Created by Huuuuuuj on 2017/12/15.
//  Copyright © 2017年 SunnySec. All rights reserved.
//

#import "XDEnterpriseAccountViewController.h"
#import "Config.h"
#import "XDMainTableViewCell.h"
#import "XDMainFirstTableViewCell.h"
#import "XDEATableViewCell.h"
@interface XDEnterpriseAccountViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation XDEnterpriseAccountViewController
static NSString * const reuseCellID = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"企业账户";
    [self addTableView];
}

-(void)addTableView{
    UITableView * myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64,SCREEN_WIDTH , SCREENH_HEIGHT- 64) style:UITableViewStyleGrouped];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.rowHeight = 50;
    [myTableView registerNib:[UINib nibWithNibName:@"XDEATableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuseCellID];
  
    myTableView.backgroundColor = [UIColor colorWithExadecimalString:@"efeff4"];
    [self.view addSubview:myTableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 1;
    }
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        XDMainTableViewCell * cell = [[NSBundle mainBundle]loadNibNamed:@"XDMainTableViewCell" owner:self options:nil].firstObject;
        cell.CImageView.image = [UIImage imageNamed:@"user_72px_508421_easyicon"];
            cell.CTitleLabel.text = @"张二狗";
        return cell;
    }
    if (indexPath.section == 1) {
        XDMainFirstTableViewCell * cell = [[NSBundle mainBundle]loadNibNamed:@"XDMainFirstTableViewCell" owner:self options:nil].firstObject;
        cell.firstLabel.text = @"企业账户列表:";
        cell.secondLabel.text = @"";
        return cell;
    }
    if (indexPath.section == 2) {
        XDEATableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseCellID];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"XDEATableViewCell" owner:self options:nil].firstObject;
        }
        
        return cell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
    
}


@end
