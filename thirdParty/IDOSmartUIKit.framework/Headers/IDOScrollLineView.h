//
//  IDOScrollLine2View.h
//  IDOEducation
//
//  Created by 农大浒 on 2019/12/6.
//  Copyright © 2019 TigerNong. All rights reserved.


//  创建视图的时候，请使用 initWithFrame

#import <UIKit/UIKit.h>
#import "IDOChartCommonHeader.h"
#import "IDOScrollLineViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface IDOScrollLineView : UIView

@property (nonatomic, strong) IDOScrollLineViewModel *scrollLineViewModel;

@end

NS_ASSUME_NONNULL_END
