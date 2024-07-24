//
//  IDOSleepManagerVC.h
//  IDOVFLogin
//
//  Created by Warp on 2022/1/12.
//

//h5需要数据
//
//主题色、语言（en，cn，法语语言 ）
//appKey，token
//音乐播放、暂停、 定时、音乐数据
//周报分享
//app通知h5终止计划(用户通过设备更新数据)
//app通知h5数据更新(用户通过设备更新数据)
//
//1.获取用户信息 getUserInfoAPP
//
//language 语言
//color 主题色无的话传0,有的话传色值的字符串
//token
//appKey
//2.app通知h5终止计划 sendNotification
//
//message 传'stopPlan'表示停止计划；传'update'表示更新数据；传''表示不做任何操作
//3.周报分享 val – base64格式的图片信息 sendImageMessage
//
//sendImageMessage 传'val'里面是base64的数据
//4.音乐播放 playMusic
//
//name -- 音乐名称
//url -- 音乐地址
//open -- 传0表示暂停，传1表示播放
//timing -- 定时 分钟 例如 0 ， 30 ， 60， 90（一小时30分）
#import "IDOWebViewVC.h"
#import "WebViewJavascriptBridge.h"

#define kUpdateSleepScheduleNoticeKey       @"kUpdateSleepScheduleNoticeKey"

NS_ASSUME_NONNULL_BEGIN

@interface IDOSleepManagerVC : IDOWebViewVC

@property WebViewJavascriptBridge* bridge;

/**
 是否使用新的分享 userNewShare = yes 的情况，会把图片分享到外面，通过shareImageBlock
 */
@property (nonatomic,assign) BOOL userNewShare;

///向H5传参
- (void)callHandler:(NSString *)handlerName data:(id)data;

///响应H5的方法
- (void)registerHandler:(NSString*)handlerName handler:(WVJBHandler)handler;

/**
 h5通知原生的回调
 */
@property (nonatomic,strong) void (^h5NotiActivityBlock)(id data);

/**
 h5分享图片到原生
 */
@property (nonatomic,strong) void (^shareImageBlock)(UIImage *dataImage);

@end

NS_ASSUME_NONNULL_END
