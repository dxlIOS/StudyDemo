//
//  NormalView.h
//  ActionSheetDemo_0930
//
//  Created by dxl on 16/9/30.
//  Copyright © 2016年 dxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NormalView : UIViewController
<UIWebViewDelegate>
{
    UIWebView *_webView;
}

@property(nonatomic,retain)UIWebView *webView;
@end
