//
//  XDChangePasswordViewController.h
//  SunnySecProduct
//
//  Created by Huuuuuuj on 2017/12/15.
//  Copyright © 2017年 SunnySec. All rights reserved.
//

#import "HBaseViewController.h"
@class XDUserModel;
@interface XDChangePasswordViewController : HBaseViewController
typedef void(^didChangeUserModelBlock)(XDUserModel * userModel);
@property(nonatomic,strong)XDUserModel * userModel;
@property(nonatomic,copy)didChangeUserModelBlock  changeBlock;
@end
