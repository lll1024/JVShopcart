//
//  JVShopcartProductModel.h
//  JVShopcart
//
//  Created by AVGD-Jarvi on 17/3/23.
//  Copyright © 2017年 AVGD-Jarvi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JVShopcartProductModel : NSObject

@property (nonatomic, assign) NSInteger specWidth;

@property (nonatomic, assign) NSInteger specHeight;

@property (nonatomic, assign) NSInteger specLength;

@property (nonatomic, copy) NSString *productStyle;

@property (nonatomic, copy) NSString *brandPicUri;

@property (nonatomic, copy) NSString *productId;

@property (nonatomic, copy) NSString *productType;

@property (nonatomic, copy) NSString *brandName;   //品牌名

@property (nonatomic, copy) NSString *brandId;

@property (nonatomic, assign) NSInteger productStocks;      //库存

@property (nonatomic, copy) NSString *productNum;

@property (nonatomic, copy) NSString *cartId;

@property (nonatomic, assign) NSInteger productQty;

@property (nonatomic, assign) NSInteger originPrice;        //零售价

@property (nonatomic, assign) NSInteger productPrice;       //批发价

@property (nonatomic, copy) NSString *productName;

@property (nonatomic, copy) NSString *productPicUri;   //图片url

@property(nonatomic, assign)BOOL isSelected;    //记录相应row是否选中

@end
