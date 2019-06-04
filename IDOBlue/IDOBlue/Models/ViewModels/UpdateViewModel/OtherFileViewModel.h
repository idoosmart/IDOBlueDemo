//
//  OtherFileViewModel.h
//  IDOBlue
//
//  Created by 何东阳 on 2019/6/3.
//  Copyright © 2019 hedongyang. All rights reserved.
//

#import "BaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OtherFileViewModel : BaseViewModel
@property (nonatomic,assign) NSInteger type;
@property (nonatomic,copy) NSString * dirPath;
@property (nonatomic,copy) void(^selectFileCallback)(NSString * filePath);
@end

NS_ASSUME_NONNULL_END
