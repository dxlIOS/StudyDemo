//
//  AdvanceView.m
//  ActionSheetDemo_0930
//
//  Created by dxl on 16/9/30.
//  Copyright © 2016年 dxl. All rights reserved.
//

#import "AdvanceView.h"
#import "NormalView.h"


@interface AdvanceView ()

@end

@implementation AdvanceView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"AlertCon";
    self.view.backgroundColor = [UIColor whiteColor];
    [self resetBarBtns];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - create elements
- (void) resetBarBtns
{
    UIBarButtonItem *actionBtn = [[UIBarButtonItem alloc] initWithTitle:@"三" style:UIBarButtonItemStylePlain target:self action:@selector(createAlertThroughController)];
    UIBarButtonItem *popBtn = [[UIBarButtonItem alloc] initWithTitle:@"＜" style:UIBarButtonItemStylePlain target:self action:@selector(backToPre)];
    self.navigationItem.leftBarButtonItem = popBtn;
    self.navigationItem.rightBarButtonItem = actionBtn;
}

- (void) backToPre
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    ;SEL func = self.navigationItem.rightBarButtonItem.action;
    
    
}

#pragma mark - two pattern of AlertController
- (void) createAlertThroughController
{
    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"test" message:@"I'm alertbox!" preferredStyle:UIAlertControllerStyleAlert];
    [alertCon addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Username";
        textField.textColor = [UIColor blackColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleBezel;
        textField.keyboardType = UIKeyboardTypeAlphabet;
        textField.keyboardAppearance = UIKeyboardAppearanceLight;
    }];
    [alertCon addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Username";
        textField.textColor = [UIColor blackColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleBezel;
        textField.keyboardType = UIKeyboardTypeDefault;
        textField.keyboardAppearance = UIKeyboardAppearanceDark;
        
    }];
    [alertCon addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSArray *array = alertCon.textFields;
        UITextField *name = array[0];
        UITextField *pwd = array[1];
        if ([name.text isEqualToString:@"dxl"] && [pwd.text isEqualToString:@"1234"])
        {
            NormalView *view = [[NormalView alloc] init];
            [self.navigationController pushViewController:view animated:YES];
        }
    }]];
    [self presentViewController:alertCon animated:YES completion:^{
        NSLog(@"show alertCon");
    }];
    
}

- (void) createActionSheetThroughController
{
    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"test" message:@"I'm a actionsheet" preferredStyle:UIAlertControllerStyleActionSheet];
    [alertCon addAction:[UIAlertAction actionWithTitle:@"changebgColor" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        CATransition *tran = [[CATransition alloc] init];
        tran.type = @"cube";
        tran.subtype = kCATransitionFromRight;
        tran.duration = 2;
        tran.startProgress = 0;
        tran.endProgress = 1;
        tran.delegate = self;
        tran.removedOnCompletion = NO;
        self.view.backgroundColor = [UIColor colorWithRed:arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:1];
    }]];
    [alertCon addAction:[UIAlertAction actionWithTitle:@"hello" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alertCon addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
}


#pragma mark - method for test
- (void) printMessage
{
    NSLog(@"lalallalala");
}

#pragma mark - CATransition delegate
- (void)animationDidStart:(CAAnimation *)anim
{
    if ([anim isKindOfClass:[CATransition class]]) {
        [anim setTimingFunction:[CAMediaTimingFunction functionWithName:@"printMessage"]];
        
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag == YES) {
        NSLog(@"animation finished!");
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
