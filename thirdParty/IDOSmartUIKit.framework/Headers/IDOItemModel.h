//
//  IDOItemModel.h
//  IDOSmartUIKit
//
//  Created by 农大浒 on 2020/5/22.
//  Copyright © 2020 农大浒. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger, IDOItemModelImagePositionType) {
    IDOItemModelImagePositionTypeTop,    //图片在上，标题在下
    IDOItemModelImagePositionTypeBottom  //图片在下，标题在上
};

@interface IDOItemModel : NSObject

/**
 图片
 */
@property (nonatomic, strong) UIImage *image;

/**
 标题，如果存在有标题，则默认标题的高度是20
 */
@property (nonatomic, copy) NSString *title;


/**
 图片和标题的位置
 */

@property (nonatomic, assign) IDOItemModelImagePositionType imagePositionType;



@end

NS_ASSUME_NONNULL_END
