//
//  XDRecordOperateCell.h
//  SunnySecProduct
//
//  Created by Huuuuuuj on 2018/6/28.
//  Copyright © 2018年 SunnySec. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^choiceAuthorBlock)(void);
@interface XDRecordOperateCell : UITableViewCell

@property(nonatomic,assign)BOOL reviewer;
@property(nonatomic,assign)BOOL auther;
@property(nonatomic,copy)choiceAuthorBlock caBlock;

@property (weak, nonatomic) IBOutlet UILabel *cRoleLabel;

@property (weak, nonatomic) IBOutlet UILabel *CUsernameLabel;

@property (weak, nonatomic) IBOutlet UITextField *CChoiceAuthorTF;

@end
