//
//  NormalView.m
//  ActionSheetDemo_0930
//
//  Created by dxl on 16/9/30.
//  Copyright © 2016年 dxl. All rights reserved.
//

#import "NormalView.h"

@interface NormalView ()

@end

@implementation NormalView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"My Page";
    self.view.backgroundColor = [UIColor whiteColor];
    [self resetBarButton];
    [self initWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - init webview
- (void) initWebView
{
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.delegate = self;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Page/HomePage" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    self.webView.scalesPageToFit = YES;
    
    [self.webView loadRequest:req];
    [self.view addSubview:self.webView];
    
}


#pragma mark - reset navigationbar left button
- (void) resetBarButton
{
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:@"＜" style:UIBarButtonItemStylePlain target:self action:@selector(backToPre)];
    self.navigationItem.leftBarButtonItem = btn;
}

- (void) backToPre
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - webview delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *reqStr = request.URL.absoluteString;
    if ([reqStr hasSuffix:@"jpg"]) {
        NSMutableString *jsString = [[NSMutableString alloc] init];
        [jsString appendString:@"var content = document.getElementById('content');"];
        [jsString appendString:@"content.innerHTML = '加载图片..';"];
        [self.webView stringByEvaluatingJavaScriptFromString:jsString];
        
        NSURL *url = [NSURL URLWithString:reqStr];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(50, 300, 200, 200);
        [self.webView addSubview:imageView];
        return NO;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"start load");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}

//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
//{
//    NSLog(@"%@",error);
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
