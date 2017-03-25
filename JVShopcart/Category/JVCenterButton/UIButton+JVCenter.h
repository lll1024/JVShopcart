//
//  UIButton+JVCenter.h
//  hysc
//
//  Created by AVGD-Jarvi on 16/11/5.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CenterButtonImageStyle) {
    CenterButtonImageStyleTop = 0,
    CenterButtonImageStyleBottom,
    CenterButtonImageStyleLeft,
    CenterButtonImageStyleRight
};

@interface UIButton (JVCenter)

- (void)centerStyle:(CenterButtonImageStyle)style padding:(CGFloat)padding;

@end
