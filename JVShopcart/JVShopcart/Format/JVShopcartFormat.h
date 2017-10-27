//
//  JVShopcartFormat.h
//  JVShopcart
//
//  Created by AVGD-Jarvi on 17/3/23.
//  Copyright © 2017年 AVGD-Jarvi. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JVShopcartFormatDelegate <NSObject>

@required

- (void)shopcartFormatRequestProductListDidSuccessWithArray:(NSMutableArray *)dataArray;
- (void)shopcartFormatAccountForTotalPrice:(float)totalPrice
                                totalCount:(NSInteger)totalCount
                             isAllSelected:(BOOL)isAllSelected;
- (void)shopcartFormatSettleForSelectedProducts:(NSArray *)selectedProducts;
- (void)shopcartFormatWillDeleteSelectedProducts:(NSArray *)selectedProducts;
- (void)shopcartFormatHasDeleteAllProducts;

@end

@interface JVShopcartFormat : NSObject

@property (nonatomic, weak) id <JVShopcartFormatDelegate> delegate;
//请求购物车数据
- (void)requestShopcartProductList;
//选中/取消选中某个row
- (void)selectProductAtIndexPath:(NSIndexPath *)indexPath isSelected:(BOOL)isSelected;
//选中/取消选中某个section
- (void)selectBrandAtSection:(NSInteger)section isSelected:(BOOL)isSelected;
//改变商品数
- (void)changeCountAtIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count;
//单个删除商品
- (void)deleteProductAtIndexPath:(NSIndexPath *)indexPath;
//批量删除商品
- (void)beginToDeleteSelectedProducts;
- (void)deleteSelectedProducts:(NSArray *)selectedArray;
//单个收藏商品
- (void)starProductAtIndexPath:(NSIndexPath *)indexPath;
//批量收藏商品
- (void)starSelectedProducts;
//全选 or 取消全选
- (void)selectAllProductWithStatus:(BOOL)isSelected;
//结算选中商品
- (void)settleSelectedProducts;

@end
