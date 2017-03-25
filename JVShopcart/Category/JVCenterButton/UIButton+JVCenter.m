//
//  UIButton+JVCenter.m
//  hysc
//
//  Created by AVGD-Jarvi on 16/11/5.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "UIButton+JVCenter.h"

@implementation UIButton (JVCenter)

- (void)centerStyle:(CenterButtonImageStyle)style padding:(CGFloat)padding{
    CGFloat lableWidth = (self.imageView.frame.size.width+self.titleLabel.frame.size.width)/2-(self.titleLabel.frame.size.width)/2;
    CGFloat lableHeight = self.titleLabel.frame.size.height/2+padding/2;
    CGFloat imageWidth = (self.imageView.frame.size.width+self.titleLabel.frame.size.width)/2-(self.imageView.frame.size.width)/2;
    CGFloat imageHeight = self.imageView.frame.size.height/2+padding/2;
    
    switch (style) {
        case CenterButtonImageStyleTop:
            [self setTitleEdgeInsets:UIEdgeInsetsMake(lableHeight, -lableWidth, -lableHeight, lableWidth)];
            [self setImageEdgeInsets:UIEdgeInsetsMake(-imageHeight, imageWidth, imageHeight, -imageWidth)];
            break;
        case CenterButtonImageStyleBottom:
            [self setTitleEdgeInsets:UIEdgeInsetsMake(-lableHeight, lableWidth, lableHeight, -lableWidth)];
            [self setImageEdgeInsets:UIEdgeInsetsMake(imageHeight, -imageWidth, -imageHeight, imageWidth)];
            break;
        case CenterButtonImageStyleLeft:
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, padding/2, 0, 0)];
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, padding/2)];
            break;
        case CenterButtonImageStyleRight:
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.imageView.frame.size.width-padding/2, 0, self.imageView.frame.size.width+padding/2)];
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, self.titleLabel.frame.size.width+padding/2, 0, -self.titleLabel.frame.size.width-padding/2)];
            break;
            
        default:
            break;
    }
}

@end
