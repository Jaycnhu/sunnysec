//
//  XDAuthBussinessDetialViewController.m
//  SunnySecProduct
//
//  Created by Huuuuuuj on 2018/6/28.
//  Copyright © 2018年 SunnySec. All rights reserved.
//

#import "XDAuthBussinessDetialViewController.h"
#import "XDAuthBussinessHeaderView.h"
#import "XDRecordOperateCell.h"
#import "Config.h"
#import "JudgeBottomView.h"
#import "caculateBottomView.h"
#import "XDBusinessModel.h"
#import "XDChoiceUserzViewController.h"
#import "XdCompleteBusinessCell.h"
#import "BLEToolBase.h"
#import "XDUserModel.h"
@interface XDAuthBussinessDetialViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,assign)BOOL isShowSelectAuther;
@property(nonatomic,strong)UITableView *  myTable;
@property(nonatomic,strong)XDRecordOperateCell * xdrCell;
@property(nonatomic,strong)XDUserModel * curModel;
@end

@implementation XDAuthBussinessDetialViewController

-(void)setCurModel:(XDUserModel *)curModel{
    _curModel = curModel;
    self.xdrCell.CChoiceAuthorTF.text = curModel.nickname;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"待办业务详情";
    self.view.backgroundColor = [UIColor colorWithExadecimalString:@"eeeeee"];
    [self addTableView];
    
    [self getSomeinfo];
}

-(void)getSomeinfo{
    NSString * flagstr =    [[NSUserDefaults standardUserDefaults]objectForKey:XDFLOWFLAGS];
    int flagint =  [flagstr intValue];
    uint8_t zz =  flagint & 0xFF;
    int a,b,c;
    if (zz == 0) {
        a = 0;
        b = 0;
        c = 0;
    }else{
        a =  zz &( 1<<0); //复核流程 标志位
        b =  zz & (1<<1); //授权流程 标志位
        c =  zz & (1<<2); //计算支付 密码用户  确认标志
    }
    
    if (b) { //b大于0的话 就不需要授权
        NSLog(@"不用授权");
        
    }else{
        //需要选择授权员
        self.isShowSelectAuther  = YES;
        [self.myTable reloadData];
    }
    
    
}

-(void)addTableView{
    UITableView * myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar,SCREEN_WIDTH , SCREENH_HEIGHT- Height_NavBar) style:UITableViewStylePlain];
    myTable.backgroundColor = [UIColor colorWithExadecimalString:@"eeeeee"];
    myTable.delegate = self;
    myTable.dataSource = self;
    myTable.separatorStyle = 0;
    myTable.tableHeaderView = [self createHeaderView];
    if (!self.isCompelete) {
    myTable.tableFooterView = [self createBottomView];
    }else{
        myTable.tableFooterView = [UIView new];
    }
    self.myTable = myTable;
    [myTable setContentInset:UIEdgeInsetsMake(35, 0, 0, 0)];
   
//    AppDelegate * app = HJApp;
//    if (app.roleType == XDCurrentRoleTypeReview) {
//        //判断金额需不需要审核
//        myTable.rowHeight = 140;;
//    }else{
//        myTable.rowHeight = 90;
//    }
    [self.view addSubview:myTable];
}


-(UIView *)createHeaderView{
    XDAuthBussinessHeaderView * sld = [[NSBundle mainBundle]loadNibNamed:@"XDAuthBussinessHeaderView" owner:self options:nil].firstObject;
    [sld loadViewWithBusinessModel:self.businessModel];
    sld.frame = CGRectMake(0, 0, SCREEN_WIDTH, 306);
    return sld;
}

-(UIView *)createBottomView{
    AppDelegate * app = HJApp;
    if (app.roleType == XDCurrentRoleTypeSign) {
        uint8_t  fff =  (uint8_t)[self.businessModel.Flags intValue];
      uint8_t hehe =   fff & 0x3F;
        if (hehe == 1) {
            //可以直接计算了
            caculateBottomView * sld = [[NSBundle mainBundle]loadNibNamed:@"caculateBottomView" owner:self options:nil].firstObject;
            
            sld.frame = CGRectMake(0, 0, SCREEN_WIDTH, 60);
            return sld;
        }else{
            //可以中断
            
        }
        
     
    }
    
    JudgeBottomView * sld = [[NSBundle mainBundle]loadNibNamed:@"JudgeBottomView" owner:self options:nil].firstObject;
    kWS(weakSelf)
    sld.refuseBlock = ^{
        UIAlertAction * comfirmAction = nil;
        NSString * tips =@"";
        if (app.roleType == XDCurrentRoleTypeAuthorization) {
            tips = @"是否拒绝授权?";
            comfirmAction = [UIAlertAction actionWithTitle:@"授权拒绝" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                char finalary[4] ={'0'};
                NSString * trsn =  weakSelf.businessModel.TRSN;
                NSString *  ll  =    [trsn substringToIndex:2];
                NSString *  ll1  =    [trsn substringFromIndex:2];
                NSString * rTrsn = [ll1 stringByAppendingString:ll];
                uint16_t  hehe = (uint16_t)[[BLEToolBase numberHexString:rTrsn] intValue];
                uint16_t hh[2] = {0};
                hh[0] = hehe;
                memcpy(finalary, hh, 2);
                uint16_t synnc = 0;
                while (weakSelf.businessModel.SYNCCODE.length < 4) {
                    weakSelf.businessModel.SYNCCODE = [NSString stringWithFormat:@"0%@",weakSelf.businessModel.SYNCCODE];
                }
                NSString * sub1 =   [weakSelf.businessModel.SYNCCODE substringFromIndex:2];
                NSString * sub2 = [weakSelf.businessModel.SYNCCODE substringToIndex:2];
                NSString * zzzzz = [sub1 stringByAppendingString:sub2];
                synnc =   [[BLEToolBase numberHexString:zzzzz] intValue] +1;
                if (synnc > 60000) {
                    synnc = 1;
                }
                uint16_t heihei[2] = {0};
                heihei[0] = synnc;
                memcpy(finalary+2, heihei, 2);
                char * finalStr = finalary;
                [[BLEToolBase shareInstance]HWriteCharArray:finalStr andLen:4 andTag:BLEtypeDel_Refuse_Accredit andWithResponse:^(NSDictionary *SuccessData, BLEtype type) {
                    NSString * newsync = [BLEToolBase getHexByDecimal:synnc];
                    while (newsync.length < 4) {
                        newsync = [NSString stringWithFormat:@"0%@",newsync];
                    }
                    NSString * sub1 =  [newsync substringToIndex:2];
                    NSString * sub2 =  [newsync substringFromIndex:2];
                    weakSelf.businessModel.SYNCCODE = [sub2 stringByAppendingString:sub1];
                        weakSelf.businessModel.Auth_time = [BLEToolBase getCurrentTimes];
                    uint8_t  aa = 5;
                    uint8_t  fff =  (uint8_t)[weakSelf.businessModel.Flags intValue];
                    BOOL hehea =  fff & (1<<7);
                    if (hehea) {
                        HJsetbit(aa, 7);
                    }else{
                        HJclrbit(aa, 7);
                    }
                    
                    BOOL heheaa =  fff & (1<<6);
                    if (heheaa) {
                        HJsetbit(aa, 6);
                    }else{
                        HJclrbit(aa, 6);
                    }
                    weakSelf.businessModel.Flags = [NSString stringWithFormat:@"%d",aa];
                    [[XDDataBase sharedDataBase]UpdateBusinessInfo:weakSelf.businessModel];
                    if (weakSelf.CBusinessBlock) {
                        weakSelf.CBusinessBlock(weakSelf.businessModel,weakSelf.upSelectRow);
                    }
                    [SVProgressHUD showSuccessWithStatus:@"授权已拒绝。"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    });
                    
                } and:^(NSDictionary *failureData) {
                    
                }];
            }];
        }
        if (app.roleType == XDCurrentRoleTypeReview) {
        tips = @"是否拒绝审核通过?";
        comfirmAction = [UIAlertAction actionWithTitle:@"审核拒绝" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                char finalary[4] ={'0'};
                NSString * trsn =  weakSelf.businessModel.TRSN;
                NSString *  ll  =    [trsn substringToIndex:2];
                NSString *  ll1  =    [trsn substringFromIndex:2];
                NSString * rTrsn = [ll1 stringByAppendingString:ll];
                uint16_t  hehe = (uint16_t)[[BLEToolBase numberHexString:rTrsn] intValue];
                uint16_t hh[2] = {0};
                hh[0] = hehe;
                memcpy(finalary, hh, 2);
                uint16_t synnc = 0;
                while (weakSelf.businessModel.SYNCCODE.length < 4) {
                    weakSelf.businessModel.SYNCCODE = [NSString stringWithFormat:@"0%@",weakSelf.businessModel.SYNCCODE];
                }
            
                NSString * sub1 =   [weakSelf.businessModel.SYNCCODE substringFromIndex:2];
                NSString * sub2 = [weakSelf.businessModel.SYNCCODE substringToIndex:2];
                NSString * zzzzz = [sub1 stringByAppendingString:sub2];
                synnc =   [[BLEToolBase numberHexString:zzzzz] intValue] +1;
                if (synnc > 60000) {
                    synnc = 1;
                }
                uint16_t heihei[2] = {0};
                heihei[0] = synnc;
                memcpy(finalary+2, heihei, 2);
                char * finalStr = finalary;
                [[BLEToolBase shareInstance]HWriteCharArray:finalStr andLen:4 andTag:BLEtypeDel_Refuse_EXAMINE andWithResponse:^(NSDictionary *SuccessData, BLEtype type) {
                    NSString * newsync = [BLEToolBase getHexByDecimal:synnc];
                    while (newsync.length < 4) {
                        newsync = [NSString stringWithFormat:@"0%@",newsync];
                    }
                    NSString * sub1 =  [newsync substringToIndex:2];
                    NSString * sub2 =  [newsync substringFromIndex:2];
                    weakSelf.businessModel.SYNCCODE = [sub2 stringByAppendingString:sub1];
                    weakSelf.businessModel.Check_time = [BLEToolBase getCurrentTimes];
                        uint8_t  aa = 3;
                        uint8_t  fff =  (uint8_t)[weakSelf.businessModel.Flags intValue];
                        BOOL hehea =  fff & (1<<7);
                        if (hehea) {
                            HJsetbit(aa, 7);
                        }else{
                            HJclrbit(aa, 7);
                        }
                    
                    BOOL heheaa =  fff & (1<<6);
                    if (heheaa) {
                        HJsetbit(aa, 6);
                    }else{
                        HJclrbit(aa, 6);
                    }
                    weakSelf.businessModel.Flags = [NSString stringWithFormat:@"%d",aa];
                    [[XDDataBase sharedDataBase]UpdateBusinessInfo:weakSelf.businessModel];
                    if (weakSelf.CBusinessBlock) {
                        weakSelf.CBusinessBlock(weakSelf.businessModel,weakSelf.upSelectRow);
                    }
                    [SVProgressHUD showSuccessWithStatus:@"审核已拒绝。"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    });
                    
                } and:^(NSDictionary *failureData) {
                    
                }];
            }];
        }
            UIAlertController * authAlertController = [UIAlertController alertControllerWithTitle:@"提示" message:tips preferredStyle:UIAlertControllerStyleAlert];
        
            UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
            
            [authAlertController addAction:cancelAction];
            [authAlertController addAction:comfirmAction];
            [weakSelf presentViewController:authAlertController animated:YES completion:nil];

    };
    sld.agreeBlock = ^{
        if (app.roleType == XDCurrentRoleTypeAuthorization) {
            UIAlertController * authAlertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否通过授权." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction * comfirmAction = [UIAlertAction actionWithTitle:@"通过" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                char finalary[4] ={'0'};
                NSString * trsn =  weakSelf.businessModel.TRSN;
                NSString *  ll  =    [trsn substringToIndex:2];
                NSString *  ll1  =    [trsn substringFromIndex:2];
                NSString * rTrsn = [ll1 stringByAppendingString:ll];
                uint16_t  hehe = (uint16_t)[[BLEToolBase numberHexString:rTrsn] intValue];
                uint16_t hh[2] = {0};
                hh[0] = hehe;
                memcpy(finalary, hh, 2);
                uint16_t synnc = 0;
                while (weakSelf.businessModel.SYNCCODE.length < 4) {
                    weakSelf.businessModel.SYNCCODE = [NSString stringWithFormat:@"0%@",weakSelf.businessModel.SYNCCODE];
                }
                NSString * sub1 =   [weakSelf.businessModel.SYNCCODE substringFromIndex:2];
                NSString * sub2 = [weakSelf.businessModel.SYNCCODE substringToIndex:2];
                NSString * zzzzz = [sub1 stringByAppendingString:sub2];
                synnc =   [[BLEToolBase numberHexString:zzzzz] intValue] +1;
                if (synnc > 60000) {
                    synnc = 1;
                }
                uint16_t heihei[2] = {0};
                heihei[0] = synnc;
                memcpy(finalary+2, heihei, 2);
                char * finalStr = finalary;
                [[BLEToolBase shareInstance]HWriteCharArray:finalStr andLen:4 andTag:BLEtypeDel_Accredit_AGREE andWithResponse:^(NSDictionary *SuccessData, BLEtype type) {
                    
                    NSString * newsync = [BLEToolBase getHexByDecimal:synnc];
                    while (newsync.length < 4) {
                        newsync = [NSString stringWithFormat:@"0%@",newsync];
                    }
                    NSString * sub1 =  [newsync substringToIndex:2];
                    NSString * sub2 =  [newsync substringFromIndex:2];
                    weakSelf.businessModel.SYNCCODE = [sub2 stringByAppendingString:sub1];
                    weakSelf.businessModel.Auth_time = [BLEToolBase getCurrentTimes];
                    if (weakSelf.isShowSelectAuther) {
                        //说明要授权
                        uint8_t  aa = 1;
                        uint8_t  fff =  (uint8_t)[weakSelf.businessModel.Flags intValue];
                        BOOL hehea =  fff & (1<<7);
                        if (hehea) {
                            HJsetbit(aa, 7);
                        }else{
                            HJclrbit(aa, 7);
                        }
                        
                        BOOL heheaa =  fff & (1<<6);
                        if (heheaa) {
                            HJsetbit(aa, 6);
                        }else{
                            HJclrbit(aa, 6);
                        }
                        weakSelf.businessModel.Flags = [NSString stringWithFormat:@"%d",aa];
                    }
                    
                    [[XDDataBase sharedDataBase]UpdateBusinessInfo:weakSelf.businessModel];
                    if (weakSelf.CBusinessBlock) {
                        weakSelf.CBusinessBlock(weakSelf.businessModel,weakSelf.upSelectRow);
                    }
                    [SVProgressHUD showSuccessWithStatus:@"已通过授权"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    });
                    
                } and:^(NSDictionary *failureData) {
                    
                }];
                
            }];
            
            UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
            
            [authAlertController addAction:cancelAction];
            [authAlertController addAction:comfirmAction];
            [weakSelf presentViewController:authAlertController animated:YES completion:nil];
        }
            
        
        if (app.roleType == XDCurrentRoleTypeReview) {
          
            UIAlertController * authAlertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否通过审核，通过后可在已办业务中查看." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction * comfirmAction = [UIAlertAction actionWithTitle:@"通过" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                   char finalary[6] ={'0'};
                NSString * trsn =  weakSelf.businessModel.TRSN;
                NSString *  ll  =    [trsn substringToIndex:2];
                NSString *  ll1  =    [trsn substringFromIndex:2];
                NSString * rTrsn = [ll1 stringByAppendingString:ll];
                uint16_t  hehe = (uint16_t)[[BLEToolBase numberHexString:rTrsn] intValue];
                uint16_t hh[2] = {0};
                hh[0] = hehe;
                 memcpy(finalary, hh, 2);
        
                NSInteger a[5] = {0};
                if (weakSelf.curModel) {
                a[0] = weakSelf.curModel.uid;
                }else{
                a[0] = 0;
                }
               
                memcpy(finalary+2, a, 2);
                uint16_t synnc = 0;
                while (weakSelf.businessModel.SYNCCODE.length < 4) {
                    weakSelf.businessModel.SYNCCODE = [NSString stringWithFormat:@"0%@",weakSelf.businessModel.SYNCCODE];
                }
               NSString * sub1 =   [weakSelf.businessModel.SYNCCODE substringFromIndex:2];
               NSString * sub2 = [weakSelf.businessModel.SYNCCODE substringToIndex:2];
                NSString * zzzzz = [sub1 stringByAppendingString:sub2];
                synnc =   [[BLEToolBase numberHexString:zzzzz] intValue] +1;
                if (synnc > 60000) {
                    synnc = 1;
                }
                uint16_t heihei[2] = {0};
                heihei[0] = synnc;
                memcpy(finalary+2+2, heihei, 2);
                char * finalStr = finalary;
                [[BLEToolBase shareInstance]HWriteCharArray:finalStr andLen:6 andTag:BLEtypeDel_EXAMINE_AGREE andWithResponse:^(NSDictionary *SuccessData, BLEtype type) {

                    NSString * newsync = [BLEToolBase getHexByDecimal:synnc];
                    while (newsync.length < 4) {
                        newsync = [NSString stringWithFormat:@"0%@",newsync];
                    }
                  NSString * sub1 =  [newsync substringToIndex:2];
                  NSString * sub2 =  [newsync substringFromIndex:2];
                  weakSelf.businessModel.SYNCCODE = [sub2 stringByAppendingString:sub1];
                  weakSelf.businessModel.Check_time = [BLEToolBase getCurrentTimes];
                    if (weakSelf.isShowSelectAuther) {
                        //说明要授权
                           uint8_t  aa = 4;
                        uint8_t  fff =  (uint8_t)[weakSelf.businessModel.Flags intValue];
                        BOOL hehea =  fff & (1<<7);
                        if (hehea) {
                            HJsetbit(aa, 7);
                        }else{
                            HJclrbit(aa, 7);
                        }
                        if (weakSelf.curModel) {
                            HJsetbit(aa, 6);
                        weakSelf.businessModel.authorizer =  weakSelf.curModel.username;
                        weakSelf.businessModel.Authorizer_nickname = weakSelf.curModel.nickname;
                        }else{
                               HJclrbit(aa, 6);
                        }
                       weakSelf.businessModel.Flags = [NSString stringWithFormat:@"%d",aa];
                    }else{
                        //不用授权的话 就变成待签发
                         uint8_t  aa = 1;
                        uint8_t  fff =  (uint8_t)[weakSelf.businessModel.Flags intValue];
                        BOOL hehea =  fff & (1<<7);
                        if (hehea) {
                            HJsetbit(aa, 7);
                        }else{
                            HJclrbit(aa, 7);
                        }
                   weakSelf.businessModel.Flags = [NSString stringWithFormat:@"%d",aa];
                    }
    
                    [[XDDataBase sharedDataBase]UpdateBusinessInfo:weakSelf.businessModel];
                    if (weakSelf.CBusinessBlock) {
                        weakSelf.CBusinessBlock(weakSelf.businessModel,weakSelf.upSelectRow);
                    }
                    [SVProgressHUD showSuccessWithStatus:@"已通过审核，可在已办业务中查看该票据进度"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    });
                    
                } and:^(NSDictionary *failureData) {
                    
                }];

            }];
            
            UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
            
            [authAlertController addAction:cancelAction];
            [authAlertController addAction:comfirmAction];
            [weakSelf presentViewController:authAlertController animated:YES completion:nil];
        }
        
        
        
        
    };
    sld.frame = CGRectMake(0, 0, SCREEN_WIDTH, 60);
    return sld;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

   

    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//        AppDelegate * app = HJApp;
       XdCompleteBusinessCell * ccell = [[NSBundle mainBundle]loadNibNamed:@"XdCompleteBusinessCell" owner:self options:nil].firstObject;
        if (indexPath.row == 0) {
            ccell.roleNameLabel.text = @"签发员";
            ccell.OpearaterNameLabel.text = self.businessModel.maker;
            ccell.OperateTimeLabel.text  = @"签发时间";
            ccell.OperateDateLabel.text = self.businessModel.Maker_time;
        }
        if (indexPath.row == 1) {
            ccell.roleNameLabel.text = @"复核员";
            ccell.OpearaterNameLabel.text = self.businessModel.checker;
            ccell.OperateTimeLabel.text  = @"复核时间";
            ccell.OperateDateLabel.text = [BLEToolBase timeWithTimeIntervalString:self.businessModel.Check_time];
        }
        
        if (indexPath.row == 2) {
            ccell.roleNameLabel.text = @"授权员";
            ccell.OpearaterNameLabel.text = self.businessModel.authorizer;
            ccell.OperateTimeLabel.text  = @"授权时间";
            ccell.OperateDateLabel.text = [BLEToolBase timeWithTimeIntervalString:self.businessModel.Auth_time];
       
        }
    

    if (indexPath.row == 3) {
        kWS(weakSelf)
        XDRecordOperateCell * rcell = [[NSBundle mainBundle]loadNibNamed:@"XDRecordOperateCell" owner:self options:nil].firstObject;
        self.xdrCell = rcell;
        rcell.caBlock = ^{
            XDChoiceUserzViewController * xdc = [[XDChoiceUserzViewController alloc]init];
            xdc.userBlock = ^(XDUserModel *model) {
                weakSelf.curModel = model;
            };
            xdc.selectUserType = HJChoiceUserTypeNoneAuthorization;
            [weakSelf.navigationController pushViewController:xdc animated:YES];
        };
        rcell.selectionStyle = 0;
        AppDelegate * app = HJApp;
        rcell.CUsernameLabel.text = app.userModel.nickname;
        
        return rcell;
    }
    return ccell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    AppDelegate * app = HJApp;
    if (self.isCompelete) {
        if (app.roleType == XDCurrentRoleTypeSign) {
            if (indexPath.row == 3) {
                return 0.1f;
            }
            return 108;
        }
        
        if (app.roleType == XDCurrentRoleTypeReview) {
            if (indexPath.row == 0 || indexPath.row == 1) {
                return 108;
            }
            return 0.1f;
        }
        
        if (app.roleType == XDCurrentRoleTypeAuthorization) {
            if (indexPath.row == 0 || indexPath.row == 2) {
                return 108;
            }
            if (indexPath.row == 1) {
                if (self.businessModel.checker.length > 0) {
                    return 108;
                }else{
                    return 0.1f;
                }
            }
            return 0.1f;
        }
        
    }else{
        if (app.roleType == XDCurrentRoleTypeSign) {
            if (indexPath.row == 0) {
                return 108;
            }
            if (indexPath.row == 1) {
                if (self.businessModel.checker.length > 0) {
                    return 108;
                }
            }
            if (indexPath.row == 2) {
                if (self.businessModel.authorizer.length > 0) {
                    return 108;
                }
            }
            return 0.1f;
        }
        
        if (app.roleType == XDCurrentRoleTypeReview) {
            if (indexPath.row == 0) {
                return 108;
            }
         
            if (indexPath.row == 3) {
                if (self.isShowSelectAuther) {
                    return 108;
                }
            }
            return 0.1f;
        }
        
        if (app.roleType == XDCurrentRoleTypeAuthorization) {
            if (indexPath.row == 0) {
                return 108;
            }
            if (indexPath.row == 1) {
                if (self.businessModel.checker.length > 0) {
                    return 108;
                }else{
                    return 0.1f;
                }
            }
            return 0.1f;
        }
    }
    return 0.1f;
}



@end
