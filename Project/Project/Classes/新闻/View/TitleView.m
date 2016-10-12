//
//  ItemView.m
//  Project
//
//  Created by qingyun3 on 16/10/9.
//  Copyright © 2016年 liuhuan. All rights reserved.
//

#import "TitleView.h"
#import "Public.h"

@interface TitleView ()

@property (nonatomic, weak) UIView *slider;

@end

@implementation TitleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self loadUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self loadUI];
    }
    return self;
}

- (void)loadUI {
    self.bounces = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.backgroundColor = [UIColor whiteColor];
}

- (void)setArrTitles:(NSArray *)arrTitles {
    _arrTitles = [arrTitles copy];
    
    NSUInteger count = arrTitles.count;
    for (NSUInteger index = 0; index < count; index ++) {
        UIButton *btnItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnItem setTitle:arrTitles[index] forState:UIControlStateNormal];
        [btnItem setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btnItem setTitleColor:[UIColor colorWithRed:0.35 green:0.67 blue:0.89 alpha:1.00] forState:UIControlStateDisabled];
        [btnItem addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchDown];
        [btnItem setFrame:CGRectMake(index * buttonWidth, 0, buttonWidth, buttonHidth)];
        btnItem.tag = index + 100;
        [self addSubview:btnItem];
    }
    
    [self setContentSize:CGSizeMake(count * buttonWidth, 1)];
    
    //加载滚动条
    UIView *slider = [[UIView alloc] initWithFrame:CGRectMake(0, buttonHidth-2, buttonWidth, 2)];
    slider.backgroundColor = [UIColor colorWithRed:0.35 green:0.67 blue:0.89 alpha:1.00];
    self.slider = slider;
    [self addSubview:slider];
}

- (void)chooseAction:(UIButton *)button {
    // 把所有的UIButton置为未选中
    for (UIButton *btn in self.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            btn.enabled = YES;
        }
    }
    // 选中用户选中的按钮, 如果contentSize的大小有一个为0, 这个方法就不起作用
    button.enabled = NO;
    
    //滚动条
    NSInteger index = button.tag - 100;
    [UIView animateWithDuration:0.1 animations:^{
        self.slider.frame = CGRectMake(index * button.width, self.height-2, button.width, 2);
    }];
    
    // 让指定的区域可见
    [self scrollRectToVisible:button.frame animated:YES];
    
    // 回调Block
    if (self.blkDidChooseButtonAtIndex) {
        self.blkDidChooseButtonAtIndex(button.tag - 100);
    }
    
    //通知Delegate
    if ([self.mDelegate respondsToSelector:@selector(selectTitleViewAtIndex:)]) {
        [self.mDelegate selectTitleViewAtIndex:index];
    }
}

- (void)chooseIndex:(NSInteger)indexChoosed {
    NSUInteger count = self.arrTitles.count;
    for (NSUInteger index = 0; index < count; index ++) {
        UIButton *btnItem = self.subviews[index];
        if ([btnItem isKindOfClass:[UIButton class]] && btnItem.tag == indexChoosed +100) {
            [self chooseAction:btnItem];
            break;
        }
    }
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    BOOL isMove;
    if (isMove) {
        NSUInteger count = self.arrTitles.count;
        for (NSUInteger index = 0; index < count; index ++) {
            UIButton *btnItem = self.subviews[index];
            if ([btnItem isKindOfClass:[UIButton class]] && btnItem.tag == 0 + 100) {
                [self chooseAction:btnItem];
                break;
            }
        }
        isMove = NO;
    }
}

@end
