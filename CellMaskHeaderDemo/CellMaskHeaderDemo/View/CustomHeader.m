//
//  CustomHeader.m
//  CellMaskHeaderDemo
//
//  Created by Roc Kwok on 2020/4/11.
//  Copyright © 2020 Roc Kwok. All rights reserved.
//

#import "CustomHeader.h"
#import "Masonry.h"

@interface CustomHeader()

/** 背景图 */
@property (nonatomic, strong) UIImageView *backgroundImageView;

@end

@implementation CustomHeader

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.clearColor;
        [self addSubview:self.backgroundImageView];
        [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.top.equalTo(self);
        }];
    }
    return self;
}

- (void)updateBackgroundImageWithOffset:(CGFloat)offsetY {
    if (offsetY >=0) {
        [self.backgroundImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
        }];
    } else {
        [self.backgroundImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(offsetY);
        }];
    }
}

#pragma mark - Getters

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gt_header"]];
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backgroundImageView;
}

@end
