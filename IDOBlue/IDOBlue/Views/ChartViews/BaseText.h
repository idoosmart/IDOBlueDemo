//
//  BaseText.h
//  IDOBlue
//
//  Created by apple on 2018/10/12.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseText : UIView
@property (nonatomic,copy)   NSString * titleStr;
@property (nonatomic,assign) CGFloat fontSize;
- (void)drawText;
@end
