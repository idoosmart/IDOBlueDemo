//
//  IDOWebViewVC.h
//  IDOVFLogin
//
//  Created by Warp on 2022/1/12.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

#define kDidFinishLoadHtml5NotificationKey @"DidFinishLoadHtml5NotificationKey"

@interface IDOWebViewVC : UIViewController

@property (strong, readonly, nonatomic) WKWebView *myWebView;

@property (copy, nonatomic) NSString *navigationTitle;

@property (copy, nonatomic) NSURL *URL;

///一次性Pop，不判断 canGoBack
@property (assign, nonatomic) BOOL isBackToPop;

///点返回的时候直接返回的浏览器的首页， 不需要一次次的back
@property (assign, nonatomic) BOOL isBackToHome;

@property (assign, nonatomic) BOOL hiddenCustomNavigationBar;


/**
 返回的block回调
 */
@property (nonatomic, copy)void (^backblock)(void);

#pragma mark 加载req,失败的情况下进行重新
- (void)loadHTML;
@end

NS_ASSUME_NONNULL_END
