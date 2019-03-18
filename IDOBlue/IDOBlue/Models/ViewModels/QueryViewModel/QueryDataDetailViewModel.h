//
//  QueryDataDetailViewModel.h
//  IDOBlue
//
//  Created by 何东阳 on 2019/3/12.
//  Copyright © 2019年 hedongyang. All rights reserved.
//

#import "BaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QueryDataDetailViewModel : BaseViewModel
/**
 * timeType 0 : 按年查询；1 : 按月查询；2 : 按周查询；3 : 按日查询；4 : 查询所有；
 */
@property (nonatomic,assign) NSInteger timeType;
/**
 * dataType 0 : 步数； 1 : 心率；2 : 血压；3 : 睡眠；4 : 血氧；5 : 压力；
 */
@property (nonatomic,assign) NSInteger dataType;
@end

NS_ASSUME_NONNULL_END
