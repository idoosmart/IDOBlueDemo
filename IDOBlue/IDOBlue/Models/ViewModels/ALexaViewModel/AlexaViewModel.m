//
//  AlexaViewModel.m
//  IDOBlue
//
//  Created by hedongyang on 2021/2/5.
//  Copyright © 2021 hedongyang. All rights reserved.
//

#import "AlexaViewModel.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "FuncViewController.h"
#import <IDOAlexa/IDOAlexa.h>

@interface AlexaViewModel ()
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation AlexaViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [IDOAlexaHongBao registerAlexa:@"gtband1_bate"];
        [self getButtonCallback];
        [self getCellModels];
    }
    return self;
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    
    FuncCellModel * model1 = [[FuncCellModel alloc]init];
    model1.typeStr = @"oneButton";
    model1.data = @[lang(@"login alexa")];
    model1.cellHeight = 70.0f;
    model1.cellClass = [OneButtonTableViewCell class];
    model1.modelClass = [NSNull class];
    model1.isShowLine = YES;
    model1.buttconCallback = self.buttconCallback;
    [cellModels addObject:model1];
    
    self.cellModels = cellModels;
}

- (void)getButtonCallback
{
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        [IDOAlexaHongBao authorizeRequestWithproductId:@"gtband1_bate" Handler:^(BOOL isLogin) {
            
        }];
    };
}


@end
