//
//  JVShopcartBrandModel.m
//  JVShopcart
//
//  Created by AVGD-Jarvi on 17/3/23.
//  Copyright © 2017年 AVGD-Jarvi. All rights reserved.
//

#import "JVShopcartBrandModel.h"

@implementation JVShopcartBrandModel

+ (NSDictionary *)objectClassInArray {
    return @{@"products":[JVShopcartProductModel class]};
}

@end
