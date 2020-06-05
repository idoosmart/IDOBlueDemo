//
//  IDOAsyncLayer.h
//  TextLayoutDemo
//
//  Created by 宫城 on 16/6/27.
//  Copyright © 2016年 宫城. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@class IDOAsyncLayerDisplayTask;

NS_ASSUME_NONNULL_BEGIN

/**
 The IDOAsyncLayer class is a subclass of CALayer used for render contents asynchronously.
 
 @discussion When the layer need update it's contents, it will ask the delegate
 for a async display task to render the contents in a background queue.
 */
@interface IDOAsyncLayer : CALayer
/// Whether the render code is executed in background. Default is YES.
@property BOOL displaysAsynchronously;
/// Returns the current value of the counter.
@property int32_t value;
@end


/**
 The IDOAsyncLayer's delegate protocol. The delegate of the IDOAsyncLayer (typically a UIView)
 must implements the method in this protocol.
 */
@protocol IDOAsyncLayerDelegate <NSObject>
@required
/// This method is called to return a new display task when the layer's contents need update.
- (IDOAsyncLayerDisplayTask *)newAsyncDisplayTask;
@end


/**
 A display task used by IDOAsyncLayer to render the contents in background queue.
 */
@interface IDOAsyncLayerDisplayTask : NSObject

/**
 This block will be called before the asynchronous drawing begins.
 It will be called on the main thread.
 
 @param layer  The layer.
 */
@property (nullable, nonatomic, copy) void (^willDisplay)(CALayer *layer);

/**
 This block is called to draw the layer's contents.
 
 @discussion This block may be called on main thread or background thread,
 so is should be thread-safe.
 
 @param context      A new bitmap content created by layer.
 @param size         The content size (typically same as layer's bound size).
 @param isCancelled  If this block returns `YES`, the method should cancel the
 drawing process and return as quickly as possible.
 */
@property (nullable, nonatomic, copy) void (^display)(CGContextRef context, CGSize size, BOOL(^isCancelled)(void));

/**
 This block will be called after the asynchronous drawing finished.
 It will be called on the main thread.
 
 @param layer  The layer.
 @param finished  If the draw process is cancelled, it's `NO`, otherwise it's `YES`;
 */
@property (nullable, nonatomic, copy) void (^didDisplay)(CALayer *layer, BOOL finished);

@end

NS_ASSUME_NONNULL_END
