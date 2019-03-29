//
//  BaseCellModel.h
//  IDOBluetoothDemo
//
//  Created by apple on 2018/9/15.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseCellModel : NSObject
@property (nonatomic,strong) Class modelClass;
@property (nonatomic,strong) Class cellClass;
@property (nonatomic,strong) NSArray * data;
@property (nonatomic,copy)   NSString * typeStr;
@property (nonatomic,assign) CGFloat cellHeight;
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,assign) BOOL isShowLine;
@property (nonatomic,assign) BOOL isDelete;
@property (nonatomic,assign) BOOL isMoveRow;
@end
