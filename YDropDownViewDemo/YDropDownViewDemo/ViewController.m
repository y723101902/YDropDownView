//
//  ViewController.m
//  YDropDownViewDemo
//
//  Created by yjn on 2017/8/29.
//  Copyright © 2017年 zhengxingyuan. All rights reserved.
//

#import "ViewController.h"
#import "YDropDownView.h"

@interface ViewController ()<YDropDownViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    YDropDownView *dview = [[YDropDownView alloc] initWithFrame:CGRectMake(0, 100, 200, 40)];
    dview.backgroundColor = [UIColor orangeColor];
    dview.defaultStr = @"老虎";
    dview.listData = @[@"老虎",@"狮子",@"大象",@"熊猫",@"企鹅",@"大雁",@"喜鹊"];
    dview.delegate = self;
    dview.maxHeight = 300;
    dview.menuBlock = ^(NSInteger i ,NSString *chooseStr){
        
    };
    [self.view addSubview:dview];
}
#pragma mark -DropDownDelegate
- (void)showShadowViewWithBool:(BOOL)isShow {
    if (isShow) {
        //添加手势
    }else {
        //不添加
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
