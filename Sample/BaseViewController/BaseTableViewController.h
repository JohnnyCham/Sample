//
//  BaseRefreshViewController.h
//  mapgo
//
//  Created by Johnny on 2017/3/3.
//  Copyright © 2017年 xiaoku. All rights reserved
//

#import <UIKit/UIKit.h>
#import <Masonry.h>
#import <MJRefresh.h>

@interface BaseTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

/** 数据数组*/
@property (nonatomic, strong) NSMutableArray *dataArray;

/** 分页一页数据个数*/
@property (nonatomic, assign) NSInteger pageSize;

/** tableView距离ViewController顶部距离*/
@property (nonatomic, assign) NSInteger tableViewTop;

/** tableView距离ViewController底部距离*/
@property (nonatomic, assign) NSInteger tableViewBottom;

/** 是否需要刷新的header 默认使用header*/
@property (nonatomic, assign) BOOL showRefreshHeader;

/** 是否需要加载的footer*/
@property (nonatomic, assign) BOOL showRefreshFooter;

/** tableView上下刷新的开始和停止*/
- (void)beginHeaderRefreshing;
- (void)endHeaderRefreshing;
- (void)beginFooterRefreshing;
- (void)endFooterRefreshing;
- (void)endAllRefreshing;

/** tableView滑动到顶部*/
- (void)tableViewScrollToTop;

/** 下拉刷新事件*/
- (void)tableViewDidTriggerHeaderRefresh;

/** 上拉加载事件*/
- (void)tableViewDidTriggerFooterRefresh;

/**
 提供数据返回时刷新tableView 里面header和footer停止隐藏的逻辑 可以不使用 或者重写覆盖

 @param isHeader 是否是下拉刷新
 @param freshDataArray 返回的数据model数组
 */
- (void)tableViewDidFinishTriggerHeader:(BOOL)isHeader freshDataArray:(NSArray *)freshDataArray;
- (void)handleHeaderReloadFreshDataArray:(NSArray *)freshDataArray;
- (void)handleFooterReloadFreshDataArray:(NSArray *)freshDataArray;

@end
