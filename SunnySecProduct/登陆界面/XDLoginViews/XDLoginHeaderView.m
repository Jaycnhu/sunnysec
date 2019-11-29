
//
//  XDLoginHeaderView.m
//  SunnySecProduct
//
//  Created by Huuuuuuj on 2017/12/14.
//  Copyright © 2017年 SunnySec. All rights reserved.
//

#import "XDLoginHeaderView.h"
#import "Config.h"
@interface XDLoginHeaderView()
@property (weak, nonatomic) IBOutlet UILabel *deviceNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *userIDTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginBut;
@property (weak, nonatomic) IBOutlet UILabel *setupInfoLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView1;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView2;

@end

@implementation XDLoginHeaderView

-(void)awakeFromNib{
[super awakeFromNib];
self.userIDTextField.layer.cornerRadius = 5;
self.userIDTextField.layer.borderWidth = 1;
self.userIDTextField.layer.borderColor = [UIColor colorWithExadecimalString:@"3399ff"].CGColor;
self.userIDTextField.layer.masksToBounds = YES;
self.passwordTextField.layer.cornerRadius = 5;
self.passwordTextField.layer.borderColor = [UIColor colorWithExadecimalString:@"3399ff"].CGColor;
self.passwordTextField.layer.borderWidth = 1;
self.passwordTextField.layer.masksToBounds = YES;
self.loginBut.layer.cornerRadius =5;
self.loginBut.layer.borderWidth = 1;
self.loginBut.layer.borderColor = [UIColor colorWithExadecimalString:@"3399ff"].CGColor;
self.loginBut.layer.masksToBounds = YES;
self.progressView1.transform = CGAffineTransformMakeScale(1.0f, 5.0f);
   self.progressView2.transform = CGAffineTransformMakeScale(1.0f, 5.0f);
}
@end
