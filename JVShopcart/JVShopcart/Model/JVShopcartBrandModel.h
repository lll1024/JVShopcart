//
//  JVShopcartBrandModel.h
//  JVShopcart
//
//  Created by AVGD-Jarvi on 17/3/23.
//  Copyright © 2017年 AVGD-Jarvi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JVShopcartProductModel.h"

@interface JVShopcartBrandModel : NSObject

@property (nonatomic, copy) NSString *brandId;

@property (nonatomic, strong) NSMutableArray<JVShopcartProductModel *> *products;

@property (nonatomic, copy) NSString *brandName;

@property (nonatomic, assign)BOOL isSelected; //记录相应section是否全选（自定义）

@property (nonatomic, strong) NSMutableArray *selectedArray;    //结算时筛选出选中的商品（自定义）

@end
