//
//  PlistModel.m
//  Project
//
//  Created by qingyun3 on 16/10/10.
//  Copyright © 2016年 liuhuan. All rights reserved.
//

#import "TitleModel.h"

@implementation TitleModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dict {
    
    TitleModel *model = nil;
    
    if (dict != nil && [dict isKindOfClass:[NSDictionary class]]) {
        
        model = [[[self class] alloc] initWithDictionary:dict];
    }
    
    return model;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    
    if (self = [super init]) {
        
        self.url = dict[@"newsPlistName"];
        
        self.title = dict[@"newsTitle"];
        
    }
    
    return self;
}

@end
