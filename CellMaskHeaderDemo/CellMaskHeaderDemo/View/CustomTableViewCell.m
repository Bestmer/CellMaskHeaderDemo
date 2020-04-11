//
//  CustomTableViewCell.m
//  CellMaskHeaderDemo
//
//  Created by Roc Kwok on 2020/4/11.
//  Copyright © 2020 Roc Kwok. All rights reserved.
//

#import "CustomTableViewCell.h"
#import "Masonry.h"

@implementation CustomTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = self.contentView.backgroundColor = UIColor.clearColor;
        
        UIView *emptyView = [UIView new];
        emptyView.backgroundColor = UIColor.whiteColor;
        emptyView.layer.cornerRadius = 10.0f;
        emptyView.layer.masksToBounds = YES;
        [self.contentView addSubview:emptyView];
        [emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 15, 10, 15));
        }];
    }
    return self;
}

@end
