//
//  ViewController.m
//  UITableViewDemo_0927
//
//  Created by dxl on 16/9/27.
//  Copyright © 2016年 dxl. All rights reserved.
//

#import "ViewController.h"
#import "AdjustWidthForCell.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"TableViewDemo";
    self.navigationController.navigationBar.translucent = NO;
    [self initDataArray];
    [self initTableView];
    [self createRightBtn];
}

#pragma mark - subview initialize
- (void) initTableView
{
    _myTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;

    [self.view addSubview:_myTableView];
}

- (void) initDataArray
{
    _dataArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 3; i++) {
        NSString *str = [NSString stringWithFormat:@"商品%d",i + 1];
        [_dataArray addObject:str];
    }
}

- (void) createRightBtn
{
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStyleBordered target:self action:@selector(editCell:)];
    self.navigationItem.rightBarButtonItem = barBtn;
}

#pragma mark - edit button implementation
- (void) editCell:(UIBarButtonItem *)btn
{
    [_myTableView setEditing:YES animated:YES];
    [btn setTitle:@"cancel"];
    [btn setAction:@selector(cancelEditing:)];
}

- (void) cancelEditing:(UIBarButtonItem *)btn
{
    [_myTableView setEditing:NO animated:YES];
    [btn setTitle:@"edit"];
    [btn setAction:@selector(editCell:)];
}

#pragma mark - UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //AdjustWidthForCell is a class which overrides the setFrame method
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"demo"];
    if (cell == Nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"demo"];
    }
    NSString *mainStr = [[_dataArray objectAtIndex:indexPath.row] substringWithRange:NSMakeRange(0, 2)];
    NSString *subStr = [[_dataArray objectAtIndex:indexPath.row] substringWithRange:NSMakeRange(2, 1)];
    cell.textLabel.text = mainStr;
    cell.detailTextLabel.text = [subStr stringByAppendingString:@">"];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    id object = [_dataArray objectAtIndex:sourceIndexPath.row];
    [_dataArray removeObjectAtIndex:sourceIndexPath.row];
    [_dataArray insertObject:object atIndex:destinationIndexPath.row];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_dataArray removeObjectAtIndex:indexPath.row];
        NSArray *array = [NSArray arrayWithObject:indexPath];
        
        [tableView deleteRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UILabel *btnLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 80)];
    [btnLabel setText:@"展 开"];
    [btnLabel setTextColor:[UIColor whiteColor]];
    [btnLabel setBackgroundColor:[UIColor blackColor]];
    [btnLabel setTextAlignment:NSTextAlignmentCenter];
    [btnLabel setAdjustsFontSizeToFitWidth:YES];
    [btnLabel setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(obtainData:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [btnLabel addGestureRecognizer:tap];
    
    
    return btnLabel;
}


#pragma mark - implementation for tap actions
-(void) obtainData:(UITapGestureRecognizer *)tap
{
    NSArray *array = [[NSArray alloc] init];
    //simulate getting data
    for (int i = 0; i < 5; i++) {
        NSString *str = [NSString stringWithFormat:@"商品%d",i + 4];
        [_dataArray addObject:str];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_dataArray.count - 1 inSection:0];
        array = [array arrayByAddingObject:indexPath];
    }
    
    [_myTableView insertRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationAutomatic];
    
    UILabel *label = (UILabel *)tap.view;
    label.text = @"折 叠";
    [tap removeTarget:self action:@selector(obtainData:)];
    [tap addTarget:self action:@selector(deleteData:)];
}

- (void) deleteData:(UITapGestureRecognizer *)tap
{
    NSArray *array = [[NSArray alloc] init];
    //simulate getting data
    for (int i = 0; i < 5; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_dataArray.count - 1 inSection:0];
        array = [array arrayByAddingObject:indexPath];
        [_dataArray removeObjectAtIndex:_dataArray.count - 1];
    }
    
    [_myTableView deleteRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationAutomatic];
    
    UILabel *label = (UILabel *)tap.view;
    label.text = @"展 开";
    [tap removeTarget:self action:@selector(deleteData:)];
    [tap addTarget:self action:@selector(obtainData:)];

}


//#pragma mark - 通过绘图方式实现的section的圆角效果
////已理解
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // 圆角弧度半径
//    CGFloat cornerRadius = 6.f;
//    // 设置cell的背景色为透明，如果不设置这个的话，则原来的背景色不会被覆盖
//    cell.backgroundColor = UIColor.clearColor;
//    
//    // 创建一个shapeLayer
//    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
//    CAShapeLayer *backgroundLayer = [[CAShapeLayer alloc] init]; //显示选中
//    // 创建一个可变的图像Path句柄，该路径用于保存绘图信息
//    CGMutablePathRef pathRef = CGPathCreateMutable();
//    // 获取cell的size
//    // 第一个参数,是整个 cell 的 bounds, 第二个参数是距左右两端的距离,第三个参数是距上下两端的距离
//    CGRect bounds = CGRectInset(cell.bounds, 10, 0);
//    
//    // CGRectGetMinY：返回对象顶点坐标
//    // CGRectGetMaxY：返回对象底点坐标
//    // CGRectGetMinX：返回对象左边缘坐标
//    // CGRectGetMaxX：返回对象右边缘坐标
//    // CGRectGetMidX: 返回对象中心点的X坐标
//    // CGRectGetMidY: 返回对象中心点的Y坐标
//    
//    // 这里要判断分组列表中的第一行，每组section的第一行，每组section的中间行
//    
//    // CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
//    if (indexPath.row == 0) {
//        // 初始起点为cell的左下角坐标
//        CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
//        // 起始坐标为左下角，设为p，（CGRectGetMinX(bounds), CGRectGetMinY(bounds)）为左上角的点，设为p1(x1,y1)，(CGRectGetMidX(bounds), CGRectGetMinY(bounds))为顶部中点的点，设为p2(x2,y2)。然后连接p1和p2为一条直线l1，连接初始点p到p1成一条直线l，则在两条直线相交处绘制弧度为r的圆角。
//        CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
//        CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
//        // 终点坐标为右下角坐标点，把绘图信息都放到路径中去,根据这些路径就构成了一块区域了
//        CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
//        
//    } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
//        // 初始起点为cell的左上角坐标
//        CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
//        CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
//        CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
//        // 添加一条直线，终点坐标为右下角坐标点并放到路径中去
//        CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
//    } else {
//        // 添加cell的rectangle信息到path中（不包括圆角）
//        //假如用填充色，用这个
//        //        CGPathAddRect(pathRef, nil, bounds);
//        
//        //假如只要边框
//        CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
//        CGPathAddLineToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
//        CGPathMoveToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
//        CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
//        
//    }
//    // 把已经绘制好的可变图像路径赋值给图层，然后图层根据这图像path进行图像渲染render
//    layer.path = pathRef;
//    backgroundLayer.path = pathRef;
//    // 注意：但凡通过Quartz2D中带有creat/copy/retain方法创建出来的值都必须要释放
//    CFRelease(pathRef);
//    // 按照shape layer的path填充颜色，类似于渲染render
//    // layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
//    layer.strokeColor = [UIColor blackColor].CGColor;
//    layer.fillColor = [UIColor clearColor].CGColor;
//    
//    // view大小与cell一致
//    UIView *roundView = [[UIView alloc] initWithFrame:bounds];
//    // 添加自定义圆角后的图层到roundView中
//    [roundView.layer insertSublayer:layer atIndex:0];
//    roundView.backgroundColor = UIColor.clearColor;
//    // cell的背景view
//    cell.backgroundView = roundView;
//    
//    // 以上方法存在缺陷当点击cell时还是出现cell方形效果，因此还需要添加以下方法
//    // 如果你 cell 已经取消选中状态的话,那以下方法是不需要的.
//    UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:bounds];
//    backgroundLayer.fillColor = [UIColor cyanColor].CGColor;
//    [selectedBackgroundView.layer insertSublayer:backgroundLayer atIndex:0];
//    selectedBackgroundView.backgroundColor = UIColor.clearColor;
//    cell.selectedBackgroundView = selectedBackgroundView;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
