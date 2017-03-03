//
//  MyAttentionViewController.h
//  mapgo
//
//  Created by iMac on 2017/3/3.
//  Copyright © 2017年 xiaoku. All rights reserved.
//

#import "RelationRefreshViewController.h"

typedef NS_ENUM(NSUInteger, ConcernType) {
    ConcernTypeSelf,
    ConcernTypeOther,
};

@interface MyAttentionViewController : RelationRefreshViewController

@property (assign, nonatomic) ConcernType concernType;

@end
