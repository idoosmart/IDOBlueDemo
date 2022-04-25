//
//  SetFuncViewController.m
//  SDKDemo
//
//  Created by apple on 2018/6/18.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "SetFuncViewController.h"


@interface SetFuncViewController ()
@end

@implementation SetFuncViewController

- (void)dealloc
{
  
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.model.viewWillAppearCallback) {
        self.model.viewWillAppearCallback(self,self.tableView);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pickerView = [[BasePickerView alloc]init];
    [self.view addSubview:self.pickerView];
    
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(self.view.mas_bottom);
        make.height.equalTo(@216);
    }];
    
    self.datePickerView = [[BaseDatePickerView alloc]init];
    [self.view addSubview:self.datePickerView];
    
    [self.datePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(self.view.mas_bottom);
        make.height.equalTo(@216);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
