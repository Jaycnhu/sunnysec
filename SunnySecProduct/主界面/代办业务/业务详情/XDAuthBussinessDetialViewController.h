//
//  XDAuthBussinessDetialViewController.h
//  SunnySecProduct
//
//  Created by Huuuuuuj on 2018/6/28.
//  Copyright © 2018年 SunnySec. All rights reserved.
//

#import "HBaseViewController.h"
@class XDBusinessModel;
typedef void(^didChangeTheBusinessBlock)(XDBusinessModel * bmodel,NSInteger selectRow);
@interface XDAuthBussinessDetialViewController : HBaseViewController
@property(nonatomic,strong)XDBusinessModel * businessModel;
@property(nonatomic,assign)BOOL isCompelete;
@property(nonatomic,copy)didChangeTheBusinessBlock  CBusinessBlock;
@property(nonatomic,assign)NSInteger  upSelectRow;
@end
