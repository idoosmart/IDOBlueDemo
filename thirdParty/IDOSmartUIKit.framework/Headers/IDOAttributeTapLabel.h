//
//  IDOAttributeTapLabel.h
//  DHLogin
//  可点击的文字
//  Created by cq on 2019/4/13.
//  Copyright © 2019 cq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^IDOAttributeTapLabelTapBlock)(NSString * string);

@interface IDOAttributeModel : NSObject

@property (nonatomic, copy) NSString    * string;   //高亮字符串

@property (nonatomic, strong) UIImage   * alertImg; //高粱字符串后跟提示图片

/**
 如果后面跟有图片，则rang的length+1,下一个可点击的字符串的location+1
 */
@property (nonatomic, assign) NSRange   range;      //字符串位置

@property (nonatomic, strong) NSDictionary  * attributeDic; //富文本颜色字体等配置

@end

@interface IDOAttributeTapLabel : UILabel

@property (nonatomic, copy) IDOAttributeTapLabelTapBlock tapBlock;   //目标点击回调

/**
 设置文本
 
 @param text 文本内容
 @param attr 富文本样式 （样式中务必设置字体，若使用系统默认字体可能导致点击无响应或者响应混乱）
 @param stringArray 需要处理点击的文本
 */
- (void)setText:(NSString *)text attributes:(NSDictionary *)attr tapStringArray:(NSArray <IDOAttributeModel *>*)stringArray;

@end

NS_ASSUME_NONNULL_END
