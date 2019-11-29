//
//  CerDetialFooterView.h
//  SunnySecProduct
//
//  Created by Huuuuuuj on 2018/6/13.
//  Copyright © 2018年 SunnySec. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, footerViewState){
    footerViewStateDefalut = 0,
    footerViewStateDelete,
    footerViewStateChange
};

@interface CerDetialFooterView : UIView
@property(nonatomic,assign)footerViewState viewState;
@end
