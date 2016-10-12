//
//  NavigationVC.m
//  Project
//
//  Created by qingyun3 on 16/10/9.
//  Copyright © 2016年 liuhuan. All rights reserved.
//

#import "NavigationVC.h"

@interface NavigationVC ()

@end

@implementation NavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
}

- (void) loadDefaultSetting {
    self.navigationBar.translucent = NO;
}

//第一次调用这个类的时候调用这个方法
+ (void)initialize {
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.35 green:0.67 blue:0.89 alpha:1.00]];
    //隐藏底部黑线
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
}

//重写跳转方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count != 0) {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:[UIImage imageNamed:@"back_32x32_"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(popAction) forControlEvents:UIControlEventTouchUpInside];
        [backBtn sizeToFit];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        viewController.view.backgroundColor = [UIColor colorWithRed:0.00 green:0.33 blue:1.00 alpha:1.00];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)popAction {
    [self popViewControllerAnimated:YES];
}

@end
