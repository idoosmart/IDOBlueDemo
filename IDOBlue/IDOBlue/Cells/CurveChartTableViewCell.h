//
//  CurveChartTableViewCell.h
//  IDOBlue
//
//  Created by hedongyang on 2018/10/13.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
#import "CurveChartView.h"

@interface CurveChartTableViewCell : BaseTableViewCell
@property (nonatomic,strong) CurveChartView * chartView;
@end
