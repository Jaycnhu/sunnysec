//
//  XDAuthBussinessHeaderView.m
//  SunnySecProduct
//
//  Created by Huuuuuuj on 2018/6/28.
//  Copyright © 2018年 SunnySec. All rights reserved.
//

#import "XDAuthBussinessHeaderView.h"
#import "XDBusinessModel.h"
#import "Config.h"
#import "BLEToolBase.h"
@interface XDAuthBussinessHeaderView()
@property (weak, nonatomic) IBOutlet UILabel *payAcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *recAcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *cerTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *cerNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *signQuotaLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *OperateTypelabel;

@end

@implementation XDAuthBussinessHeaderView
-(void)loadViewWithBusinessModel:(XDBusinessModel *)bmodel{
    self.payAcountLabel.text = bmodel.PAYACCU;
    self.recAcountLabel.text = bmodel.RECVACCU;
    int type =   [bmodel.SERVICE intValue];
    if (type == 1) {
        self.cerTypeLabel.text = @"支票";
    }else if (type == 2){
        self.cerTypeLabel.text = @"银行汇票申请书";
    }else if (type == 3){
        self.cerTypeLabel.text = @"银行本票申请书";
    }else if (type == 4){
        self.cerTypeLabel.text = @"汇兑凭证";
    }else{
        self.cerTypeLabel.text = @"其它";
    }
    self.cerNumLabel.text = bmodel.TICKET_NUM;
    self.signQuotaLabel.text =[NSString stringWithFormat:@"%.2f",[bmodel.BANLANCE integerValue]/100.0f];
    self.timeDateLabel.text = [BLEToolBase timeWithTimeIntervalString:bmodel.DATE];
}

@end
