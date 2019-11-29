//
//  XDAddNewUserHeaderView.m
//  SunnySecProduct
//
//  Created by Huuuuuuj on 2017/12/15.
//  Copyright © 2017年 SunnySec. All rights reserved.
//

#import "XDAddNewUserHeaderView.h"
#import "XDUserModel.h"
#import "Config.h"
@interface XDAddNewUserHeaderView()
@property (weak, nonatomic) IBOutlet UITextField *loginIDTextField;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *userPwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *limitTextField;

@end

@implementation XDAddNewUserHeaderView

- (IBAction)submitNewUserAction:(UIButton *)sender {
    //判断下是不是每个空格都写咯数据的
    if (!(self.loginIDTextField.text.length && self.userPwdTextField.text.length && self.userPwdTextField.text.length && self.limitTextField.text.length)) {
        
        [SVProgressHUD showErrorWithStatus:@"有数据未填写!"];
        return;
    }
    
    if (self.addUserBlock) {
        XDUserModel * xduser = [[XDUserModel alloc]init];
#warning --这都是写歪数据
        xduser.devsn = @"SDD1907067333216729146238136";
        xduser.postion = 5;
        xduser.synccode = 20;
        xduser.uid = [self.loginIDTextField.text integerValue];
        xduser.username = @"张二狗";
        xduser.nickname = self.userNameTextField.text;
        xduser.quota = self.limitTextField.text;
        xduser.role = 1;
        self.addUserBlock(xduser);
    }
}


@end
