//
//  XDRecordOperateCell.m
//  SunnySecProduct
//
//  Created by Huuuuuuj on 2018/6/28.
//  Copyright © 2018年 SunnySec. All rights reserved.
//

#import "XDRecordOperateCell.h"

@implementation XDRecordOperateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setReviewer:(BOOL)reviewer{
    if (reviewer) {
        self.cRoleLabel.text = @"复核员";
     
    }
}

-(void)setAuther:(BOOL)auther{
    if (auther) {
        self.cRoleLabel.text = @"授权员";
    }
}

- (IBAction)invokeUserAction:(id)sender {
    
    if (self.caBlock) {
        self.caBlock();
    }
    
    
    
}
@end
