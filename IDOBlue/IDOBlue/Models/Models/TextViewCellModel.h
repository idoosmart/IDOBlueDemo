//
//  UpdateCellModel.h
//  IDOBluetoothDemo
//
//  Created by hedongyang on 2018/9/17.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "BaseCellModel.h"

@interface TextViewCellModel : BaseCellModel
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@end
