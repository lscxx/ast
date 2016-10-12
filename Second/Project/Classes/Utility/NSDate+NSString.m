//
//  NSDate+NSString.m
//  Project
//
//  Created by qingyun3 on 16/10/10.
//  Copyright © 2016年 liuhuan. All rights reserved.
//

#import "NSDate+NSString.h"

@implementation NSDate (NSString)

+ (NSDate *)dateWithString:(NSString *)paramDate {
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formater dateFromString:paramDate];
    return date;
}

@end
