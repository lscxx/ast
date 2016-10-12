//
//  FirstCell.h
//  Project
//
//  Created by qingyun3 on 16/10/9.
//  Copyright © 2016年 liuhuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsModel;

@interface FirstCell : UITableViewCell

@property (nonatomic, strong) NewsModel *model;

+ (instancetype) cellWithTableView:(UITableView *)tableView;

@end
