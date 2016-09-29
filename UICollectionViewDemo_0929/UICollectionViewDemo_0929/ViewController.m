//
//  ViewController.m
//  UICollectionViewDemo_0929
//
//  Created by dxl on 16/9/29.
//  Copyright © 2016年 dxl. All rights reserved.
//

#import "ViewController.h"

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
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"test"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
}

//make waterfall layout for cell
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
    return 10;
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
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
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

@end
