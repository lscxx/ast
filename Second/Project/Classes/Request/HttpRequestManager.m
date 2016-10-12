//
//  HttpRequestManager.m
//  资讯快车
//
//  Created by qingyun on 16/8/2.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "HttpRequestManager.h"
#import "HttpRequest.h"
#import "NewsModel.h"

@interface HttpRequestManager ()

@end

@implementation HttpRequestManager

//线程安全的方式创建单例
+ (instancetype)shareHttpRequestManager {
    static HttpRequestManager *httpRequestManager;
    static dispatch_once_t onceHttpRequestManager;
    __weak typeof(self) weakSelf = self;
    dispatch_once(&onceHttpRequestManager, ^{
        httpRequestManager = [[[weakSelf class] alloc] init];
    });
    return httpRequestManager;
}

- (void)request_list_data_title_url:(NSString *)url
                               page:(NSInteger)page
                             success:(void (^)(id))success
                             failure:(void (^)(NSError *))failure {
    NSString *Url = [NSString
                     stringWithFormat:@"%@&page=%ld",url,page];
    [[HttpRequest shareHttpRequest] Get:Url Param:nil Success:^(id responseData) {
        NSArray *arrModel;
        NSMutableArray *mArrTemp = [NSMutableArray array];
        for (NSDictionary *dictData in (NSArray *)responseData) {
            NSArray *arrTemp = dictData[@"item"];
            for (NSDictionary *dictTemp in arrTemp) {
                NewsModel *model = [NewsModel modelWithDictionary:dictTemp];
                if ([model.type isEqualToString:@"doc"] ) {
                    [mArrTemp addObject:model];
                }
            }
        }
        arrModel = [mArrTemp copy];
        success(arrModel);
//        NSLog(@"%@",responseData);
    } Failure:^(NSError *error) {
        
        NSLog(@"%@", error);
    }];
}

@end
