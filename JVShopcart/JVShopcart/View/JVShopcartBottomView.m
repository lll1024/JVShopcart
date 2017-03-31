//
//  JVShopcartBottomView.m
//  JVShopcart
//
//  Created by AVGD-Jarvi on 17/3/23.
//  Copyright © 2017年 AVGD-Jarvi. All rights reserved.
//

#import "JVShopcartBottomView.h"
#import "Masonry.h"

@interface JVShopcartBottomView ()

@property (nonatomic, strong) UIButton *allSelectButton;
@property (nonatomic, strong) UILabel *totalPriceLable;
@property (nonatomic, strong) UIButton *settleButton;
@property (nonatomic, strong) UIButton *starButton;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) UIView *separateLine;

@end

@implementation JVShopcartBottomView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupView];
    }
    return self;
}

- (void)setupView {
    [self addSubview:self.allSelectButton];
    [self addSubview:self.totalPriceLable];
    [self renderWithTotalPrice:@"￥0"];
    [self addSubview:self.settleButton];
    [self addSubview:self.starButton];
    [self addSubview:self.deleteButton];
    [self addSubview:self.separateLine];
}

- (void)changeShopcartBottomViewWithStatus:(BOOL)status {
    self.starButton.hidden = !status;
    self.deleteButton.hidden = !status;
}

- (void)configureShopcartBottomViewWithTotalPrice:(float)totalPrice totalCount:(NSInteger)totalCount isAllselected:(BOOL)isAllSelected {
    self.allSelectButton.selected = isAllSelected;
    
    self.totalPriceLable.text = [NSString stringWithFormat:@"合计：￥%.f\n不含运费", totalPrice];
    [self renderWithTotalPrice:[NSString stringWithFormat:@"￥%.f", totalPrice]];
    
    [self.settleButton setTitle:[NSString stringWithFormat:@"结算(%ld)", totalCount] forState:UIControlStateNormal];
    self.settleButton.enabled = totalCount && totalPrice;
    self.starButton.enabled = totalCount && totalPrice;
    self.deleteButton.enabled = totalCount && totalPrice;
    if (self.settleButton.isEnabled) {
        [self.settleButton setBackgroundColor:[UIColor colorWithRed:0.918  green:0.141  blue:0.137 alpha:1]];
        [self.deleteButton setBackgroundColor:[UIColor colorWithRed:0.918  green:0.141  blue:0.137 alpha:1]];
        [self.starButton setBackgroundColor:[UIColor colorWithRed:243/255.0 green:176/255.0 blue:74/255.0 alpha:1]];
    } else {
        [self.settleButton setBackgroundColor:[UIColor lightGrayColor]];
        [self.deleteButton setBackgroundColor:[UIColor lightGrayColor]];
        [self.starButton setBackgroundColor:[UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1]];
    }
}

- (void)allSelectButtonAction {
    self.allSelectButton.selected = !self.allSelectButton.isSelected;
    
    if (self.shopcartBotttomViewAllSelectBlock) {
        self.shopcartBotttomViewAllSelectBlock(self.allSelectButton.isSelected);
    }
}


- (void)settleButtonAction {
    if (self.shopcartBotttomViewSettleBlock) {
        self.shopcartBotttomViewSettleBlock();
    }
}

- (void)starButtonAction {
    if (self.shopcartBotttomViewStarBlock) {
        self.shopcartBotttomViewStarBlock();
    }
}

- (void)deleteButtonAction {
    if (self.shopcartBotttomViewDeleteBlock) {
        self.shopcartBotttomViewDeleteBlock();
    }
}

- (void)renderWithTotalPrice:(NSString *)totalPrice {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 2;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.totalPriceLable.text attributes:@{NSParagraphStyleAttributeName:paragraphStyle}];
    [attributedString addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:210/255.0 green:50/255.0 blue:50/255.0 alpha:1]} range:[self.totalPriceLable.text rangeOfString:totalPrice]];
    [attributedString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} range:[self.totalPriceLable.text rangeOfString:@"不含运费"]];
    self.totalPriceLable.attributedText = attributedString;
    self.totalPriceLable.textAlignment = NSTextAlignmentRight;
}


- (UIButton *)allSelectButton {
    if (_allSelectButton == nil){
        _allSelectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_allSelectButton setTitle:@"全选" forState:UIControlStateNormal];
        [_allSelectButton setTitleColor:[UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1] forState:UIControlStateNormal];
        _allSelectButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_allSelectButton setImage:[UIImage imageNamed:@"Unselected"] forState:UIControlStateNormal];
        [_allSelectButton setImage:[UIImage imageNamed:@"Selected"] forState:UIControlStateSelected];
        [_allSelectButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
        [_allSelectButton addTarget:self action:@selector(allSelectButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allSelectButton;
}

- (UILabel *)totalPriceLable {
    if (_totalPriceLable == nil){
        _totalPriceLable = [[UILabel alloc] init];
        _totalPriceLable.font = [UIFont systemFontOfSize:14];
        _totalPriceLable.textColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1];
        _totalPriceLable.numberOfLines = 2;
        _totalPriceLable.text = @"合计：￥0\n不含运费";
    }
    return _totalPriceLable;
}

- (UIButton *)settleButton {
    if (_settleButton == nil){
        _settleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_settleButton setTitle:@"结算(0)" forState:UIControlStateNormal];
        [_settleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _settleButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_settleButton setBackgroundColor:[UIColor lightGrayColor]];
        [_settleButton addTarget:self action:@selector(settleButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _settleButton.enabled = NO;
    }
    return _settleButton;
}

- (UIButton *)starButton {
    if (_starButton == nil){
        _starButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_starButton setTitle:@"收藏" forState:UIControlStateNormal];
        [_starButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _starButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_starButton setBackgroundColor:[UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1]];
        [_starButton addTarget:self action:@selector(starButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _starButton.enabled = NO;
        _starButton.hidden = YES;
    }
    return _starButton;
}

- (UIButton *)deleteButton {
    if (_deleteButton == nil){
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _deleteButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_deleteButton setBackgroundColor:[UIColor lightGrayColor]];
        [_deleteButton addTarget:self action:@selector(deleteButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _deleteButton.enabled = NO;
        _deleteButton.hidden = YES;
    }
    return _deleteButton;
}

- (UIView *)separateLine {
    if (_separateLine == nil){
        _separateLine = [[UIView alloc] init];
        _separateLine.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    }
    return _separateLine;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.allSelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    
    [self.settleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self);
        make.width.equalTo(@100);
    }];
    
    [self.starButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.right.equalTo(self.deleteButton.mas_left);
        make.width.equalTo(@100);
    }];
    
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self);
        make.width.equalTo(@100);
    }];
    
    [self.totalPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.allSelectButton.mas_right);
        make.right.equalTo(self.settleButton.mas_left).offset(-5);
    }];
    
    [self.separateLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.equalTo(@0.3);
    }];
}

@end
