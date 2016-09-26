//
//  ViewController.h
//  StudyDemo_0926
//
//  Created by dxl on 16/9/26.
//  Copyright © 2016年 dxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
<UIWebViewDelegate>
{
//    UITableView *_myTableView;
    UIWebView *_myWebView;
    
}

@property(nonatomic,readwrite,copy)UIWebView *myWebView;

@end

