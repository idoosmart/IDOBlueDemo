//
//  UIButton+EdegInset.h
//  IDOUIkit
//
//  Created by TigerNong on 2019/11/8.
//  Copyright © 2019 hedongyang. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, IDOImagePositionType) {
    IDOImagePositionTypeLeft,   //图片在左，标题在右，默认风格
    IDOImagePositionTypeRight,  //图片在右，标题在左
    IDOImagePositionTypeTop,    //图片在上，标题在下
    IDOImagePositionTypeBottom  //图片在下，标题在上
};

typedef NS_ENUM(NSInteger, IDOEdgeInsetsType) {
    IDOEdgeInsetsTypeTitle,//标题
    IDOEdgeInsetsTypeImage//图片
};

typedef NS_ENUM(NSInteger, IDOMarginType) {
    IDOMarginTypeTop         ,
    IDOMarginTypeBottom      ,
    IDOMarginTypeLeft        ,
    IDOMarginTypeRight       ,
    IDOMarginTypeTopLeft     ,
    IDOMarginTypeTopRight    ,
    IDOMarginTypeBottomLeft  ,
    IDOMarginTypeBottomRight
};


NS_ASSUME_NONNULL_BEGIN

@interface UIButton (EdegInset)

/**
 *  利用UIButton的titleEdgeInsets和imageEdgeInsets来实现图片和标题的自由排布
 *  注意：1.该方法需在设置图片和标题之后才调用;
         2.图片和标题改变后需再次调用以重新计算titleEdgeInsets和imageEdgeInsets
 *
 *  @param type    图片位置类型
 *  @param spacing 图片和标题之间的间隙
 */
- (void)setImagePositionWithType:(IDOImagePositionType)type spacing:(CGFloat)spacing;

/**
 *  按钮只设置了title or image，该方法可以改变它们的位置
 *
 *  @param edgeInsetsType <#edgeInsetsType description#>
 *  @param marginType     <#marginType description#>
 *  @param margin         <#margin description#>
 */
- (void)setEdgeInsetsWithType:(IDOEdgeInsetsType)edgeInsetsType marginType:(IDOMarginType)marginType margin:(CGFloat)margin;



/**
 *  图片在上，标题在下
 *
 *  @param spacing image 和 title 之间的间隙
 */
- (void)setImageUpTitleDownWithSpacing:(CGFloat)spacing __deprecated_msg("Method deprecated. Use `setImagePositionWithType:spacing:`");

/**
 *  图片在右，标题在左
 *
 *  @param spacing image 和 title 之间的间隙
 */
- (void)setImageRightTitleLeftWithSpacing:(CGFloat)spacing __deprecated_msg("Method deprecated. Use `setImagePositionWithType:spacing:`");

@end

NS_ASSUME_NONNULL_END
