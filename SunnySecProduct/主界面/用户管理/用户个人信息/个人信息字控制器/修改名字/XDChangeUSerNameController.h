//
//  XDChangeUSerNameController.h
//  SunnySecProduct
//
//  Created by Huuuuuuj on 2017/12/15.
//  Copyright © 2017年 SunnySec. All rights reserved.
//

#import "HBaseViewController.h"
@class XDUserModel;
typedef void(^didChangeUserModelBlock)(XDUserModel * userModel);
@interface XDChangeUSerNameController : HBaseViewController
@property(nonatomic,strong)XDUserModel * userModel;
@property(nonatomic,copy)didChangeUserModelBlock  changeBlock;
@end
