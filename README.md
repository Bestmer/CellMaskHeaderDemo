## iOS实现TableViewCell遮挡Header效果
![](https://tva1.sinaimg.cn/large/007S8ZIlly1gdpq8564wmg306y0f9aee.gif)
---
## 分析
1、由于第一个cell和header有叠加效果，但是cell单独设置clipsToBounds为NO并不能达到效果，所以这种方案行不通；

```
self.contentView.clipsToBounds = NO;
```


2、考虑到还要兼容header下拉放大的效果，所以将背景图和第一个cell作为单独的header能够实现效果，但需要单独处理数据源，将列表中的第一条取出来填充到header里面，有点麻烦但能达到效果；

![](https://tva1.sinaimg.cn/large/007S8ZIlly1gdpqpkefl5j30b60ngdgh.jpg)

3、最后说说我实现的方式：

```
/// 需要遮罩header部分的高度
static NSInteger kNeedMaskHeaderHeight = 60;
/// 需要占位假header的高度
static NSInteger kFakeHeaderHeight = 180;


// 1.创建一个空白且透明的header，用来占位
UIView *fakeHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kFakeHeaderHeight)];
fakeHeader.backgroundColor = UIColor.clearColor;
self.tableView.tableHeaderView = fakeHeader;
[self.tableView reloadData];

```

```
// 2.将真正的header添加到tableView上面
[self.tableView addSubview:self.headerView];
[self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.tableView);
    make.width.equalTo(self.tableView);
    make.height.equalTo(@(kFakeHeaderHeight + kNeedMaskHeaderHeight));
}];
```

```
// 3.移除透明的空白占位header，否则会阻挡交互
[self.tableView.tableHeaderView removeFromSuperview];
```

```
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // 4.将真正的header置于tableView视图层级最底下
    [self.tableView sendSubviewToBack:self.headerView];
}
```

---
## 总结
积极总结UI技巧，能够帮助我们快速完成业务。
