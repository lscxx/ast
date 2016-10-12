//
//  WebVC.m
//  Project
//
//  Created by qingyun3 on 16/10/11.
//  Copyright © 2016年 liuhuan. All rights reserved.
//

#import "WebVC.h"

@interface WebVC ()<UIWebViewDelegate>
@property (nonatomic, weak) UIWebView *webView;
@end

@implementation WebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", self.linkUrl);
    self.title = @"新闻详情";
    NSURL *url = [NSURL URLWithString:self.linkUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -44, self.view.width, self.view.height)];
    self.webView = webView;
    self.webView.delegate = self;
    webView.scrollView.bounces = NO;
    [self.view addSubview:webView];
    [webView loadRequest:request];
}

#pragma mark UIWebViewDelegate

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('wrap')[0].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('gg01 pbytgg')[0].style.display = 'none'"];
    webView.frame = self.view.bounds;
}

@end
