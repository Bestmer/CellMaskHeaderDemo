//
//  CustomNavigationView.m
//  CellMaskHeaderDemo
//
//  Created by Roc Kwok on 2020/4/11.
//  Copyright © 2020 Roc Kwok. All rights reserved.
//

#import "CustomNavigationView.h"
#import "Masonry.h"

static CGFloat kTitleLabelHeight = 44.0f;

@interface CustomNavigationView ()

/** 返回按钮 */
@property (nonatomic, strong) UIButton *backButton;
/** 分享按钮 */
@property (nonatomic, strong) UIButton *shareButton;
/** 标题 */
@property (nonatomic, strong) UILabel *titleLabel;
/** 背景视图 */
@property (nonatomic,strong) UIView *backgroundView;
/** 分割线 */
@property (nonatomic,strong) UIView *lineView;

@end

@implementation CustomNavigationView

- (instancetype)init {
    if (self = [super init]) {
        [self initViews];
    }
    return self;
}

#pragma mark - Private

- (void)initViews {
    self.clipsToBounds = YES;
    self.backgroundColor = UIColor.clearColor;
    
    [self addSubview:self.backgroundView];
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self addSubview:self.shareButton];
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-5);
        make.bottom.equalTo(self).offset(-8);
        make.size.mas_equalTo(CGSizeMake((40), (25)));
    }];
    
    [self addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.bottom.equalTo(self.shareButton);
        make.size.equalTo(self.shareButton);
    }];
    
    
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@(0.5));
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(kTitleLabelHeight);
    }];
    
}

#pragma mark - Public

- (void)updateBackgroundViewAlpha:(CGFloat)alpha {
    if (self.backgroundView.alpha == alpha) {
        return;
    }
    self.backgroundView.alpha = alpha;
    self.lineView.alpha = alpha;
    if (alpha < 1) {
        [_shareButton setSelected:NO];
        [_backButton setSelected:NO];
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(kTitleLabelHeight);
        }];
    } else {
        [_shareButton setSelected:YES];
        [_backButton setSelected:YES];
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-13);
        }];
    }
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self layoutIfNeeded];
    } completion:NULL];
}

#pragma mark - Getters

- (UIButton *)shareButton {
    if (!_shareButton) {
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareButton setImage:[UIImage imageNamed:@"gt_shop_share"] forState:UIControlStateNormal];
        [_shareButton setImage:[UIImage imageNamed:@"gt_shop_share"] forState:UIControlStateSelected];
        [_shareButton.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake((25), (25)));
        }];
    }
    return _shareButton;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"gt_shop_back"] forState:UIControlStateNormal];
        [_backButton setImage:[UIImage imageNamed:@"gt_shop_back"] forState:UIControlStateSelected];
        [_backButton.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake((25), (25)));
        }];
    }
    return _backButton;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:19];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"Roc Kwok";
    }
    return _titleLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = UIColor.grayColor;
        _lineView.alpha = 0.0f;
    }
    return _lineView;
}

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [UIView new];
        _backgroundView.backgroundColor = UIColor.whiteColor;
        _backgroundView.alpha = 0.0f;
    }
    return _backgroundView;
}


@end


