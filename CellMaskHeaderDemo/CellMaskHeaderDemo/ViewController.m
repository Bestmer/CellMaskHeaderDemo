//
//  ViewController.m
//  CellMaskHeaderDemo
//
//  Created by Roc Kwok on 2020/4/11.
//  Copyright © 2020 Roc Kwok. All rights reserved.
//

#import "ViewController.h"
#import "CustomNavigationView.h"
#import "CustomTableViewCell.h"
#import "CustomHeader.h"
#import "Masonry.h"

/// 需要遮罩header部分的高度
static NSInteger kNeedMaskHeaderHeight = 60;
/// 需要占位假header的高度
static NSInteger kFakeHeaderHeight = 180;

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

/** 自定义导航栏 */
@property (nonatomic, strong) CustomNavigationView *navitaionView;
/** tableView */
@property (nonatomic, strong) UITableView *tableView;
/** header */
@property (nonatomic, strong) CustomHeader *headerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.grayColor;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    // 1.创建一个空白且透明的header，用来占位
    UIView *fakeHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kFakeHeaderHeight)];
    fakeHeader.backgroundColor = UIColor.clearColor;
    self.tableView.tableHeaderView = fakeHeader;
    [self.tableView reloadData];
    
    CGFloat statusBarHeight = UIApplication.sharedApplication.statusBarFrame.size.height;
    [self.view addSubview:self.navitaionView];
    [self.navitaionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.tableView);
        make.height.equalTo(@(statusBarHeight+44));
    }];
    
    // 2.将真正的header添加到tableView上面
    [self.tableView addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView);
        make.width.equalTo(self.tableView);
        make.height.equalTo(@(kFakeHeaderHeight + kNeedMaskHeaderHeight));
    }];
    
    // 3.移除透明的空白占位header，否则会阻挡交互
    [self.tableView.tableHeaderView removeFromSuperview];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    [self.headerView updateBackgroundImageWithOffset:offsetY];
    if (offsetY < 0) {
        [self.navitaionView updateBackgroundViewAlpha:0];
        return;
    }
    
    float maxY = 100.0f;
    float alpha = 0;
    float startAlpha = 0;
    CGFloat heightWhenWhite = maxY/2.0;
    float bili = fabs(offsetY/heightWhenWhite);
    alpha = (1-startAlpha)*bili + startAlpha;
    alpha = MIN(alpha, 1);
    alpha = MAX(alpha, 0);
    [self.navitaionView updateBackgroundViewAlpha:alpha];
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CustomTableViewCell.self) forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // 4.将真正的header置于tableView视图层级最底下
    [self.tableView sendSubviewToBack:self.headerView];
}

#pragma mark - Getters

- (CustomNavigationView *)navitaionView {
    if (!_navitaionView) {
        _navitaionView = [CustomNavigationView new];
    }
    return _navitaionView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColor.clearColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, CGFLOAT_MIN)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.rowHeight = 130.0f;
        if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [_tableView registerClass:CustomTableViewCell.self forCellReuseIdentifier:NSStringFromClass(CustomTableViewCell.self)];
    }
    return _tableView;
}

- (CustomHeader *)headerView {
    if (!_headerView) {
        _headerView = [CustomHeader new];
    }
    return _headerView;
}

@end
