//
//  AuthTextFieldView.h
//  IDOBlue
//
//  Created by 何东阳 on 2018/10/18.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AuthTextFieldViewDelegate<NSObject>

- (void)cancelButton;

- (void)authBindingWithCode:(NSString *)codeStr;

@end

@interface AuthTextFieldView : UIView
@property (nonatomic,assign) id<AuthTextFieldViewDelegate> delegate;
- (void)show;
@end
