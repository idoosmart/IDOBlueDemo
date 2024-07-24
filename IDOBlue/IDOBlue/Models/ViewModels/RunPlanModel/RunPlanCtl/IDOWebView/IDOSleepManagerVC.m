//
//  IDOSleepManagerVC.m
//  IDOVFLogin
//
//  Created by Warp on 2022/1/12.
//

#import "IDOSleepManagerVC.h"

@interface IDOSleepManagerVC ()

@end

@implementation IDOSleepManagerVC

- (void)viewWillAppear:(BOOL)animated {
    //禁止返回
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //#1D1E24
    self.view.backgroundColor = [UIColor colorWithRed:29/255.0 green:30/255.0 blue:36/255.0 alpha:1.0];
    if (@available(iOS 11.0, *)) {
        self.myWebView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    if (!_bridge) {
        self.bridge = [self getJavascriptBridge];
        
    }
    
    //    NSDictionary *params = @{@"userId": USER_DEFAULT.userid ?: @"",
    //                             @"color": @"0",
    //                             @"language": [IDOCoreLanguageManager shareInstance].curLagCode ?: @"en",
    //                             @"token": USER_DEFAULT.token ?: @"",
    //                             @"iPhoneXOrLater": @(IDO_IS_iPhoneX),
    //                             @"appKey": URL_APP_KEY,};
    //
    //    //初始化参数
    //    [self callHandler:@"getUserInfoAPP" data:params];
    //
    //响应H5的方法
    __weak typeof(self) weakSelf = self;
    [self.bridge registerHandler:@"sendImageMessage" handler:^(id data, WVJBResponseCallback responseCallback) {
        [weakSelf webShareWeeklyImage:data[@"val"]];
    }];
    
    [self.bridge registerHandler:@"playMusic" handler:^(id data, WVJBResponseCallback responseCallback) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [data objectForKey:@"val"]) {
            [weakSelf webPlaySleepMusic:data[@"val"] callback:responseCallback];
            
            if (weakSelf.h5NotiActivityBlock) {
                weakSelf.h5NotiActivityBlock(data);
            }
        }
    }];
    
    [self.bridge registerHandler:@"sendNotificationToAPP" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        if ([data isKindOfClass:[NSDictionary class]] &&
            [data objectForKey:@"message"]) {
            [weakSelf sendNotificationToAPP:data[@"message"]];
        }
        
        if (weakSelf.h5NotiActivityBlock) {
            weakSelf.h5NotiActivityBlock(data);
        }
    }];
}

///向H5传参
- (void)callHandler:(NSString *)handlerName data:(id)data{
    if (!_bridge) {
        self.bridge = [self getJavascriptBridge];
    }
    [self.bridge callHandler:handlerName data:data];
}

- (void)registerHandler:(NSString*)handlerName handler:(WVJBHandler)handler{
    if (!_bridge) {
        self.bridge = [self getJavascriptBridge];
    }
    [self.bridge registerHandler:handlerName handler:handler];
}

///分享周报
- (void)webShareWeeklyImage:(id)data{
    if (![data isKindOfClass:[NSString class]]) {
        //DDLogInfo(@"分享周报的参数异常");
        return;
    }
    // ||![data hasPrefix:@"data:image/png;base64"]
    NSString *str = [(NSString *)data stringByReplacingOccurrencesOfString:@"data:image/png;base64," withString:@""];
    NSData *imageData = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *imageToShare = [UIImage imageWithData:imageData];
    if(imageToShare.size.height > 2000) //第三方应用分享图片长度大于2000，会直接返回失败 所以等比例缩小一下
    {
        CGFloat heightScale = 2000.0 / imageToShare.size.height;
        imageToShare = [self compressOriginalImage:imageToShare toSize:CGSizeMake(imageToShare.size.width * heightScale, imageToShare.size.height * heightScale)];
    }
    if (!imageToShare) {
        return;
    }
    
    if (self.shareImageBlock) {
        self.shareImageBlock(imageToShare);
    }
}
/**
* 压缩图片到指定尺寸大小
*
* @param image 原始图片
* @param size 目标大小
*
* @return 生成图片
*/
-(UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size{
    UIImage * resultImage = image;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    resultImage = UIGraphicsGetImageFromCurrentImageContext();
    if (!resultImage) {
        return image;
    }
    return resultImage;
}
///播放助眠音乐
- (void)webPlaySleepMusic:(id)data callback:(WVJBResponseCallback)responseCallback{
    if (![data isKindOfClass:[NSDictionary class]]) {
        //DDLogInfo(@"播放音乐参数异常");
        return;
    }
    
    responseCallback(@(YES));
}

- (void)sendNotificationToAPP:(NSString *)handlerName{
    if ([handlerName isEqualToString:@"backToApp"]) {
        //H5已回到首页，退出睡眠管理
//        [self.navigationController popViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if ([handlerName isEqualToString:@"backToLogin"]) {
        //Token无效
        //        [IDONetworkManager throwErrorStatusCodeToBusinessLayer:201012];
        Class loginTool  = NSClassFromString(@"IDOCoreLoginTool");
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        if (loginTool&&[loginTool respondsToSelector:@selector(tokenExpiredAndLogout:)]) {
            [loginTool performSelector:@selector(tokenExpiredAndLogout:) withObject:@(201012)];
        }
#pragma clang diagnostic pop
    }else if ([handlerName isEqualToString:@"noScroll"]) {
        //禁止滚动
        self.myWebView.scrollView.scrollEnabled = NO;
    }else if ([handlerName isEqualToString:@"scroll"]) {
        //允许滚动
        self.myWebView.scrollView.scrollEnabled = YES;
    }else if ([handlerName isEqualToString:@"stopSleepPlan"] ||
              [handlerName isEqualToString:@"updateSleepTime"] ||
              [handlerName isEqualToString:@"readWeeklyStatus"] ||
              [handlerName isEqualToString:@"openSyncHealthInfo"]) {
        //停止、更新计划，重新获取app本地通知
        [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateSleepScheduleNoticeKey object:handlerName];
    }else if ([handlerName isEqualToString:@"disabledPanToBack"]) {
        //禁止右滑返回
        id traget = self.navigationController.interactivePopGestureRecognizer.delegate;
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:traget action:nil];
        [self.view addGestureRecognizer:pan];
        
    }
}

- (WebViewJavascriptBridge *)getJavascriptBridge{
#ifdef DEBUG
    WebViewJavascriptBridge *bridge = [WebViewJavascriptBridge
                                       bridgeForWebView:self.myWebView
                                       showJSconsole:YES
                                       enableLogging:YES];
    return bridge;
#else
    WebViewJavascriptBridge *bridge = [WebViewJavascriptBridge
                                       bridgeForWebView:self.myWebView
                                       showJSconsole:NO
                                       enableLogging:NO];
    return bridge;
#endif
    
    
}
-(void)dealloc
{
    NSLog(@"IDOSleepManagerVC 销毁了");
    [self.myWebView stopLoading];
    [self.myWebView removeFromSuperview];
}
@end
