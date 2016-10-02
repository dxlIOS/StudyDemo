//
//  ViewController.m
//  WKWebViewDemo
//
//  Created by dxl on 16/10/2.
//  Copyright © 2016年 dxl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableString *jsString = [NSMutableString stringWithString:@"var content = document.getElementById('content');"];
    [jsString appendString:@"content.innerHTML = '加载页面成功';"];
    WKUserScript *script = [[WKUserScript alloc] initWithSource:jsString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    [config.userContentController addUserScript:script];
    
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    NSString *path= [[NSBundle mainBundle] pathForResource:@"Page/HomePage" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    
    [webView.configuration.userContentController addScriptMessageHandler:self name:@"loadImage"];
    [webView.configuration.userContentController addScriptMessageHandler:self name:@"createAlert"];
    [webView loadRequest:req];
    [self.view addSubview:webView];
    self.wk = webView;
}

- (void)createAlert
{
    
    NSLog(@"ttttttt");
}

- (void)loadImage
{
    NSString *str = [NSString stringWithFormat:@"%d",arc4random() % 11];
    NSMutableString *jsString = [NSMutableString stringWithString:@"var content = document.getElementById('content');"];
    [jsString appendString:[NSString stringWithFormat:@"content.innerHTML = '加载图片%@';",str]];
    [self.wk evaluateJavaScript:jsString completionHandler:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSLog(@"%@,.......%@",message.name,message.body);
    SEL func = NSSelectorFromString(message.name);
    
    [self performSelector:func];
}

#pragma mark - WK navigationDelegate
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    
}

//页面开始返回内容
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    
}

//接受到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
    
}

// 在收到响应后，决定是否跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
//{
//    
//}

// 在发送请求之前，决定是否跳转
//-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
//{
//    
//}
#pragma  makr - WK UIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    NSLog(@"alerted!");
}

- (void)dealloc
{
    [self.wk.configuration.userContentController removeAllUserScripts];
}
@end
