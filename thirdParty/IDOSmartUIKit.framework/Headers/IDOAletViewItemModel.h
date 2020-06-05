//
//  IDOAletViewItemModel.h
//  IDOEducation
//
//  Created by TigerNong on 2019/11/15.
//  Copyright © 2019 TigerNong. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface IDOAletViewItemModel : NSObject 
//主标题
@property (nonatomic, copy) NSString *title;

//子标题
@property (nonatomic, copy) NSString *subTitle;

//右侧按钮显示的正常图片（如果是删除的话，请使用这个）
@property (nonatomic, copy) NSString *rightButtonNormalImage;

//右侧按钮显示的选中的图片
@property (nonatomic, copy) NSString *rightButtonSelectImage;

//这个参数只有在 type IDOAlertViewItemRightViewTypeSingleSelected
//和 IDOAlertViewItemRightViewTypeMultipleSelected 的时候才游泳
@property (nonatomic, assign) BOOL selected;


@end

NS_ASSUME_NONNULL_END
