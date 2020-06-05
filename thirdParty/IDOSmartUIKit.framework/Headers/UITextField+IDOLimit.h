//
//  UITextField+IDOLimit.h
//  mianApp
//
//  Created by 汪大丸子 on 2019/11/27.
//  Copyright © 2019年 Mobile emergency. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, IDOLUXTextFieldType) {
    IDOLUXTextFieldTypeDefult,             /**< 无规则 */
    IDOLUXTextFieldTypeNumberOnly,         /**< 只能输入数字 */
    IDOLUXTextFieldTypeChineseOnly,        /**< 只能输入中文 */
    IDOLUXTextFieldTypeEnglishOnly,        /**< 只能输入英文 */
    IDOLUXTextFieldTypeEnglishChineseOnly,        /**< 只能输入英文中文 */
    IDOLUXTextFieldTypeEnglishNumberOnly,        /**< 只能输入英文数字 */
};
NS_ASSUME_NONNULL_BEGIN

@interface UITextField (IDOLimit)

/**
 *  类型 默认defult
 */
@property (nonatomic, assign) IDOLUXTextFieldType IDOFieldType;

/**
 *  限制输入位数
 */
@property (nonatomic, assign) NSInteger limitMax;

/**
 *  valuechange blcok
 */
@property (nonatomic , copy) void(^textValueChangeBlcok)(void);
@end

NS_ASSUME_NONNULL_END
