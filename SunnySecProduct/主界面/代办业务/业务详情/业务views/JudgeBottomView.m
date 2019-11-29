//
//  JudgeBottomView.m
//  SunnySecProduct
//
//  Created by Huuuuuuj on 2018/6/28.
//  Copyright © 2018年 SunnySec. All rights reserved.
//

#import "JudgeBottomView.h"

@implementation JudgeBottomView

- (IBAction)refuseAction:(id)sender {
    if (self.refuseBlock) {
        self.refuseBlock();
    }
}

- (IBAction)agreeAction:(id)sender {
    if (self.agreeBlock) {
        self.agreeBlock();
    }
}

@end
