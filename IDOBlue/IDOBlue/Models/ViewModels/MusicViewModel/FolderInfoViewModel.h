//
//  FolderInfoViewModel.h
//  IDOBlue
//
//  Created by huangkunhe on 2021/9/27.
//  Copyright © 2021 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FolderInfoViewModel : BaseViewModel

@property (nonatomic,strong,nullable) IDOMusicDirectoryModel * musicDirectoryModel;
@property (nonatomic,copy) void(^addMusicDirectoryItemModelmComplete)(BOOL isSuccess,IDOMusicDirectoryModel* itemModel);

@end

NS_ASSUME_NONNULL_END
