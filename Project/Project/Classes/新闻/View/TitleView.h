//
//  ItemView.h
//  Project
//
//  Created by qingyun3 on 16/10/9.
//  Copyright © 2016年 liuhuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TitleViewDelegate <NSObject>

@optional
- (void) selectTitleViewAtIndex:(NSInteger)index;

@end

@interface TitleView : UIScrollView

/** 按钮点击事件的Block */
@property (nonatomic, copy) void (^blkDidChooseButtonAtIndex)(NSUInteger index);

/** 所有的按钮去标题 */
@property (nonatomic, copy) NSArray *arrTitles;

/** Delegate */
@property (nonatomic, weak) id<TitleViewDelegate> mDelegate;

/** 选中指定index的Button */
- (void)chooseIndex:(NSInteger)index;

@end
