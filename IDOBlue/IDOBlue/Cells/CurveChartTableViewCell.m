//
//  CurveChartTableViewCell.m
//  IDOBlue
//
//  Created by hedongyang on 2018/10/13.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "CurveChartTableViewCell.h"
#import "CurveChartCellModel.h"
#import "Masonry.h"

@interface CurveChartTableViewCell()
@property (nonatomic,strong) CurveChartCellModel * chartModel;
@end

@implementation CurveChartTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.chartView = [[CurveChartView alloc]init];
        [self addSubview: self.chartView];
        __weak typeof(self) weakSelf = self;
        [self.chartView mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong typeof(self) strongSelf = weakSelf;
             make.edges.equalTo(strongSelf);
        }];
    }
    return self;
}

- (void)setCellModel:(BaseCellModel *)model
{
    self.chartModel = (CurveChartCellModel *)model;
    if (self.chartModel.curveChartCallback) {
        self.chartModel.curveChartCallback(self.chartView);
    }
}


@end
