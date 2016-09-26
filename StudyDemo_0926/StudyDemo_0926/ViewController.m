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
    
}

- (void) typeTransform
{
    NSString *str = [NSString stringWithString:@"ppp"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
