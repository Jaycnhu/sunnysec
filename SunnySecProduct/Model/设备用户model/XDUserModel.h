//
//  XDUserModel.h
//  SunnySecProduct
//
//  Created by Huuuuuuj on 2017/12/15.
//  Copyright © 2017年 SunnySec. All rights reserved.
//

#import <Foundation/Foundation.h>
//设备用户表(TB_DEV_USER_INFO)
@interface XDUserModel : NSObject
/**
 设备序号
 */
@property(nonatomic,copy)NSString * DEVSN;// 设备序号
@property(nonatomic,assign)NSInteger * POSTION;// 数据存储位置
@property(nonatomic,assign)NSInteger * SYNCCODE;// 数据同步码
@property(nonatomic,assign)NSInteger  UID;// 用户标识符
@property(nonatomic,copy)NSString * USERNAME;// 用户名
@property(nonatomic,copy)NSString * NICKNAME;// 昵称
@property(nonatomic,copy)NSString * QUOTA;// 限额
@property(nonatomic,assign)NSInteger  ROLE;//角色(管理员、普通用 户)
@end
