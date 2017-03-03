//
//  BaseRefreshViewController.m
//  mapgo
//
//  Created by Johnny on 2017/3/3.
//  Copyright © 2017年 xiaoku. All rights reserved
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    self.showRefreshHeader = YES;
}

#pragma mark - Config

- (void)createTableView {    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self setTableViewTop:0];
}

#pragma mark - Setter

- (void)setTableViewTop:(NSInteger)tableViewTop {
    _tableViewTop = tableViewTop;
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(@(tableViewTop));
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(self.tableViewBottom));
    }];
}

- (void)setTableViewBottom:(NSInteger)tableViewBottom {
    _tableViewBottom = tableViewBottom;
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(@(self.tableViewTop));
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(tableViewBottom));
    }];
}

- (void)setShowRefreshHeader:(BOOL)showRefreshHeader {
    _showRefreshHeader = showRefreshHeader;
    if (_showRefreshHeader) {
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(tableViewDidTriggerHeaderRefresh)];
        self.tableView.mj_header = header;
    } else {
        self.tableView.mj_header = nil;
    }
}

- (void)setShowRefreshFooter:(BOOL)showRefreshFooter {
    if (showRefreshFooter) {
        if (_showRefreshFooter == NO) {
            MJRefreshAutoStateFooter *footer = [MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(tableViewDidTriggerFooterRefresh)];
            self.tableView.mj_footer = footer;
        }
    } else {
        self.tableView.mj_footer = nil;
    }
    _showRefreshFooter = showRefreshFooter;
}

#pragma mark - Tableview delegate & datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UITableViewCell new];
}

#pragma mark - Public

- (void)beginHeaderRefreshing {
    if (![self.tableView.mj_header isRefreshing]) {
        [self.tableView.mj_header beginRefreshing];
    }
}

- (void)endHeaderRefreshing {
    if ([self.tableView.mj_header isRefreshing]) {
        [self.tableView.mj_header endRefreshing];
    }
}

- (void)beginFooterRefreshing {
    if (![self.tableView.mj_footer isRefreshing]) {
        [self.tableView.mj_footer beginRefreshing];
    }
}

-(void)endFooterRefreshing {
    if ([self.tableView.mj_footer isRefreshing]) {
        [self.tableView.mj_footer endRefreshing];
    }
}

- (void)endAllRefreshing {
    [self endHeaderRefreshing];
    [self endFooterRefreshing];
}

- (void)tableViewScrollToTop {
    if (self.dataArray.count>0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

- (void)tableViewDidTriggerHeaderRefresh {}

- (void)tableViewDidTriggerFooterRefresh {}

- (void)tableViewDidFinishTriggerHeader:(BOOL)isHeader freshDataArray:(NSArray *)freshDataArray {
    if (self.pageSize == 0 || self.pageSize < 0) {
        return;
    }
    if (isHeader) {
        [self handleHeaderReloadFreshDataArray:freshDataArray];
    } else {
        [self handleFooterReloadFreshDataArray:freshDataArray];
    }
}

- (void)handleHeaderReloadFreshDataArray:(NSArray *)freshDataArray {
    self.dataArray = [freshDataArray mutableCopy];
    if (!self.dataArray || self.dataArray.count==0) {
        self.showRefreshFooter = NO;
    } else if (self.dataArray.count<self.pageSize) {
        self.showRefreshFooter = YES;
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        self.showRefreshFooter = YES;
        [self.tableView.mj_footer resetNoMoreData];
    }
    [self.tableView.mj_header endRefreshing];
    [self.tableView reloadData];
}

- (void)handleFooterReloadFreshDataArray:(NSArray *)freshDataArray {
    [self.dataArray addObjectsFromArray:freshDataArray];
    if (!freshDataArray || freshDataArray.count<self.pageSize) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.tableView.mj_footer endRefreshing];
    }
    [self.tableView reloadData];
}

#pragma mark - Getter

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
