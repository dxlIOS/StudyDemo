//
//  ViewController.m
//  AnimationDemo
//
//  Created by dxl on 16/9/30.
//  Copyright © 2016年 dxl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Animation";
    [self createUIView];
    
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(useCATransition)];
    tap.numberOfTapsRequired = 2;
    tap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)createUIView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(160, 280, 50,50)];
    view.backgroundColor = [UIColor blueColor];
    view.layer.cornerRadius = 5;
    
    [self.view addSubview:view];
}

- (void) useCABasicAnimation
{
    //change position
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
//    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(160, 280)];
//    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(260, 280)];
  
    //change bounds
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds"];
//    animation.toValue = [NSValue valueWithCGRect:CGRectMake(120, 150, 200, 200)];
    
    //make rotation
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue=[NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2+M_PI_2, 1, 1, 0)];
    
    animation.removedOnCompletion = NO;
    animation.duration = 2;
    animation.fillMode = kCAFillModeForwards;
    animation.delegate = self;
    [self.view.subviews.lastObject.layer addAnimation:animation forKey:@"move"];
//    view.frame = CGRectOffset(view.frame, 50, 300);
}

- (void) useCATransition
{
    
    CATransition *animation = [[CATransition alloc] init];
    animation.type = @"pageCurl";
    animation.subtype = kCATransitionFromLeft;
    animation.startProgress = 0;
    animation.endProgress = 1;
    animation.duration = 2;
    animation.delegate = self;
    [self.view.layer addAnimation:animation forKey:nil];
    self.view.backgroundColor = [UIColor colorWithRed:arc4random() % 255 /255.0 green:arc4random() % 255 /255.0 blue:arc4random() % 255 /255.0 alpha:1];
    
}

- (void) useClassMethod
{
    [UIView transitionWithView:self.view.subviews.lastObject duration:2 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        self.view.subviews.lastObject.backgroundColor = [UIColor redColor];
    } completion:^(BOOL finished) {
        
        [UIView transitionWithView:self.view.subviews.lastObject duration:2 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
            self.view.subviews.lastObject.backgroundColor = [UIColor blueColor];
        } completion:nil];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [NSThread detachNewThreadSelector:@selector(useClassMethod) toTarget:self withObject:nil];
}


- (void)animationDidStart:(CAAnimation *)anim
{
    if ([anim isKindOfClass:[CATransition class]]) {
        /*
         * add UIView when transition occurred
        if (self.transitionTimes < 4) {
            [self.view.subviews.lastObject removeFromSuperview];
            [self.view.subviews.lastObject removeFromSuperview];
            [self.view.subviews.lastObject removeFromSuperview];
            self.transitionTimes = 0;
        }
        else
        {
            UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
            view.backgroundColor = [UIColor blueColor];
            [self.view addSubview:view];
        }
         */
        
    }
    NSLog(@"animation started");
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag == YES) {
        NSLog(@"%@",[anim class]);
    }
}

@end
