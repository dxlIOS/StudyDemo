//
//  ViewController.h
//  WebViewImgJson_0928
//
//  Created by dxl on 16/9/28.
//  Copyright © 2016年 dxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
<UIWebViewDelegate,NSURLConnectionDataDelegate>
{
    UIWebView *_personalWebView;
    NSURLConnection *_myConnection;
    NSMutableData *_urlData;
}

@property(nonatomic,retain)UIWebView *personalWebView;
@property(nonatomic,retain)NSURLConnection *myConnection;
@property(nonatomic,retain)NSMutableData *urlData;


#define Dlog NSLog
@end

