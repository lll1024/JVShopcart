//
//  JVShopcartBottomView.m
//  JVShopcart
//
//  Created by AVGD-Jarvi on 17/3/23.
//  Copyright © 2017年 AVGD-Jarvi. All rights reserved.
//

#import "JVShopcartBottomView.h"
#import "UIButton+JVCenter.h"
#import "Masonry.h"

@interface JVShopcartBottomView ()

@property (nonatomic, strong) UIButton *allSelectButton;
@property (nonatomic, strong) UILabel *totalPriceLable;
@property (nonatomic, strong) UIButton *settleButton;
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
    [self addSubview:self.separateLine];
}

- (void)configureShopcartBottomViewWithTotalPrice:(float)totalPrice totalCount:(NSInteger)totalCount isAllselected:(BOOL)isAllSelected {
    self.allSelectButton.selected = isAllSelected;
    
    self.totalPriceLable.text = [NSString stringWithFormat:@"合计：￥%.f\n不含运费", totalPrice];
    [self renderWithTotalPrice:[NSString stringWithFormat:@"￥%.f", totalPrice]];
    
    [self.settleButton setTitle:[NSString stringWithFormat:@"结算(%ld)", totalCount] forState:UIControlStateNormal];
    self.settleButton.enabled = totalCount && totalPrice;
    if (self.settleButton.isEnabled) {
        [self.settleButton setBackgroundColor:[UIColor colorWithRed:0.918  green:0.141  blue:0.137 alpha:1]];
    } else {
        [self.settleButton setBackgroundColor:[UIColor lightGrayColor]];
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

- (UIButton *)allSelectButton {
    if (_allSelectButton == nil){
        _allSelectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_allSelectButton setTitle:@"全选" forState:UIControlStateNormal];
        [_allSelectButton setTitleColor:[UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1] forState:UIControlStateNormal];
        _allSelectButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_allSelectButton setImage:[UIImage imageNamed:@"Unselected"] forState:UIControlStateNormal];
        [_allSelectButton setImage:[UIImage imageNamed:@"Selected"] forState:UIControlStateSelected];
        [_allSelectButton addTarget:self action:@selector(allSelectButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_allSelectButton centerStyle:CenterButtonImageStyleLeft padding:5];
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

- (UIView *)separateLine {
    if (_separateLine == nil){
        _separateLine = [[UIView alloc] init];
        _separateLine.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    }
    return _separateLine;
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

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.allSelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    
    [self.settleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self);
        make.width.equalTo(@120);
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
