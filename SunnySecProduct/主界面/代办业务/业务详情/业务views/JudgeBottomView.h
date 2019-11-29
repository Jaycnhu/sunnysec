//
//  JudgeBottomView.h
//  SunnySecProduct
//
//  Created by Huuuuuuj on 2018/6/28.
//  Copyright © 2018年 SunnySec. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^clickAgreeBut)(void);
typedef void(^clickrefuseBut)(void);
@interface JudgeBottomView : UIView
@property(nonatomic,copy)clickAgreeBut agreeBlock;

@property(nonatomic,copy)clickrefuseBut refuseBlock;

@end
