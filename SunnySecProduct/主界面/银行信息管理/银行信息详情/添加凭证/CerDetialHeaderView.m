//
//  CerDetialHeaderView.m
//  SunnySecProduct
//
//  Created by Huuuuuuj on 2018/6/13.
//  Copyright © 2018年 SunnySec. All rights reserved.
//

#import "CerDetialHeaderView.h"
@interface CerDetialHeaderView()
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *tfields;

@end
@implementation CerDetialHeaderView

-(void)awakeFromNib{
    [super awakeFromNib];
 
}

-(void)drawRect:(CGRect)rect{
    if (self.showBoder == NO) {
        for (UITextField * rt in self.tfields) {
            rt.borderStyle = 0;
            rt.enabled = NO;
        }
    }else{
        for (UITextField * rt in self.tfields) {
            rt.borderStyle = 3;
            rt.enabled = YES;
        }
        
        
    }
    
    
}

- (IBAction)choiceCerTypeAction:(id)sender {
    if (self.tBlock) {
        self.tBlock();
    }
    
    
}


@end
