//
//  SetMenuView.h
//  IDOBlue
//
//  Created by 何东阳 on 2019/8/17.
//  Copyright © 2019 hedongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SetMenuView : UIView
@property (nonatomic,strong) NSArray * listArray;
@property (nonatomic,copy)void(^selectMenuList)(NSInteger index);
@property (nonatomic,assign) BOOL isLeftType;
- (void)reloadData;
@end

NS_ASSUME_NONNULL_END
