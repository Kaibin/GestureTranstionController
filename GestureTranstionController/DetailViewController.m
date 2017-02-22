//
//  DetailViewController.m
//  GestureTranstionController
//
//  Created by kaibin on 17/2/22.
//  Copyright © 2017年 demo. All rights reserved.
//

#import "DetailViewController.h"
#import "SecondViewController.h"

@interface DetailViewController ()

@property (nonatomic, strong) UIButton *actionButton;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)initView
{
    self.actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.actionButton.titleLabel.font = [UIFont systemFontOfSize:20];
    self.actionButton.backgroundColor = [UIColor whiteColor];
    [self.actionButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.actionButton setTitle:@"Push" forState:UIControlStateNormal];
    self.actionButton.frame = CGRectMake((self.view.bounds.size.width-80)/2, CGRectGetHeight(self.view.bounds) - 100, 80, 50);
    [self.view addSubview:self.actionButton];
    [self.actionButton addTarget:self action:@selector(onActionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onActionButtonPressed:(id)sender
{
    SecondViewController *vc = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
