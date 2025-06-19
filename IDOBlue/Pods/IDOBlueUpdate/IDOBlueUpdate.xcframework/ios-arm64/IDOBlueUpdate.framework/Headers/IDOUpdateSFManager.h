//
//  IDOUpdateSFManager.h
//  IDOBlueUpdate
//
//  Created by chenhuili on 2023/11/22.
//  Copyright © 2023 何东阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDOUpdateEnum.h"

typedef NS_ENUM(NSUInteger, SiFliEBinBoardType) {//主板芯片类型
    SiFliEBinBoardType_55X,
    SiFliEBinBoardType_56X,
    SiFliEBinBoardType_52X,
};

NS_ASSUME_NONNULL_BEGIN

@interface IDOUpdateSFManager : NSObject

/// 将png格式文件序列转为ezipBin类型。转换失败返回nil。V2.2
/// @param pngDatas png文件数据序列数组 （如果数组是多张图片，则会几张图片组合拼接成一张图片）
/// @param eColor 颜色字符串 color type as below: rgb565, rgb565A, rbg888, rgb888A
/// @param eType eizp类型 0 keep original alpha channel;1 no alpha chanel
/// @param binType bin类型 0 to support rotation; 1 for no rotation
/// @param boardType 主板芯片类型 @See SFBoardType 0:55x 1:56x  2:52x
/// @return ezip or apng result, nil for fail
+(nullable NSData *)siFliEBinFromPngSequence:(NSArray<NSData *> *)pngDatas
                               eColor:(NSString *)eColor
                                eType:(uint8_t)eType
                              binType:(uint8_t)binType
                                   boardType:(SiFliEBinBoardType)boardType;
@end

NS_ASSUME_NONNULL_END
