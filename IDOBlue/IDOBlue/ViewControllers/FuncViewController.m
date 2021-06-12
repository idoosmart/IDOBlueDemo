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
        
    if (self.model.isRightButton) [self addRightButton];
    if (self.model.isLeftButton)  [self addLeftButton];
        
    self.tableView = [[FuncTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];

        __weak typeof(self) weakSelf = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong typeof(self) strongSelf = weakSelf;
        make.edges.equalTo(strongSelf.view);
    }];
    
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
