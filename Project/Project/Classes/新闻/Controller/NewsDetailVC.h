//
//  NewsDetailVC.h
//  Project
//
//  Created by qingyun3 on 16/10/9.
//  Copyright © 2016年 liuhuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleView.h"

@class TitleModel;

@interface NewsDetailVC : UIViewController <TitleViewDelegate>

@property (nonatomic, strong) TitleModel *model;
@property (nonatomic, copy) void (^blockCalBack)(NSString *linkUrl);

@end
