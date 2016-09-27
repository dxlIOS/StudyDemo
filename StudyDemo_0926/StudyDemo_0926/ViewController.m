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
    
    [self initMyWebView];
    [self dataTypeTransform];
    
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
    
    NSString *strData = @"ooooooo";
    NSData *dataStr = [strData dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"NSData & NSString:%@",dataStr);
    
    NSString *stringData = [[NSString alloc] initWithData:dataStr encoding:NSUTF8StringEncoding];
    NSLog(@"NSData & NSString:%@",stringData);
    
    //NSData & Byte
    Byte *byteData = (Byte *)[dataStr bytes];
    
    //why the result is oooooooêk≠îZ˙?
    NSLog(@"NSData & Byte:%s",byteData);
    
    Byte byte[] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17};
    NSData *dataByte = [NSData dataWithBytes:byte length:18];
    NSLog(@"%@",dataByte);
    
    //NSData & UIImage
    UIImage *image = [UIImage imageNamed:@"test.png"];
    NSData *dataImage = UIImagePNGRepresentation(image);
    
//    NSLog(@"%@",dataImage); ->too long
    
    UIImage *imageData = [UIImage imageWithData:dataImage];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:imageData];
    imageView.frame = CGRectMake(self.view.bounds.size.width - 150, self.view.bounds.size.height - 200, 100, 100);
    [self.view addSubview:imageView];
    
    //NSString & NSDate
    NSDate *time = [NSDate date];
    NSString *timeStr = [NSString stringWithFormat:@"%f",[time timeIntervalSince1970]];
    NSLog(@"the timeStr is:%@",timeStr);
    
    
    NSDate *newTime = [NSDate dateWithTimeIntervalSince1970:[timeStr intValue]];
    NSLog(@"%@",newTime);
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateStyle:NSDateFormatterFullStyle];
    timeStr = [dateFormat stringFromDate:time];
    NSLog(@"the time is:%@",timeStr);
    
    
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
//    NSString *requestStr = request.URL.absoluteString;
//    NSRange range = [requestStr rangeOfString:@"dxl://"];
//    if (range.location != NSNotFound) {
//        NSString *method = [requestStr substringFromIndex:range.location + range.length];
//        SEL func = NSSelectorFromString(method);
//        if([self respondsToSelector:func] == YES)
//        {
//            [self performSelector:func withObject:nil];
//        }
//    }
    
    NSString *requestStr = request.URL.absoluteString;
    NSString *methodName = [requestStr substringFromIndex:6];
    SEL func = NSSelectorFromString(methodName);
    if ([self respondsToSelector:func]) {
        [self performSelector:func];
    }
    
    return YES;
}

- (void) writeImageToDevice
{
    UIGraphicsBeginImageContext(self.view.frame.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0, self.view.bounds.size.height - 200, 100, 100);
    [self.view addSubview:imageView];
    
    
    
//    NSData *data = UIImageJPEGRepresentation(image, 1);
//    [data writeToFile:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/first.jpg"] atomically:YES];
    
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
