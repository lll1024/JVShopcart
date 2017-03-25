//
//  JVShopcartHeaderView.h
//  JVShopcart
//
//  Created by AVGD-Jarvi on 17/3/23.
//  Copyright © 2017年 AVGD-Jarvi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShopcartHeaderViewBlock)(BOOL isSelected);

@interface JVShopcartHeaderView : UITableViewHeaderFooterView

@property (nonatomic, copy) ShopcartHeaderViewBlock shopcartHeaderViewBlock;    

- (void)configureShopcartHeaderViewWithBrandName:(NSString *)brandName
                                     brandSelect:(BOOL)brandSelect;

@end
