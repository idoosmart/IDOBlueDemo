//
//  IDOAlexaHongBao.h
//  IDOAlexa
//
//  Created by 鲁鲁骁 on 2021/2/4.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <IDOBlueProtocol/IDOBlueProtocol.h>
#import <IDOAlexaClient/IDOAlexaEnum.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDOAlexaManager : NSObject
#pragma mark - required
/**< 注册Alexa */
+ (void)registerAlexa;
/**< Amazon SDK登陆 productId：在alexa后台注册的产品ID */
+ (void)authorizeRequestWithproductId:(NSString *)productId Handler:(void(^)(BOOL isLogin))handler;
/**< 退出登录 */
+ (void)signOut;

#pragma mark - optional
/**< 获取登录状态 1 登录 0 未登录 */
+ (BOOL)getLoginState;
/**< 被挤退 在alexa页面时候退出页面操作 */
+ (void)deregister:(void (^)(void))deregisterBlcok;
/**< 切换语言 默认英语 */
+ (void)changeLanguage:(AlexaCountryType)type;
/**< 获取当前语言 */
+ (AlexaCountryType)getCurrentLanguage;
/**< Appdelegate openurl */
+ (BOOL)openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options;
/**< 删除闹钟 */
+ (void)deleteAlarm:(IDOSetVoiceV3AlarmInfoModel *)alram callback:(void(^_Nullable)(int errorCode))callback;
/**< 语音添加闹钟 */
+ (void)alexaSetAlarm:(void (^ _Nullable)(IDOSetVoiceV3AlarmInfoModel *alram))callBack;
/**< 语音删除闹钟 */
+ (void)alexaDeleteAlarm:(void (^ _Nullable)(IDOSetVoiceV3AlarmInfoModel *alram))callBack;
/**< 获取心率数据 */
+ (void)getHrValue:(NSInteger(^ _Nullable)(AlexaHRDataType dataType,AlexaHRTimeType timeType))callBack;
/**< 获取健康数据 */
+ (void)getHealthValue:(NSInteger(^ _Nullable)(AlexaGetValueType valueType))callBack;
/**< 功能控制 */
+ (void)foundationControl:(void (^ _Nullable)(AlexaFoundationType foundationType))callBack;

#pragma mark - useless
/**< 获取引导状态 */
+ (BOOL)getIsInGuide;
/**< 设置引导状态 */
+ (void)changeIsInGuide:(BOOL)isInGuide;

#pragma mark - test
/**< 本地测试功能 必须加入NSMicrophoneUsageDescription */
+ (void)recordingTest:(BOOL)isStartRecording;
/**< 是否播放音频 */
+ (void)isPlayAudio:(BOOL)isPlayAudio;
@end

NS_ASSUME_NONNULL_END
