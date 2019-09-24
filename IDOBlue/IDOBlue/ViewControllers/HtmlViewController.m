//
//  HtmlViewController.m
//  IDOVFPMe
//
//  Created by Idoone on 2018/8/6.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "HtmlViewController.h"

@interface HtmlViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *myWebView;

@property (nonatomic, strong)UIActivityIndicatorView *flowerView;

@end

@implementation HtmlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initXibView];
    [self loadFlower];
    if (self.logFilePath) {
        [self loadText];
    } else {
        [self loadHTML];
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)dealloc {
    _myWebView.delegate = nil;
    [_myWebView loadHTMLString:@"" baseURL:nil];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

- (void)initXibView {
    [self setTitle:_navigationTitle];
    _myWebView.backgroundColor = [UIColor clearColor];
    _myWebView.opaque = NO;
    
}

- (void)loadFlower {
    _flowerView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    CGFloat windowWidth  = [UIScreen mainScreen].bounds.size.width;
    CGFloat windowHeight = [UIScreen mainScreen].bounds.size.height;
    _flowerView.center = CGPointMake(windowWidth/2.0,windowHeight/2.0);//只能设置中心，不能设置大小
    [_flowerView startAnimating]; // 开始旋转
    [_flowerView setHidesWhenStopped:YES]; //当旋转结束时隐藏
    [self.view addSubview:_flowerView];
}

- (void)loadHTML{
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:_URL];  //创建NSURLRequest
    [_myWebView loadRequest:request];//加载
    
}

#pragma mark 加载本地文本文件
- (void)loadText
{
    NSURL *url = [NSURL fileURLWithPath:self.logFilePath];
    NSData *data = [NSData dataWithContentsOfFile:self.logFilePath];
    [self.myWebView loadData:data MIMEType:[self mineType:url] textEncodingName:@"UTF-8" baseURL:nil];
}

- (NSString *)mineType:(NSURL *)url {
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *respone = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&respone error:nil];
    return respone.MIMEType;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //网页加载完成调用此方法
    [_flowerView stopAnimating]; // 结束旋转
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //网页加载失败 调用此方法
    [_flowerView stopAnimating]; // 结束旋转
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)shareBtnClick {
    
    NSURL*urlToShare=  [NSURL fileURLWithPath:_logFilePath];
    NSArray *activityItems = @[urlToShare];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    activityVC.completionWithItemsHandler = ^(NSString *activityType,BOOL completed,NSArray *returnedItems,NSError *activityError)
    {

    };
    
    [self presentViewController:activityVC animated:YES completion:nil];
}


@end
