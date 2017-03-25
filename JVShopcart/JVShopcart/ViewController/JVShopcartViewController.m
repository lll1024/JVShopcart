//
//  JVShopcartViewController.m
//  JVShopcart
//
//  Created by AVGD-Jarvi on 17/3/23.
//  Copyright © 2017年 AVGD-Jarvi. All rights reserved.
//

#import "JVShopcartViewController.h"
#import "JVShopcartTableViewProxy.h"
#import "JVShopcartBottomView.h"
#import "JVShopcartCell.h"
#import "JVShopcartHeaderView.h"
#import "JVShopcartFormat.h"
#import "Masonry.h"

@interface JVShopcartViewController () <JVShopcartFormatDelegate>

@property (nonatomic, strong) UITableView *shopcartTableView;   /**< 购物车列表 */
@property (nonatomic, strong) JVShopcartBottomView *shopcartBottomView;    /**< 购物车底部视图 */
@property (nonatomic, strong) JVShopcartTableViewProxy *shopcartTableViewProxy;    /**< tableView代理 */
@property (nonatomic, strong) JVShopcartFormat *shopcartFormat;    /**< 负责购物车逻辑处理 */

@end

@implementation JVShopcartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购物车";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addSubview];
    [self layoutSubview];
    [self requestShopcartListData];
}

- (void)requestShopcartListData {
    [self.shopcartFormat requestShopcartProductList];
}

#pragma mark JVShopcartFormatDelegate

- (void)shopcartFormatRequestProductListDidSuccessWithArray:(NSMutableArray *)dataArray {
    self.shopcartTableViewProxy.dataArray = dataArray;
    [self.shopcartTableView reloadData];
}

- (void)shopcartFormatAccountForTotalPrice:(float)totalPrice totalCount:(NSInteger)totalCount isAllSelected:(BOOL)isAllSelected {
    [self.shopcartBottomView configureShopcartBottomViewWithTotalPrice:totalPrice totalCount:totalCount isAllselected:isAllSelected];
    [self.shopcartTableView reloadData];
}

- (void)shopcartFormatSettleForSelectedProducts:(NSArray *)selectedProducts {
    
}

- (void)shopcartFormatHasDeleteAllProducts {
    
}

#pragma mark getters

- (UITableView *)shopcartTableView {
    if (_shopcartTableView == nil){
        _shopcartTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _shopcartTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_shopcartTableView registerClass:[JVShopcartCell class] forCellReuseIdentifier:@"JVShopcartCell"];
        [_shopcartTableView registerClass:[JVShopcartHeaderView class] forHeaderFooterViewReuseIdentifier:@"JVShopcartHeaderView"];
        _shopcartTableView.showsVerticalScrollIndicator = NO;
        _shopcartTableView.delegate = self.shopcartTableViewProxy;
        _shopcartTableView.dataSource = self.shopcartTableViewProxy;
        _shopcartTableView.rowHeight = 120;
        _shopcartTableView.sectionFooterHeight = 10;
        _shopcartTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _shopcartTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    }
    return _shopcartTableView;
}

- (JVShopcartTableViewProxy *)shopcartTableViewProxy {
    if (_shopcartTableViewProxy == nil){
        _shopcartTableViewProxy = [[JVShopcartTableViewProxy alloc] init];
        
        __weak __typeof(self) weakSelf = self;
        _shopcartTableViewProxy.shopcartProxyProductSelectBlock = ^(BOOL isSelected, NSIndexPath *indexPath){
            [weakSelf.shopcartFormat selectProductAtIndexPath:indexPath isSelected:isSelected];
        };
        
        _shopcartTableViewProxy.shopcartProxyBrandSelectBlock = ^(BOOL isSelected, NSInteger section){
            [weakSelf.shopcartFormat selectBrandAtSection:section isSelected:isSelected];
        };
        
        _shopcartTableViewProxy.shopcartProxyChangeCountBlock = ^(NSInteger count, NSIndexPath *indexPath){
            [weakSelf.shopcartFormat changeCountAtIndexPath:indexPath count:count];
        };
        
        _shopcartTableViewProxy.shopcartProxyDeleteBlock = ^(NSIndexPath *indexPath){
            [weakSelf.shopcartFormat deleteProductAtIndexPath:indexPath];
        };
        
        _shopcartTableViewProxy.shopcartProxyStarBlock = ^(NSIndexPath *indexPath){
            [weakSelf.shopcartFormat starProductAtIndexPath:indexPath];
        };
    }
    return _shopcartTableViewProxy;
}

- (JVShopcartBottomView *)shopcartBottomView {
    if (_shopcartBottomView == nil){
        _shopcartBottomView = [[JVShopcartBottomView alloc] init];
        
        __weak __typeof(self) weakSelf = self;
        _shopcartBottomView.shopcartBotttomViewAllSelectBlock = ^(BOOL isSelected) {
            [weakSelf.shopcartFormat selectAllProductWithStatus:isSelected];
        };
        
        _shopcartBottomView.shopcartBotttomViewSettleBlock = ^() {
            
        };
    }
    return _shopcartBottomView;
}

- (JVShopcartFormat *)shopcartFormat {
    if (_shopcartFormat == nil){
        _shopcartFormat = [[JVShopcartFormat alloc] init];
        _shopcartFormat.delegate = self;
    }
    return _shopcartFormat;
}

- (void)addSubview {
    [self.view addSubview:self.shopcartTableView];
    [self.view addSubview:self.shopcartBottomView];
}

- (void)layoutSubview {
    [self.shopcartTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.shopcartBottomView.mas_top);
    }];
    
    [self.shopcartBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.equalTo(@50); 
    }];
}

@end
