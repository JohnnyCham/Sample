//
//  ViewController.m
//  Sample
//
//  Created by iMac on 2017/2/28.
//  Copyright © 2017年 xiaoku. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [btn setImage:[UIImage imageNamed:@"tu"] forState:UIControlStateNormal];
    btn.adjustsImageWhenHighlighted = NO;
    btn.layer.cornerRadius = 50;
    btn.layer.masksToBounds = YES;
    [self.view addSubview:btn];
}

- (void)touch {
    NSLog(@"%s", __func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
