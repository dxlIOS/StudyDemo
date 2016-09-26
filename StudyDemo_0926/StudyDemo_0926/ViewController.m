//
//  ViewController.m
//  StudyDemo_0926
//
//  Created by dxl on 16/9/26.
//  Copyright © 2016年 dxl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Study";
    self.navigationController.navigationBar.translucent = NO;
    
    [self typeTransform];
    [self initMyWebView];
}


#pragma mark - typeTransform
- (void) typeTransform
{
    
}

#pragma mark - WebView initialization
- (void) initMyWebView
{
    _myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    _myWebView.delegate = self;
    
    [_myWebView setScalesPageToFit:YES];
    [_myWebView setOpaque:NO];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Page/HomePage" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path];
    [_myWebView loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:_myWebView];
}

#pragma mark - js invoke OC
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    
    return YES;
}


#pragma mark - OC invoke js
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_myWebView stringByEvaluatingJavaScriptFromString:@"alert('load successed!');"];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
