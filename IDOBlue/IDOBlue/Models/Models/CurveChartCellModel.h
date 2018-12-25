//
//  CurveChartCellModel.h
//  IDOBlue
//
//  Created by 何东阳 on 2018/10/15.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "BaseCellModel.h"
#import "CurveChartView.h"

@interface CurveChartCellModel : BaseCellModel
@property (nonatomic,copy)void(^curveChartCallback)(CurveChartView * chartView);
@end
