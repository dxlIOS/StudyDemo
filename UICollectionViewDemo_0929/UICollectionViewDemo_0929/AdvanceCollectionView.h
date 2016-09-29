//
//  AdvanceCollectionView.h
//  UICollectionViewDemo_0929
//
//  Created by dxl on 16/9/29.
//  Copyright © 2016年 dxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvanceCollectionView : UIViewController
<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
    NSOperationQueue *_operationQueue;
}

@property(retain,nonatomic)UICollectionView *collectionView;
@property(retain,nonatomic)NSOperationQueue *operationQueue;

@end
