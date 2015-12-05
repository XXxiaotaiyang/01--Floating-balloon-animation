//
//  ViewController.m
//  01- Floating balloon
//
//  Created by 闲人 on 15/12/5.
//  Copyright © 2015年 闲人. All rights reserved.
//

#import "ViewController.h"
#import "CCBalloonView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 将气球上升的View添加到现有的控制器上
    CCBalloonView *BView = [[CCBalloonView alloc] init];
    BView.frame = self.view.bounds;
    BView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:BView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
