//
//  HRCollectionViewModel.h
//  HRTableCollectionViewModelDemo
//
//  Created by Ran on 14/11/5.
//  Copyright (c) 2014年 Rannie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa.h>

@interface HRCollectionViewModel : NSObject <UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSArray                 *_data;
    UICollectionView        *_collectionView;
    UICollectionViewCell    *_templateCell;
    RACCommand              *_selectCommand;
}

+ (instancetype)bindWithCollectionView:(UICollectionView *)collectionView
                            dataSource:(RACSignal *)source
                      selectionCommand:(RACCommand *)command
                          templateCell:(UINib *)nibCell;

+ (instancetype)bindWithCollectionView:(UICollectionView *)collectionView
                            dataSource:(RACSignal *)source
                      selectionCommand:(RACCommand *)command
                 templateCellClassName:(NSString *)classCell;

- (UICollectionViewCell *)dequeueCellAndBindInCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;

@end
