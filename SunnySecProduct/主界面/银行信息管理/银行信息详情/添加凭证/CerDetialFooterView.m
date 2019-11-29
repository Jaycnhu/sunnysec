//
//  CerDetialFooterView.m
//  SunnySecProduct
//
//  Created by Huuuuuuj on 2018/6/13.
//  Copyright © 2018年 SunnySec. All rights reserved.
//

#import "CerDetialFooterView.h"
#import "Config.h"
@interface CerDetialFooterView()
@property (weak, nonatomic) IBOutlet UIButton *footerBut;

@end


@implementation CerDetialFooterView

-(void)awakeFromNib{
    [super awakeFromNib];
    NSLog(@"awakeFromNib");
    
}

-(void)drawRect:(CGRect)rect{
    
    if (self.viewState == footerViewStateDelete) {
        [self.footerBut setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.footerBut setTitle:@"删除" forState:UIControlStateNormal];
    }else  if (self.viewState == footerViewStateChange){
        [self.footerBut setTitleColor:[UIColor colorWithExadecimalString:@"1874CD"] forState:UIControlStateNormal];
        [self.footerBut setTitle:@"修改" forState:UIControlStateNormal];
    }
    
}

@end
