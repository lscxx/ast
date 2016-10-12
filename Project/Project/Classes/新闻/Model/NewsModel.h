//
//  NewsModel.h
//  Project
//
//  Created by qingyun3 on 16/10/9.
//  Copyright © 2016年 liuhuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

/** type */
@property (nonatomic, copy) NSString *type;

/** title */
@property (nonatomic, copy) NSString *title;

/** linkUrl */
@property (nonatomic, copy) NSString *linkUrl;

/** imageUrl */
@property (nonatomic, copy) NSString *imageUrl;

/** imageUrls */
@property (nonatomic, copy) NSArray *imageUrls;

/** contentCount */
@property (nonatomic, copy) NSString *contentCount;

/** timeDesc */
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *timeDesc;

/** totalPage */
@property (nonatomic, assign) NSInteger totalPage;

+ (instancetype) modelWithDictionary:(NSDictionary *)dict;
- (instancetype) initWithDictionary:(NSDictionary *)dict;

@end
