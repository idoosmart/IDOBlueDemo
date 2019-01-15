//
//  BaseChartView.h
//  IDOBlue
//
//  Created by hedongyang on 2018/10/11.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface curveChartView : UIView
@property (nonatomic,assign) CGFloat gap;
@property (nonatomic,copy)   NSString * target;
@property (nonatomic,strong) NSArray  * values;
@property (nonatomic,strong) NSArray  * titles;
@end
