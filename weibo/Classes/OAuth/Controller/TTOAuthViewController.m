//
//  TTOAuthViewController.m
//  weibo
//
//  Created by leo on 16/2/7.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "TTOAuthViewController.h"

#import "MBProgressHUD+MJ.h"

#import "TTRootTool.h"

#import "TTAccountTool.h"

#define TTAuthorizeBaseUrl @"https://api.weibo.com/oauth2/authorize"
#define TTClient_id @"3267544893"
#define TTClient_secret @"75cd35a1b0b9f57d4fe9837abd9d0028"
#define TTRedirect_uri @"https://www.baidu.com/"

@interface TTOAuthViewController ()<UIWebViewDelegate>

@end

@implementation TTOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 展示登录的页面
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:webView];
    
    // 加载网页
    
    NSString *baseUrl = TTAuthorizeBaseUrl;
    NSString *client_id = TTClient_id;
    NSString *redirect_uri = TTRedirect_uri;
    
    // 拼接URL字符串
    NSString *urlStr = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@", baseUrl, client_id, redirect_uri];
    
    // 创建URL
    NSURL *url = [NSURL URLWithString:urlStr];
    
    // 创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 加载请求
    [webView loadRequest:request];
    
    // 设置代理
    webView.delegate = self;
    
}

#pragma mark - UIWebView代理
- (void)webViewDidStartLoad:(UIWebView *)webView {
    // 提示用户正在加载...
    [MBProgressHUD showMessage:@"正在加载..."];
}

// webView加载完成的时候调用
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUD];
}

// webView加载失败的时候调用
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [MBProgressHUD hideHUD];
}

// 拦截webView请求
// 当webView需要加载一个请求的时候，就会调用这个方法，询问下是否请求
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *urlStr = request.URL.absoluteString;
    
    // 获取code(RequestToken)
    NSRange range = [urlStr rangeOfString:@"code="];
    // 如果有
    if (range.length) {
        NSString *code = [urlStr substringFromIndex:range.location + range.length];
        // 换取accessToken
        [self accessTokenWithCode:code];
        
        // 不会去加载回调界面
        return NO;
    }
    
    
    return YES;
}



#pragma mark - 换取accessToken
- (void)accessTokenWithCode:(NSString *)code {
    
    [TTAccountTool accountWithCode:code success:^{
        // 进入主页或者新特性，选择窗口的根控制器
        [TTRootTool chooseRootViewController:TTKeyWindow];
    } failure:^(NSError *error) {
        
    }];
    
}


@end
