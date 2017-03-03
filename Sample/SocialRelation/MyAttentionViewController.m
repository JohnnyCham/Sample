//
//  MyAttentionViewController.m
//  mapgo
//
//  Created by iMac on 2017/3/3.
//  Copyright © 2017年 xiaoku. All rights reserved.
//

#import "MyAttentionViewController.h"
#import "CountPersonCell.h"
#import "FollowModel.h"
#import "MyFansCell.h"
#import "JKAlertView.h"
#import "HUDUtil.h"

@interface MyAttentionViewController ()

@end

@implementation MyAttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)tableViewDidTriggerHeaderRefresh {
    if (self.concernType == ConcernTypeSelf) {
        [CMDs getUserFansWithUserID:[Sessions getUserID] callback:^(int code, FollowViewModel *viewModel) {
            [self handleResultData];
        }];
    } else if (self.concernType == ConcernTypeOther) {
        [CMDs getOtherUserFollowListWithOtherUserID:self.userID MyID:[Sessions getUserID] Callback:^(int code, NSArray<FollowModel *> *array) {
            [self handleResultData];
        }];
    }
}

- (void)handleResultData {
    [super handleResultData];
}

#pragma mark - TableViewDelegate && Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == self.sectionArray.count) {
        return 0.1;
    }else {
        return 24.0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == self.sectionArray.count) {
        CountPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MYFOOTERCELL"];
        if (!cell) {
            cell = [[CountPersonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MYFOOTERCELL"];
        }
        [cell SetCount:[NSString stringWithFormat:@"%ld位粉丝", [self countAllAttentions]]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        FollowModel *model = self.sectionArray[indexPath.section][indexPath.row];
        MyFansCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MYFANSCELL"];
        if (!cell) {
            cell = [[MyFansCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MYFANSCELL"];
        }
        [cell cell_builtWithModel:model];
        __weak typeof(self) weekself = self;
        cell.cancelblock =^(FollowModel *model, BOOL isFocus) {
            if (isFocus) {
                [weekself cellCancelAttention:model];
            }else {
                [weekself cellAttention:model];
            }
        };
        return cell;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
