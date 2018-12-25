//
//  SliderCellModel.h
//  IDOBlue
//
//  Created by 何东阳 on 2018/11/14.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "BaseCellModel.h"

@interface SliderCellModel : BaseCellModel
@property (nonatomic,copy)void(^sliderCallback)(UIViewController * viewController,UISlider * slider,UITableViewCell * tableViewCell);
@end
