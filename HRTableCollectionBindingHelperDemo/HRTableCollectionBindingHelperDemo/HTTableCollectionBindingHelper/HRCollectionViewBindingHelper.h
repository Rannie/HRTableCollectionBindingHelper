//
//  HRCollectionViewBindingHelper.h
//  HRTableCollectionBindingDemo
//
//  Created by Ran on 14/11/5.
//  Copyright (c) 2014年 Rannie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa.h>

typedef void (^CollectionSelectionBlock)(id model);

@interface HRCollectionViewBindingHelper : NSObject <UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSArray                     *_data;
    UICollectionView            *_collectionView;
    UICollectionViewCell        *_templateCell;
    RACCommand                  *_selectCommand;
    CollectionSelectionBlock     _selectBlock;
}

+ (instancetype)bindWithCollectionView:(UICollectionView *)collectionView
                            dataSource:(RACSignal *)source
                      selectionCommand:(RACCommand *)command
                          templateCell:(UINib *)nibCell;

+ (instancetype)bindWithCollectionView:(UICollectionView *)collectionView
                            dataSource:(RACSignal *)source
                      selectionCommand:(RACCommand *)command
                 templateCellClassName:(NSString *)classCell;

+ (instancetype)bindingForTableView:(UITableView *)tableView
                         sourceList:(NSArray *)source
                  didSelectionBlock:(CollectionSelectionBlock)block
                       templateCell:(UINib *)templateCellNib;

+ (instancetype)bindingForTableView:(UITableView *)tableView
                         sourceList:(NSArray *)source
                  didSelectionBlock:(CollectionSelectionBlock)block
              templateCellClassName:(NSString *)templateCellClass;

- (UICollectionViewCell *)dequeueCellAndBindInCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;

@end
