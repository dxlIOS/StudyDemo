//
//  ViewController.m
//  UICollectionViewDemo_0929
//
//  Created by dxl on 16/9/29.
//  Copyright © 2016年 dxl. All rights reserved.
//

#import "ViewController.h"
#import "AdvanceCollectionView.h"

#define Column 4
#define CellWidth (self.view.frame.size.width - 30) / 3

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"UICollectionView";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    [self initUICollectionView];
    [self createNewPageBtn];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - init collectionview
- (void) initUICollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 2;
    layout.minimumInteritemSpacing = 5;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //register for cell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"test"];
    //register for header
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerID"];
    //register for footer
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerID"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
}

#pragma mark - create right button
- (void)createNewPageBtn
{
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:@"下一页" style:UIBarButtonItemStylePlain target:self action:@selector(pushToNext)];
    self.navigationItem.rightBarButtonItem = btn;
}

- (void) pushToNext
{
    AdvanceCollectionView *advanceView = [[AdvanceCollectionView alloc] init];
    [self.navigationController pushViewController:advanceView animated:YES];
}

#pragma mark - make waterfall layout for cell
- (void) makeNewFrameForCell:(UICollectionViewCell *)cell withIndexPath:(NSIndexPath *)indexPath
{
    NSInteger columnIndex = indexPath.row % Column;
    CGFloat pointX = (CellWidth + 10) * columnIndex;
    NSLog(@"%f",pointX);
    CGFloat newPointY = 10;
    
    for (NSUInteger i = indexPath.row - Column; i > 0; i-=Column) {
        newPointY += [self.cellsHeight[i] floatValue]+ 10;
    }
    cell.frame = CGRectMake(pointX, newPointY, CellWidth, [self.cellsHeight[indexPath.row] floatValue]);
}

#pragma mark - UICollectionView delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 12;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"test" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    
//     Failed to try waterfall layout
//    [self makeNewFrameForCell:cell withIndexPath:indexPath];
//    if (indexPath.row == 0) {
//        cell.frame = CGRectMake(0, 0, CellWidth, [self.cellsHeight[indexPath.row] floatValue]);
//    }
    
    
    
    
    return cell;
}

//create header and footer
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView;
    if (kind == UICollectionElementKindSectionHeader) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerID"forIndexPath:indexPath];
        reusableView.layer.borderWidth = 1;
        reusableView.layer.borderColor = [UIColor grayColor].CGColor;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn setTitle:@"Header" forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, 320, 80);
        [reusableView addSubview:btn];
    }
    if (kind == UICollectionElementKindSectionFooter) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerID"forIndexPath:indexPath];
        
        reusableView.layer.borderWidth = 1;
        reusableView.layer.borderColor = [UIColor grayColor].CGColor;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn setTitle:@"Footer" forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, 320, 80);
        NSLog(@"fuck");
        [reusableView addSubview:btn];
    }
    
    return reusableView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(320, 80);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(320, 80);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    if ([NSStringFromSelector(action) isEqualToString:@"cut:"] || [NSStringFromSelector(action) isEqualToString:@"paste:"]) {
        return YES;
    }
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    if ([NSStringFromSelector(action) isEqualToString:@"cut:"] ) {
        [collectionView reloadData];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 50 + arc4random() % 200;
    [self.cellsHeight addObject:[NSString stringWithFormat:@"%f",height]];
    return CGSizeMake(CellWidth, 200);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 0, 10, 0);
}

@end
