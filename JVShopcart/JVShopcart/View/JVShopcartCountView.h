//
//  JVShopcartCountView.h
//  JVShopcart
//
//  Created by AVGD-Jarvi on 17/3/23.
//  Copyright © 2017年 AVGD-Jarvi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShopcartCountViewEditBlock)(NSInteger count);

@interface JVShopcartCountView : UIView

@property (nonatomic, copy) ShopcartCountViewEditBlock shopcartCountViewEditBlock;

- (void)configureShopcartCountViewWithProductCount:(NSInteger)productCount
                                      productStock:(NSInteger)productStock;

@end
