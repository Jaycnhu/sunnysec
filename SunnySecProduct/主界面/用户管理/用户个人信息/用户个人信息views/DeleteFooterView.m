//
//  DeleteFooterView.m
//  PieHospitalProficient
//
//  Created by 胡杰 on 2017/7/20.
//  Copyright © 2017年 胡杰. All rights reserved.
//

#import "DeleteFooterView.h"
#import "Config.h"
@interface DeleteFooterView()


@end
@implementation DeleteFooterView

-(void)awakeFromNib{
    [super awakeFromNib];
    if (SCREEN_WIDTH < 375) {
        self.deleteBut.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    
    self.deleteBut.layer.cornerRadius = 5;
    self.deleteBut.layer.borderWidth = 1;
    self.deleteBut.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.deleteBut.layer.masksToBounds = YES;
}

@end
