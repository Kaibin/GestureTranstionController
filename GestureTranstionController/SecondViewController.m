//
//  SecondViewController.m
//  GestureTranstionController
//
//  Created by kaibin on 17/2/22.
//  Copyright © 2017年 demo. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController () <UIGestureRecognizerDelegate>

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    //因为navigationBar被隐藏了，需要重新设置返回手势
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

@end
