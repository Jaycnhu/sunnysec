//
//  CerDetialHeaderView.h
//  SunnySecProduct
// 
//  Created by Huuuuuuj on 2018/6/13.
//  Copyright © 2018年 SunnySec. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^clickChoiceTypeBlock)(void);
@interface CerDetialHeaderView : UIView
@property(nonatomic,assign)BOOL showBoder;
@property(nonatomic,copy)clickChoiceTypeBlock tBlock;
@end
