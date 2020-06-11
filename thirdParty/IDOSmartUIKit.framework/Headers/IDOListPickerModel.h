//
//  IDOListPickerModel.h
//  IDOSmartUIKit
//
//  Created by 农大浒 on 2020/5/6.
//  Copyright © 2020 农大浒. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDOListPickerModel : NSObject

/**
 主标题文字
 */
@property (nonatomic, copy) NSString *text;

/**
 子标题
 */
@property (nonatomic, copy) NSString *detailText;

/**
 右侧的选中时图片
 */
@property (nonatomic, strong) UIImage *rightSelectedIconImage;

/**
 右侧没有选中时的图片
 */
@property (nonatomic, strong) UIImage *rightNormalIconImage;


/**
 是否选中
 */
@property (nonatomic, assign) BOOL selected;


@end

NS_ASSUME_NONNULL_END
