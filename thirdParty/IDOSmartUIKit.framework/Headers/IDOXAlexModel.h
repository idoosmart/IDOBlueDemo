//
//  IDOXAlexModel.h
//  IDOEducation
//
//  Created by TigerNong on 2019/11/23.
//  Copyright © 2019 TigerNong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDOXAlexModel : NSObject

//是在那个点显示x轴对应的数值
@property (nonatomic, assign) NSInteger index;

//x轴显示的内容
@property (nonatomic, copy) NSString *xValue;

@end

NS_ASSUME_NONNULL_END
