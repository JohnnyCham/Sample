//
//  BaseRefreshViewController.h
//  mapgo
//
//  Created by iMac on 2017/3/3.
//  Copyright © 2017年 xiaoku. All rights reserved.
//

#import "BaseViewController.h"
#import <Masonry.h>
#import <MJRefresh.h>
#import "UIScrollView+EmptyDataSet.h"
#import "JKAlertView.h"
#import "HUDUtil.h"
#import "CMDs+User.h"

@interface RelationRefreshViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSMutableArray<NSMutableArray *> *sectionArray;
@property (strong, nonatomic) NSMutableArray *sectionHeaderArray;

@property (assign, nonatomic) NSInteger userID;

@property (assign, nonatomic) NSInteger tableViewTop;
@property (assign, nonatomic) NSInteger tableViewBottom;
@property (assign, nonatomic) BOOL showRefreshHeader;       //是否支持下拉刷新
@property (assign, nonatomic) BOOL showRefreshFooter;       //是否支持上拉加载
@property (assign, nonatomic) BOOL isDataBack;              //网络数据是否已返回

- (void)beginTableViewHeader;
- (void)endRefreshHeader;
- (void)endAllRefreshing;
- (void)tableViewScrollToTop;
- (void)tableViewDidTriggerHeaderRefresh;                   //下拉刷新事件
- (void)handleResultData;                                   //处理网络数据返回的东西
- (NSUInteger)countAllAttentions;
- (void)cellCancelAttention:(FollowModel *)model;
- (void)cellAttention:(FollowModel *)model;

@end
