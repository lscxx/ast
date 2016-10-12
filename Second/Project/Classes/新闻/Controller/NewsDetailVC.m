 //
//  NewsDetailVC.m
//  Project
//
//  Created by qingyun3 on 16/10/9.
//  Copyright © 2016年 liuhuan. All rights reserved.
//

#import "NewsDetailVC.h"
#import "Public.h"
#import "FirstCell.h"
#import "NewsModel.h"
#import "TitleModel.h"
#import "HttpRequestManager.h"
#import "MJRefresh.h"

@interface NewsDetailVC ()<UITableViewDataSource, UITableViewDelegate>
{
    BOOL _isRefresh;
}
@property (nonatomic, strong) NSMutableArray *mArrModels;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, weak) UITableView *tableView;

@end

@implementation NewsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.tableView.mj_header beginRefreshing];
}

- (NSMutableArray *)mArrModels {
    if (!_mArrModels) {
        _mArrModels = [NSMutableArray array];
    }
    return _mArrModels;
}

- (void) loadDefaultSetting {
    _isRefresh = YES;
    self.currentPage = 1;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, buttonHidth, self.view.width, self.view.height - buttonHidth) style:UITableViewStylePlain];
        _tableView = tableView;
        [self.view addSubview:_tableView];
        _tableView.estimatedRowHeight = 80;
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
        self.tableView = _tableView;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        __weak typeof(self) weakSelf = self;
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf request_list_data_title_url:_model.url page:self.currentPage];
            [weakSelf.tableView.mj_header endRefreshing];
        }];
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            self.currentPage++;
            [weakSelf request_list_data_title_url:_model.url page:weakSelf.currentPage];
            [weakSelf.tableView.mj_footer endRefreshing];
        }];
    }
    return _tableView;
}

//刷新数据
- (void)request_list_data_title_url:(NSString *)url
                               page:(NSInteger)page{
    
    HttpRequestManager *manager = [HttpRequestManager shareHttpRequestManager];
    __weak typeof(self) weakSelf = self;
    [manager request_list_data_title_url:url
                                    page:page
                                 success:^(id responseData) {
                                     [weakSelf.mArrModels addObjectsFromArray:(NSArray *)responseData];
                                     [weakSelf.tableView reloadData];
                                 }
                                 failure:^(NSError *error) {
                                     NSLog(@"%@", error);
                                 }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.mArrModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsModel *model = self.mArrModels[indexPath.row];
    if ([model.type isEqualToString:@"doc"]) {
        FirstCell *cell = [FirstCell cellWithTableView:tableView];
        cell.model = model;
        return cell;
    }
    return nil;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *linkUrl = [self.mArrModels[indexPath.row] linkUrl];
    if (_blockCalBack) {
        _blockCalBack(linkUrl);
    }
}

@end
