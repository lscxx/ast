//
//  WebVC.m
//  Project
//
//  Created by qingyun3 on 16/10/11.
//  Copyright © 2016年 liuhuan. All rights reserved.
//

#import "WebVC.h"

@interface WebVC ()

@end

@implementation WebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新闻详情";
    NSURL *url = [NSURL URLWithString:self.linkUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -44, self.view.width, self.view.height)];
    webView.scrollView.bounces = NO;
    [self.view addSubview:webView];
    [webView loadRequest:request];
}

@end
