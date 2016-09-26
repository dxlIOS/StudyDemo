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
    
    [self dataTypeTransform];
    [self initMyWebView];
}


#pragma mark - dataTypeTransform
- (void) dataTypeTransform
{
    //NSArray & NSString
    NSArray *array = [NSArray arrayWithObjects:@"a",@"b",@"c", nil];
    NSString *str = [array componentsJoinedByString:@" "];
    NSLog(@"NSArray & NSString:%@",str);
    
    NSArray *arrayStr = [str componentsSeparatedByString:@" "];
    NSLog(@"NSArray & NSString:%@",arrayStr);
    
    //NSInteger & NSString
    NSInteger number = 20;
    NSString *stringInt = [NSString stringWithFormat:@"%ld",number];
    NSLog(@"int & NSString:%@",stringInt);
    stringInt = @"30";
    
    number = [stringInt integerValue];
    NSLog(@"int & NSString:%ld",number);
    
    //float & NSString
    stringInt = @"20.55";
    float floatString = [stringInt floatValue];
    NSLog(@"float & NSString:%f",floatString);
    
    NSString *stringFloat = [NSString stringWithFormat:@"%f",11.11];
    NSLog(@"float & NSString%@",stringFloat);
    
    //NSData & NSString
    NSData *dataStr = [NSData dataWithContentsOfFile:@"foo bar hoge"];
    NSString *stringData = [[NSString alloc] initWithData:dataStr encoding:NSUTF8StringEncoding];
    NSLog(@"NSData & NSString:%@",stringData);
    
    stringData = @"why";
    dataStr = [stringData dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"NSData & NSString:%@",dataStr);
    
    //NSData & Byte
    
    
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
    //still trying
    
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
