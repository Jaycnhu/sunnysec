//
//  XDAddNewUserHeaderView.h
//  SunnySecProduct
//
//  Created by Huuuuuuj on 2017/12/15.
//  Copyright © 2017年 SunnySec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XDUserModel;
typedef void(^submitNewUserBlock)(XDUserModel * userModel);
@interface XDAddNewUserHeaderView : UIView
@property(nonatomic,copy)submitNewUserBlock addUserBlock;
@end
