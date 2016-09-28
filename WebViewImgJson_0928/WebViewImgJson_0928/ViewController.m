//
//  ViewController.m
//  WebViewImgJson_0928
//
//  Created by dxl on 16/9/28.
//  Copyright © 2016年 dxl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initWebView];
}

#pragma mark - webview initialization
- (void) initWebView
{
    _personalWebView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [_personalWebView setPaginationMode:UIWebPaginationModeBottomToTop];
    [_personalWebView setOpaque:NO];
    [_personalWebView setScalesPageToFit:YES];
    [_personalWebView setDelegate:self];
    
    [self.view addSubview:_personalWebView];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Page/HomePage" ofType:@"html"];
    [_personalWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
    
    
}

#pragma mark - Create UrlConnection
- (void) createConnection:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    self.myConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (self.myConnection) {
        [self notificateConnectionStatusToHtmlPage];
    }
}

- (void) notificateConnectionStatusToHtmlPage
{
    NSMutableString *jsString = [[NSMutableString alloc] init];
    [jsString appendString:@"var content = document.getElementById('content');"];
    [jsString appendString:@"content.innerHTML = '创建连接成功!读取中...';"];
    
    [self.personalWebView stringByEvaluatingJavaScriptFromString:jsString];
}

#pragma mark - parse method
- (void) parseRequestFromHtmlPage:(NSString *)requestString
{
    //后续根据特定格式的requestString添加分歧处理
//    NSArray *reqArray = [requestString componentsSeparatedByString:@"|"];
//    if (reqArray.count > 1) {
//        if ([[reqArray objectAtIndex:0] isEqualToString:@"GetJson"]) {
            [self createConnection:requestString ];
//        }
//    }
    
}

- (void) parseJSON:(NSMutableData *)data
{
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *keys = [jsonDic allKeys];
    NSDictionary *values = [jsonDic objectForKey:keys[0]];
    NSMutableString *jsString = [[NSMutableString alloc] init];
    [jsString appendString:@"var content = document.getElementById('content');"];
    [jsString appendString:@"content.innerHTML = '';"];
    [jsString appendString:[NSString stringWithFormat:@"content.innerHTML += '%@:%@';",keys[0],[values objectForKey:@"city"] ]];
#ifdef Dlog
    Dlog(@"%@",keys);
#endif
    [self.personalWebView stringByEvaluatingJavaScriptFromString:jsString];
}

#pragma mark - urlconnection data delegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.urlData = [[NSMutableData alloc] init];
    
    //judge the status of response
    NSHTTPURLResponse *httpRes = (NSHTTPURLResponse *)response;
    if (httpRes.statusCode == 200 ) {
        NSLog(@"成功");
    }
    else if (httpRes.statusCode == 404) {
        NSLog(@"Not Found");
    }
    else
    {
        NSLog(@"Server down");
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"数据的长度:%ld",data.length);
    [self.urlData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self parseJSON:self.urlData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSMutableString *jsString = [[NSMutableString alloc] init];
    [jsString appendString:@"var content = document.getElementById('content');"];
    [jsString appendString:[NSString stringWithFormat:@"content.innerHTML = '%@';",error]];
    
    [self.personalWebView stringByEvaluatingJavaScriptFromString:jsString];
}


#pragma mark - webview delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *reqStr = request.URL.absoluteString;
    if ([reqStr hasPrefix:@"http"]) {
        NSLog(@"shit");
        [self parseRequestFromHtmlPage:reqStr];
        return NO;
    }

    
    
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
