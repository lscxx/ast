//
//  NewsModel.m
//  Project
//
//  Created by qingyun3 on 16/10/9.
//  Copyright © 2016年 liuhuan. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dict {
    
    NewsModel *model = nil;
    
    if (dict != nil && [dict isKindOfClass:[NSDictionary class]]) {
        
        model = [[[self class] alloc] initWithDictionary:dict];
    }
    
    return model;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    
    if (self = [super init]) {
        
        self.type = dict[@"type"];
        self.title = dict[@"title"];
        self.imageUrl = dict[@"thumbnail"];
        self.linkUrl = dict[@"commentsUrl"];
        self.contentCount = dict[@"commentsall"];
        self.imageUrls = dict[@"style"][@"images"];
        self.totalPage = [dict[@"totalPage"] integerValue];
        
        NSDate *date = [NSDate dateWithString:dict[@"updateTime"]];
        self.timeDesc = [NSString stringWithDate:date];
    }
    
    return self;
}

@end
