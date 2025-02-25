//
//  NewDialJsonStylesFuncsLibModel.h
//  IDOBlue
//
//  Created by cyf on 2025/2/24.
//  Copyright © 2025 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface NewDialJsonStylesFuncsLibModel: NSObject

@property (nonatomic, assign) BOOL isClose;//是否关闭显示

@property (nonatomic,   copy) NSString *funcType;//类型

@property (nonatomic,   copy) NSString *funcIcon;//图标



@property (nonatomic, assign) CGRect location;//图标的位置

@property (nonatomic, assign) CGFloat cornerRadius;//圆角大小

//是否修改内容， 如果为YES，把功能名写入到固件的表盘文件中
@property (nonatomic, assign) BOOL modifyContent;

@property (nonatomic,   copy) NSString *contentStr;//如果显示文字时的内容

@end

NS_ASSUME_NONNULL_END
