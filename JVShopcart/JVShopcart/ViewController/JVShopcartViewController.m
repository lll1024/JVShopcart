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

@interface JVShopcartViewController ()<JVShopcartFormatDelegate>

@property (nonatomic, strong) UITableView *shopcartTableView;   /**< 购物车列表 */
@property (nonatomic, strong) JVShopcartBottomView *shopcartBottomView;    /**< 购物车底部视图 */
@property (nonatomic, strong) JVShopcartTableViewProxy *shopcartTableViewProxy;    /**< tableView代理 */
@property (nonatomic, strong) JVShopcartFormat *shopcartFormat;    /**< 负责购物车逻辑处理 */
@property (nonatomic, strong) UIButton *editButton;    /**< 编辑按钮 */

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

//数据请求成功回调
- (void)shopcartFormatRequestProductListDidSuccessWithArray:(NSMutableArray *)dataArray {
    self.shopcartTableViewProxy.dataArray = dataArray;
    [self.shopcartTableView reloadData];
}

//购物车视图需要更新时的统一回调
- (void)shopcartFormatAccountForTotalPrice:(float)totalPrice totalCount:(NSInteger)totalCount isAllSelected:(BOOL)isAllSelected {
    [self.shopcartBottomView configureShopcartBottomViewWithTotalPrice:totalPrice totalCount:totalCount isAllselected:isAllSelected];
    [self.shopcartTableView reloadData];
}

//点击结算按钮后的回调
- (void)shopcartFormatSettleForSelectedProducts:(NSArray *)selectedProducts {
    
}

//批量删除回调
- (void)shopcartFormatWillDeleteSelectedProducts:(NSArray *)selectedProducts {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"确认要删除这%ld个宝贝吗？", selectedProducts.count] preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.shopcartFormat deleteSelectedProducts:selectedProducts];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

//全部删除回调
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
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确认要删除这个宝贝吗？" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf.shopcartFormat deleteProductAtIndexPath:indexPath];
            }]];
            [weakSelf presentViewController:alert animated:YES completion:nil];
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
        _shopcartBottomView.shopcartBotttomViewAllSelectBlock = ^(BOOL isSelected){
            [weakSelf.shopcartFormat selectAllProductWithStatus:isSelected];
        };
        
        _shopcartBottomView.shopcartBotttomViewSettleBlock = ^(){
            [weakSelf.shopcartFormat settleSelectedProducts];
        };
        
        _shopcartBottomView.shopcartBotttomViewStarBlock = ^(){
            [weakSelf.shopcartFormat starSelectedProducts];
        };
        
        _shopcartBottomView.shopcartBotttomViewDeleteBlock = ^(){
            [weakSelf.shopcartFormat beginToDeleteSelectedProducts];
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

- (UIButton *)editButton {
    if (_editButton == nil){
        _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _editButton.frame = CGRectMake(0, 0, 40, 40);
        [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
        [_editButton setTitle:@"完成" forState:UIControlStateSelected];
        [_editButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _editButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_editButton addTarget:self action:@selector(editButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editButton;
}

- (void)editButtonAction {
    self.editButton.selected = !self.editButton.isSelected;
    [self.shopcartBottomView changeShopcartBottomViewWithStatus:self.editButton.isSelected];
}

- (void)addSubview {
    UIBarButtonItem *editBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.editButton];
    self.navigationItem.rightBarButtonItem = editBarButtonItem;
    
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
