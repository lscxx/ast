//
//  FirstCell.m
//  Project
//
//  Created by qingyun3 on 16/10/9.
//  Copyright © 2016年 liuhuan. All rights reserved.
//

#import "FirstCell.h"
#import "NewsModel.h"
#import "UIImageView+WebCache.h"

@interface FirstCell ()

@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *contentCount;

@end

@implementation FirstCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *Id = @"firstcell";
    FirstCell *cell = [tableView dequeueReusableCellWithIdentifier:Id];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FirstCell" owner:nil options:nil] firstObject];
    }
    [cell setLayoutMargins:UIEdgeInsetsZero];
    [cell setSeparatorInset:UIEdgeInsetsZero];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setModel:(NewsModel *)model {
    _model = model;
    self.title.text = model.title;
    [self.picture sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]
                    placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.time.text = model.timeDesc;
    self.contentCount.text = [NSString stringWithFormat:@"%@浏览",model.contentCount];
}

@end
