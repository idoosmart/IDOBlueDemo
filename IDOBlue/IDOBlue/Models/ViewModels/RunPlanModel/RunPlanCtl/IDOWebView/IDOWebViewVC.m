//
//  IDOWebViewVC.m
//  IDOVFLogin
//
//  Created by Warp on 2022/1/12.
//

#import "IDOWebViewVC.h"
#import "FBKVOController.h"
#import "Masonry.h"

@interface IDOWebViewVC ()<WKNavigationDelegate>

@property (strong, readwrite, nonatomic) WKWebView *myWebView;

// 是否加载完成
@property (assign,nonatomic) BOOL isLoaded;

@end

@implementation IDOWebViewVC

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    
    [self initUI];
}
#pragma mark ----- event Response 事件响应(手势 通知)

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [SVProgressHUD dismiss];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    _myWebView.navigationDelegate = nil;
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}
- (void)dealloc{
    _myWebView.navigationDelegate = nil;
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

//点击返回按钮返回上一次
- (void)clickReturn{
    
    if (self.isBackToPop) {
        //返回直接Pop到上一页面
        [self.navigationController popViewControllerAnimated:YES];
        if (self.backblock){
            self.backblock();
        }
        return;
    }
    
    if (self.myWebView.canGoBack){
        if (self.isBackToHome) {
            //返回 回到Web的首页
            NSInteger step = 0;//返回的页码，0是首页
            WKBackForwardListItem* backItem = _myWebView.backForwardList.backList[step];
            [_myWebView goToBackForwardListItem:backItem];
        }else{
            [self.myWebView goBack];
        }
    } else{
        [self.navigationController popViewControllerAnimated:YES];
        if (self.backblock){
            self.backblock();
        }
    }
}

- (void)initUI{
    
    [self.view addSubview:self.myWebView];
    [self.myWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.bottom.right.mas_equalTo(@0);
    }];
    _myWebView.backgroundColor = [UIColor clearColor];
    _myWebView.opaque = NO;
    
    [self loadHTML];
}


#pragma mark 加载req
- (void)loadHTML{
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:_URL];  //创建NSURLRequest
    [_myWebView loadRequest:request];//加载
}

#pragma mark - 相关的协议实现

/// 2 页面开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"webView didStartProvisionalNavigation");
}
/// 4 开始获取到网页内容时返回
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"webView didCommitNavigation");
}
/// 5 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
//    [SVProgressHUD dismiss];
    self.isLoaded = YES;
    NSLog(@"webView didFinishNavigation");
    [[NSNotificationCenter defaultCenter] postNotificationName:kDidFinishLoadHtml5NotificationKey object:nil];

}
/// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    //网页加载失败 调用此方法
    self.isLoaded = YES;
    NSLog(@"webView didFailProvisionalNavigation");
    [[NSNotificationCenter defaultCenter] postNotificationName:kDidFinishLoadHtml5NotificationKey object:nil];

}


#pragma mark - Get

- (WKWebView *)myWebView{
    if (!_myWebView) {
        _myWebView = [[WKWebView alloc] init];
        _myWebView.navigationDelegate = self;
    }
    return _myWebView;
}

@end
