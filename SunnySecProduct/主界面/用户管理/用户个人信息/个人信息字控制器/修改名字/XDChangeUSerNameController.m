//
//  XDChangeUSerNameController.m
//  SunnySecProduct
//
//  Created by Huuuuuuj on 2017/12/15.
//  Copyright © 2017年 SunnySec. All rights reserved.
//

#import "XDChangeUSerNameController.h"
#import "XDUserModel.h"
#import "Config.h"
@interface XDChangeUSerNameController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTField;


@end

@implementation XDChangeUSerNameController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改名称";
    self.view.backgroundColor = [UIColor colorWithExadecimalString:@"efeff4"];
    self.nameTField.text = self.userModel.nickname;
}

- (IBAction)confirmAction:(id)sender {
    if (self.nameTField.text.length > 0) {
        self.userModel.nickname = self.nameTField.text;
        if (self.changeBlock) {
        [[XDDataBase sharedDataBase]updateUser:self.userModel];
            self.changeBlock(self.userModel);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
   
}


@end
