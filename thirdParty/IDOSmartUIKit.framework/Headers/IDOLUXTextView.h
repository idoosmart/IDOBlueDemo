//
//  IDOLUXTextView.h
//  IDOUIKit
//
//  Created by 鲁鲁骁 on 2019/12/3.
//  Copyright © 2019 Mobile emergency. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDOLUXTextView : UIView

@property (nonatomic , strong)UITextView *textView;

/**< 设置占位符 */
@property (nonatomic , copy)NSString *placeholder;
/**< 自定义占位符 */
@property (nonatomic , strong)UILabel *labelPlaceholder;

/**< 限制个数 */
@property (nonatomic , assign)NSInteger limitNumber;
/**< 自定义限制个数 */
@property (nonatomic , strong)UILabel *labelLimit;

@end

NS_ASSUME_NONNULL_END
