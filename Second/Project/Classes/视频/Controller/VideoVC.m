//
//  VideoVC.m
//  Project
//
//  Created by qingyun3 on 16/10/9.
//  Copyright © 2016年 liuhuan. All rights reserved.
//

#import "VideoVC.h"
#import "VideoDetailVC.h"

@interface VideoVC ()

@end

@implementation VideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
}

- (void) loadDefaultSetting {
    self.title = @"视频";
}

@end
