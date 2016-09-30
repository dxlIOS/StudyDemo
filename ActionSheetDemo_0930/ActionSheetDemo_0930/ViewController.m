//
//  ViewController.m
//  ActionSheetDemo_0930
//
//  Created by dxl on 16/9/30.
//  Copyright © 2016年 dxl. All rights reserved.
//

#import "ViewController.h"
#import "AdvanceView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"ActionSheet";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    self.navigationController.navigationBar.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40);
    [self createRightBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - create elements for ViewContoller

- (void) createRightBtn
{
    UIBarButtonItem *actionBtn = [[UIBarButtonItem alloc] initWithTitle:@"三" style:UIBarButtonItemStylePlain target:self action:@selector(showActionSheet)];
    UIBarButtonItem *pushBtn = [[UIBarButtonItem alloc] initWithTitle:@"＞" style:UIBarButtonItemStylePlain target:self action:@selector(pushToNext)];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:pushBtn,actionBtn, nil];
}

- (void) showActionSheet
{
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"加载图片一",@"加载图片二", nil];
    action.actionSheetStyle = UIBarStyleBlackOpaque;
    [action showInView:self.view];
}

- (void) pushToNext
{
    AdvanceView *adView = [[AdvanceView alloc] init];
    [self.navigationController pushViewController:adView animated:YES];
}

- (void) requestImage
{
        NSURL *url = [NSURL URLWithString:@"http://pic2.ooopic.com/11/90/30/79bOOOPIC1a_1024.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(100, 100, 100, 100);
        [self.view addSubview:imageView];
}

#pragma mark - actionsheet delegate
- (void)actionSheetCancel:(UIActionSheet *)actionSheet
{
    NSLog(@"Cancel");
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [NSThread detachNewThreadSelector:@selector(requestImage) toTarget:self withObject:nil];
            
            break;
        case 1:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Not found" message:@"No image" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
            [alert show];
        }
            break;
            
        default:
            break;
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"消失了");
}

-(void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"即将消失");
}

- (void)didPresentActionSheet:(UIActionSheet *)actionSheet
{
    NSLog(@"出现了");
}

-(void)willPresentActionSheet:(UIActionSheet *)actionSheet
{
    NSLog(@"即将出现");
}

@end
