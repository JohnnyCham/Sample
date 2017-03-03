//
//  BaseRefreshViewController.m
//  mapgo
//
//  Created by iMac on 2017/3/3.
//  Copyright © 2017年 xiaoku. All rights reserved.
//

#import "RelationRefreshViewController.h"
#import "EaseChineseToPinyin.h"

@interface RelationRefreshViewController ()

@end

@implementation RelationRefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createTableView];
    self.showRefreshHeader = YES;
    [self beginTableViewHeader];
}

- (void)createTableView {    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self setTableViewTop:0];
}

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
        header.lastUpdatedTimeLabel.hidden = YES;
        header.stateLabel.hidden = YES;
        self.tableView.mj_header = header;
    } else{
        self.tableView.mj_header = nil;
    }
}

- (void)setShowRefreshFooter:(BOOL)showRefreshFooter {
    if (showRefreshFooter) {
        if (_showRefreshFooter == NO) {
            MJRefreshAutoStateFooter *footer = [MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(tableViewDidTriggerFooterRefresh)];
            [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
            self.tableView.mj_footer = footer;
        }
    } else{
        self.tableView.mj_footer = nil;
    }
    _showRefreshFooter = showRefreshFooter;
}

#pragma mark - DZNEmptyDataSetSource

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

#pragma mark - Tableview delegate & datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.sectionArray.count) {
        return (self.sectionArray.count+1);
    }else {
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == self.sectionArray.count) {
        return 1;
    }else {
        return self.sectionArray[section].count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == self.sectionArray.count) {
        return 40;
    }else {
        return 60.0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UITableViewCell new];
}

#pragma mark - Public

- (void)beginTableViewHeader {
    if (![self.tableView.mj_header isRefreshing]) {
        [self.tableView.mj_header beginRefreshing];
    }
}

- (void)endRefreshHeader {
    if ([self.tableView.mj_header isRefreshing]) {
        [self.tableView.mj_header endRefreshing];
    }
}

- (void)endAllRefreshing {
    if ([self.tableView.mj_header isRefreshing]) {
        [self.tableView.mj_header endRefreshing];
    }
    if ([self.tableView.mj_footer isRefreshing]) {
        [self.tableView.mj_footer endRefreshing];
    }
}

- (void)tableViewScrollToTop {
    if (self.dataArray.count > 0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

- (void)tableViewDidTriggerHeaderRefresh {}

- (void)tableViewDidTriggerFooterRefresh {}

- (void)handleResultData {
    self.isDataBack = YES;
    
}

- (void)sort_searchList {
//    [self.sectionHeaderArray removeAllObjects];
//    [self.sectionArray removeAllObjects];
//    
//    UILocalizedIndexedCollation *indexedCollation = [UILocalizedIndexedCollation currentCollation];
//    [self.sectionHeaderArray addObjectsFromArray:[indexedCollation sectionTitles]];
//    
//    NSMutableArray *sortarray = [[NSMutableArray alloc] init];
//    for (int i = 0; i < self.sectionHeaderArray.count; i++) {
//        NSMutableArray *sectionArray = [[NSMutableArray alloc] init];
//        [sortarray addObject:sectionArray];
//    }
//    
//    for (MyAttentionModel *model in self.dataArray) {
//        if (!model.nickname.length) {
//            continue;
//        }
//        NSString *fitst = [EaseChineseToPinyin pinyinFromChineseString:model.nickname];
//        NSInteger index = [indexedCollation sectionForObject:[fitst substringFromIndex:0] collationStringSelector:@selector(uppercaseString)];
//        [sortarray[index] addObject:model];
//    }
//    
//    //每个section内的数组排序
//    for (int i = 0; i < [sortarray count]; i++) {
//        NSArray *array = [[sortarray objectAtIndex:i] sortedArrayUsingComparator:^NSComparisonResult(MyAttentionModel *obj1, MyAttentionModel *obj2) {
//            NSString *firstLetter1 = [EaseChineseToPinyin pinyinFromChineseString:obj1.nickname];
//            if (firstLetter1.length == 0) {
//                firstLetter1 = @" ";
//            }
//            firstLetter1 = [[firstLetter1 substringToIndex:1] uppercaseString];
//            NSString *firstLetter2 = [EaseChineseToPinyin pinyinFromChineseString:obj2.nickname];
//            if (firstLetter2.length == 0) {
//                firstLetter2 = @" ";
//            }
//            firstLetter2 = [[firstLetter2 substringToIndex:1] uppercaseString];
//            return [firstLetter1 caseInsensitiveCompare:firstLetter2];
//        }];
//        [sortarray replaceObjectAtIndex:i withObject:[NSMutableArray arrayWithArray:array]];
//    }
//    
//    //去掉空的section
//    for (NSInteger i = [sortarray count] - 1; i >= 0; i--) {
//        NSArray *array = [sortarray objectAtIndex:i];
//        if ([array count] == 0) {
//            [sortarray removeObjectAtIndex:i];
//            [self.sectionHeaderArray removeObjectAtIndex:i];
//        }
//    }
//    
//    [self.sectionArray addObjectsFromArray:sortarray];
}


//- (void)cellCancelAttention:(FollowModel *)model {
//    JKAlertView *alertView = [[JKAlertView alloc] init];
//    [alertView alertViewWithView:[UIApplication sharedApplication].keyWindow title:@"提示" message:@"确定要取消关注吗" leftButton:@"取消" rightButton:@"确定"];
//    [alertView rightButtonClickWithBlock:^{
//        [CMDs offsetUserFocusWithUserID:[Sessions getUserID] attentionUserID:model.userID callback:^(int code) {
//            if (code == 1) {
//                model.state = 0;
//                [[HUDUtil SharedHUDUtil] showHUDWithController:self Text:@"取消关注成功"];
//                [self.tableView reloadData];
//                [[NSNotificationCenter defaultCenter] postNotificationName:MAAttentionChangeNotifation object:nil];
//            }else {
//                [[HUDUtil SharedHUDUtil] showHUDWithView:self.view Text:@"网络不给力呢"];
//                return;
//            }
//        }];
//    }];
//}
//
//- (void)cellAttention:(FollowModel *)model {
//    [CMDs setUserFocusWithUserID:[Sessions getUserID] attentionUserID:model.userID userName:[Sessions getUserName] callback:^(int code) {
//        if (code == 1) {
//            model.state = 1;
//            [[HUDUtil SharedHUDUtil] showHUDWithController:self Text:@"关注成功"];
//            [self.tableView reloadData];
//            [[NSNotificationCenter defaultCenter] postNotificationName:MAAttentionChangeNotifation object:nil];
//        }
//        else if (code == 2) {
//            [[HUDUtil SharedHUDUtil] showHUDWithView:self.view Text:@"由于对方隐私设置，取消关注失败"];
//        }
//        else if (code == 5) {
//            [[HUDUtil SharedHUDUtil] showHUDWithView:self.view Text:@"对方已被你拉黑，无法执行此操作"];
//        }else {
//            [[HUDUtil SharedHUDUtil] showHUDWithView:self.view Text:@"网络不给力呢"];
//            return;
//        }
//    }];
//}

- (NSUInteger)countAllAttentions {
    NSUInteger allCount = 0;
    for (NSArray *array in self.sectionArray) {
        allCount += array.count;
    }
    return allCount;
}

#pragma mark - Getter

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (NSMutableArray<NSMutableArray *> *)sectionArray {
    if (_sectionArray == nil) {
        _sectionArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _sectionArray;
}

- (NSMutableArray *)sectionHeaderArray {
    if (_sectionHeaderArray == nil) {
        _sectionHeaderArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _sectionHeaderArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
