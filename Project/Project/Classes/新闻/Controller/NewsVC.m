//
//  NewsVC.m
//  Project
//
//  Created by qingyun3 on 16/10/9.
//  Copyright © 2016年 liuhuan. All rights reserved.
//

#import "WebVC.h"
#import "NewsVC.h"
#import "Public.h"
#import "TitleView.h"
#import "TitleModel.h"
#import "NewsDetailVC.h"

@interface NewsVC ()
/** 控制器的索引 */
@property (nonatomic, assign) NSInteger indexController;

@property (nonatomic, copy) NSArray *arrTitles;
@property (nonatomic, copy) NSArray *arrTitleModels;
@property (nonatomic, copy) NSArray *arrControllers;
@property (nonatomic, weak) TitleView *titleView;

@end
@implementation NewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (NSArray *)arrTitleModels {
    if (!_arrTitleModels) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"newsTitleTag" ofType:@"plist"];
        NSArray *arrData = [NSArray arrayWithContentsOfFile:filePath];
        NSLog(@"%@",arrData);
        NSUInteger count = arrData.count;
        NSMutableArray *mArrData = [NSMutableArray arrayWithCapacity:count];
        for (NSUInteger index = 0; index < count; index++) {
            NSDictionary *dictData = arrData[index];
            TitleModel *model = [TitleModel modelWithDictionary:dictData];
            [mArrData addObject:model];
        }
        _arrTitleModels = [mArrData copy];
    }
    return _arrTitleModels;
}

- (NSArray *)arrTitles {
    if (!_arrTitles) {
        NSUInteger count = self.arrTitleModels.count;
        NSMutableArray *mArrData = [NSMutableArray arrayWithCapacity:count];
        for (NSUInteger index = 0; index < count; index++) {
            TitleModel *model = self.arrTitleModels[index];
            NSString *title = model.title;
            [mArrData addObject:title];
        }
        _arrTitles = [mArrData copy];
    }
    return _arrTitles;
}

- (void) loadDefaultSetting {
    self.title = @"新闻";
    // 加载滚动视图
    TitleView *titleView = [TitleView new];
    titleView.frame = CGRectMake(0, 0, self.view.width, buttonHidth);
    titleView.backgroundColor = [UIColor colorWithRed:0.81 green:1.00 blue:0.98 alpha:1.00];
    titleView.arrTitles = self.arrTitles;
    [self.view addSubview:titleView];
    self.titleView = titleView;
    __weak typeof(self) selfWeak = self;
    [titleView setBlkDidChooseButtonAtIndex:^(NSUInteger index){
        NSLog(@"'%@'被摸了...", selfWeak.arrTitles[index]);
        // 把index对应的控制器从_arrControllers取出来
        [selfWeak chooseViewControllerAtIndex:index];
    }];
    
    // 创建控制器数组
    NSUInteger count = self.arrTitles.count;
    NSMutableArray *arrMTemp = [NSMutableArray arrayWithCapacity:count];
    for (NSUInteger index = 0; index < count; index ++) {
        NewsDetailVC *vcDetail = [NewsDetailVC new];
        vcDetail.model = self.arrTitleModels[index];
        self.titleView.mDelegate = vcDetail;
        [arrMTemp addObject:vcDetail];
        __weak typeof(self) weakSelf = self;
        vcDetail.blockCalBack = ^(NSString *linkUrl){
            WebVC *web = [[WebVC alloc] init];
            web.linkUrl = linkUrl;
            [weakSelf.navigationController pushViewController:web animated:YES];
        };
    }
    _arrControllers = [arrMTemp copy];
    
    self.dataSource = self;
    self.delegate = self;
    
    // 设置第一个要显示的控制器
//    [self setViewControllers:@[_arrControllers.firstObject] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

- (void)chooseViewControllerAtIndex:(NSInteger)index {
    UIPageViewControllerNavigationDirection direction;
    if (index > self.indexController) {
        direction = UIPageViewControllerNavigationDirectionForward;
    } else {
        direction = UIPageViewControllerNavigationDirectionReverse;
    }
    NewsDetailVC *vcDetail = self.arrControllers[index];
    [self setViewControllers:@[vcDetail] direction:direction animated:YES completion:nil];
    self.indexController = index;
}

#pragma mark - UIPageViewControllerDataSource
// 下一个控制器
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    for (NSInteger index = 0; index < _arrControllers.count; index ++) {
        NewsDetailVC *vcDetail = _arrControllers[index];
        if (vcDetail == viewController) {
            if (index + 1 < _arrControllers.count) {
                return _arrControllers[index + 1];
            }
        }
    }
    //禁用bounce效果
    for (UIView *view in self.view.subviews ) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scroll = (UIScrollView *)view;
            scroll.bounces = NO;
        }
    }
    return nil;
}
// 上一个控制器
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    for (NSInteger index = 0; index < _arrControllers.count; index ++) {
        NewsDetailVC *vcDetail = _arrControllers[index];
        if (vcDetail == viewController) {
            if (index - 1 >= 0) {
                return _arrControllers[index - 1];
            }
        }
    }
    
    //禁用bounce效果
    for (UIView *view in self.view.subviews ) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scroll = (UIScrollView *)view;
            scroll.bounces = NO;
        }
    }

    return nil;
}

#pragma mark - UIPageViewControllerDelegate
/** 即将过度到下一个控制器的时候就会被调用, 但是最终会不会到pendingViewControllers, 不一定 */
//- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
//    NSLog(@"%@", pendingViewControllers.firstObject.title);
//}

/** 完成动画的时候调用 */
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    // 获取当前的控制器
    NewsDetailVC *vcDetailCurrent = self.viewControllers.firstObject;
    NSUInteger count = self.arrControllers.count;
    for (NSUInteger index = 0; index < count; index ++) {
        NewsDetailVC *vcTemp = self.arrControllers[index];
        if (vcTemp == vcDetailCurrent) {
            [self.titleView chooseIndex:index];
            break;
        }
    }
}


@end
