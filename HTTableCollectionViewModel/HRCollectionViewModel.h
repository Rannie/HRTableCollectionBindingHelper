//
//  HRCollectionViewModel.h
//  HRTableCollectionViewModelDemo
//
//  Created by Ran on 14/11/5.
//  Copyright (c) 2014年 Rannie. All rights reserved.
//

#define RACSupport

#import <UIKit/UIKit.h>
#ifdef RACSupport
#import <ReactiveCocoa.h>
#endif

@interface HRCollectionViewModel : NSObject <UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSArray                 *_data;
    UICollectionView        *_collectionView;
    UICollectionViewCell    *_templateCell;
#ifdef RACSupport
    RACCommand              *_selectCommand;
#endif
}

#ifdef RACSupport
+ (instancetype)bindWithCollectionView:(UICollectionView *)collectionView
                            dataSource:(RACSignal *)source
                      selectionCommand:(RACCommand *)command
                          templateCell:(UINib *)nibCell;

+ (instancetype)bindWithCollectionView:(UICollectionView *)collectionView
                            dataSource:(RACSignal *)source
                      selectionCommand:(RACCommand *)command
                 templateCellClassName:(NSString *)classCell;
#endif

- (UICollectionViewCell *)dequeueCellAndBindInCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;

@end
