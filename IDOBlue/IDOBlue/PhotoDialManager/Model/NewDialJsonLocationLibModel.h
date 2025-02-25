//
//  NewDialJsonLocationLibModel.h
//  IDOBlue
//
//  Created by cyf on 2025/2/25.
//  Copyright © 2025 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NewDialJsonFunctionCoordinateLibModel;
@class DialJsonTimeWidgetLibModel;

NS_ASSUME_NONNULL_BEGIN


@interface NewDialJsonLocationLibModel: NSObject

//3右上
@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) CGRect time;

@property (nonatomic, assign) CGRect day;

@property (nonatomic, assign) CGRect week;

///功能
@property (nonatomic, assign) CGRect func;

///功能
@property (nonatomic, strong)NSArray<NewDialJsonFunctionCoordinateLibModel*> *function_coordinate;

@property (nonatomic, strong)NSArray<DialJsonTimeWidgetLibModel*> *time_widget;


@end


NS_ASSUME_NONNULL_END
