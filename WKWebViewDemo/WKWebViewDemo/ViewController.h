//
//  ViewController.h
//  WKWebViewDemo
//
//  Created by dxl on 16/10/2.
//  Copyright © 2016年 dxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface ViewController : UIViewController
<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>
{
    WKWebView *_wk;
}

@property(nonatomic,retain)WKWebView *wk;

@end

