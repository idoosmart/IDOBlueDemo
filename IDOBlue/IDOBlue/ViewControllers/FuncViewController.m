//
//  ViewController.m
//  SDKDemo
//
//  Created by hedongyang on 2018/6/6.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "FuncViewController.h"
#import "ScanViewController.h"
#import "TableViewFootView.h"
#import "FileViewModel.h"
#import "FuncViewModel.h"
#import "IDOConsoleBoard.h"
#import "Masonry.h"
#import "UIScrollView+Refresh.h"

@interface FuncViewController ()
@property (nonatomic,strong) TableViewFootView * footButton;
@end

@implementation FuncViewController

- (void)dealloc
{
    _model = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    initSyncManager().wantToSyncType = IDO_WANT_TO_SYNC_CONFIG_ITEM_TYPE | IDO_WANT_TO_SYNC_HEALTH_ITEM_TYPE
    | IDO_WANT_TO_SYNC_ACTIVITY_ITEM_TYPE | IDO_WANT_TO_SYNC_GPS_ITEM_TYPE;
    if (self.model.viewWillAppearCallback) {
        self.model.viewWillAppearCallback(self);
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.model.viewWillDisappearCallback) {
        self.model.viewWillDisappearCallback(self);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([IDOConsoleBoard borad].isShow) {
        [[IDOConsoleBoard borad] show];
    }
    if (self.model.isRightButton) [self addRightButton];
    if (self.model.isLeftButton)  [self addLeftButton];
    
    self.tableView = [[FuncTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];

    __weak typeof(self) weakSelf = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong typeof(self) strongSelf = weakSelf;
        make.edges.equalTo(strongSelf.view);
    }];
    
    if ([self.model isKindOfClass:[FuncViewModel class]]) {
        [self.tableView addHeaderRefresh];
        [self.tableView syncDataRefreshingBlock:^{
             __strong typeof(self) strongSelf = weakSelf;
             NSInteger mode = (int)[[NSUserDefaults standardUserDefaults]integerForKey:PRODUCTION_MODE_KEY];
             BOOL need_sync = [[NSUserDefaults standardUserDefaults]boolForKey:HOME_NEED_SYNC];
            if (mode != 0 || !need_sync) {
                [strongSelf.tableView endSyncDataRefresh];
                return;
            }
            initSyncManager().addSyncComplete(^(IDO_SYNC_COMPLETE_STATUS stateCode) {
                __strong typeof(self) strongSelf = weakSelf;
                if (stateCode == IDO_SYNC_GLOBAL_COMPLETE) {
                    [strongSelf showToastWithText:lang(@"sync data complete")];
                    [strongSelf.tableView endSyncDataRefresh];
                }
            }).addSyncProgess(^(IDO_CURRENT_SYNC_TYPE type, float progress) {
                __strong typeof(self) strongSelf = weakSelf;
                [strongSelf.tableView syncTitleLableStr:[NSString stringWithFormat:@"%@%.1f%@",lang(@"sync data"),progress*100.0f,@"%"]];
            }).addSyncFailed(^(int errorCode) {
                __strong typeof(self) strongSelf = weakSelf;
                [strongSelf showToastWithText:lang(@"sync data failed")];
                [strongSelf.tableView endSyncDataRefresh];
            }).mandatorySyncConfig(NO);
            if(__IDO_BIND__ && !__IDO_PAIRING__)[IDOSyncManager startSync];
        }];
    }
    
    self.tableView.model = self.model;
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,40)];
    headView.backgroundColor = [UIColor colorWithRed:236/255.0f green:236/255.0f blue:236/255.0f alpha:1.0f];
    [headView addSubview:self.statusLabel];
    [headView addSubview:self.timerLabel];
    self.tableView.tableHeaderView = headView;
    if (self.model.isFootButton)self.tableView.tableFooterView = self.footButton;
    
}

- (void)startSync
{
    [super startSync];
    NSInteger mode = (int)[[NSUserDefaults standardUserDefaults]integerForKey:PRODUCTION_MODE_KEY];
    BOOL need_sync = [[NSUserDefaults standardUserDefaults]boolForKey:HOME_NEED_SYNC];
    if (!need_sync)return;
    if(__IDO_BIND__ && !__IDO_PAIRING__ && mode == 0) {
        __weak typeof(self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            __strong typeof(self) strongSelf = weakSelf;
           [strongSelf.tableView startSyncRefreshing];
        });
    }
}

- (TableViewFootView *)footButton
{
    if (!_footButton) {
        _footButton = [[TableViewFootView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,70)];
        [_footButton.setButton addTarget:self action:@selector(footButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footButton;
}

- (void)footButtonAction:(UIButton *)sender
{
    if (self.model.footButtonCallback) {
        self.model.footButtonCallback(self);
    }
}

- (void)reloadData
{
    if (self.model.isLeftButton) {
        if (!self.navigationItem.leftBarButtonItem) {
            [self addLeftButton];
        }else {
            self.navigationItem.leftBarButtonItem.target = self.model;
            self.navigationItem.leftBarButtonItem.action = self.model.leftButton;
        }
    }else {
        self.navigationItem.leftBarButtonItem = nil;
    }
    
    if (self.model.isRightButton){
        if (!self.navigationItem.rightBarButtonItem) {
            [self addRightButton];
        }else {
            self.navigationItem.rightBarButtonItem.target = self.model;
            self.navigationItem.rightBarButtonItem.action = self.model.rightButton;
        }
    }else {
        self.navigationItem.rightBarButtonItem = nil;
    }
    self.tableView.model = self.model;
    [self.tableView reloadData];
}

- (void)addLeftButton
{
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc] initWithTitle:self.model.leftButtonTitle
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:self.model
                                                                       action:self.model.leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
}


- (void)addRightButton
{
    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:self.model.rightButtonTitle
                                                                         style:UIBarButtonItemStylePlain
                                                                        target:self.model
                                                                        action:self.model.rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

@end
