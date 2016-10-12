//
//  MainVC.m
//  Project
//
//  Created by qingyun3 on 16/10/9.
//  Copyright © 2016年 liuhuan. All rights reserved.
//

#import "MainVC.h"
#import "NavigationVC.h"

@interface MainVC ()

@property (nonatomic, copy) NSArray *arrTitle;
@property (nonatomic, copy) NSArray *arrImage;
@property (nonatomic, copy) NSArray *arrController;
@property (nonatomic, copy) NSArray *arrSelectImage;

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
}

- (void) loadDefaultSetting {
    
    UIStoryboard *story1 = [UIStoryboard storyboardWithName:@"News" bundle:nil];
    UIStoryboard *story2 = [UIStoryboard storyboardWithName:@"Video" bundle:nil];
    UIStoryboard *story3 = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
    
    UIViewController *vcNews = [story1 instantiateViewControllerWithIdentifier:@"newsvc"];
    UIViewController *vcVideo = [story2 instantiateViewControllerWithIdentifier:@"videovc"];
    UIViewController *vcMine = [story3 instantiateViewControllerWithIdentifier:@"minevc"];

    self.arrTitle = @[@"新闻",@"视频"];
    self.arrImage = @[@"news_28x28_",@"video_28x28_"];
    self.arrSelectImage = @[@"news_press_28x28_",@"video_press_28x28_"];
    
    self.arrController = @[vcNews, vcVideo];
    NSUInteger count = self.arrTitle.count;
    for (NSUInteger index = 0; index < count; index++) {
        [self Controller:self.arrController[index] Title:self.arrTitle[index] Image:self.arrImage[index] SelectImage:self.arrSelectImage[index]];
    }
    //去掉tabbar顶部导航条
    [self.tabBar setClipsToBounds:YES];
    //设置字体颜色
    self.tabBar.tintColor = [UIColor colorWithRed:0.50 green:0.83 blue:0.98 alpha:1.00];
    //设置背景颜色
    self.tabBar.barTintColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00];
}

- (void)Controller:(UIViewController *)vc Title:(NSString *)title Image:(NSString *)imageName SelectImage:(NSString *)selectImage{
    vc.tabBarItem.title = title;
    vc.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, 0);
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
    NavigationVC *vcNav = [[NavigationVC alloc] initWithRootViewController:vc];
    [self addChildViewController:vcNav];
}


@end
