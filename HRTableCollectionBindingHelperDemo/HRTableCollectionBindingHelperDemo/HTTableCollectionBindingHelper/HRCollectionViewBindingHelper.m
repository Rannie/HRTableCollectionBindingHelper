//
//  HRCollectionViewBindingHelper.m
//  HRTableCollectionBindingDemo
//
//  Created by Ran on 14/11/5.
//  Copyright (c) 2014年 Rannie. All rights reserved.
//

#import "HRCollectionViewBindingHelper.h"
#import "BindViewDelegate.h"

@interface HRCollectionViewBindingHelper ()
@property (nonatomic, strong) NSString * cellIdentifier;
@end

@implementation HRCollectionViewBindingHelper

#pragma mark - Initialize
+ (instancetype)bindWithCollectionView:(UICollectionView *)collectionView dataSource:(RACSignal *)source selectionCommand:(RACCommand *)command templateCell:(UINib *)nibCell
{
    return [[self alloc] initWithCollectionView:collectionView dataSource:source selectionCommand:command templateCell:nibCell];
}

+ (instancetype)bindWithCollectionView:(UICollectionView *)collectionView dataSource:(RACSignal *)source selectionCommand:(RACCommand *)command templateCellClassName:(NSString *)classCell
{
    return [[self alloc] initWithCollectionView:collectionView dataSource:source selectionCommand:command templateCellClassName:classCell];
}

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView
                            dataSource:(RACSignal *)source
                      selectionCommand:(RACCommand *)command
{
    NSParameterAssert(collectionView);
    NSParameterAssert(source);
    self = [super init];
    if (!self) return nil;
    
    _collectionView = collectionView;
    _selectCommand = command;
    _data = @[];
    
    [source subscribeNext:^(NSArray *dataList) {
        _data = [NSArray arrayWithArray:dataList];
        [_collectionView reloadData];
    }];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    return self;
}

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView
                            dataSource:(RACSignal *)source
                      selectionCommand:(RACCommand *)command
                          templateCell:(UINib *)nibCell
{
    self = [self initWithCollectionView:collectionView dataSource:source selectionCommand:command];
    
    _templateCell = [[nibCell instantiateWithOwner:nil options:nil] firstObject];
    _cellIdentifier = _templateCell.reuseIdentifier;
    [_collectionView registerNib:nibCell forCellWithReuseIdentifier:_cellIdentifier];
    
    return self;
}

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView
                            dataSource:(RACSignal *)source
                      selectionCommand:(RACCommand *)command
                 templateCellClassName:(NSString *)classCell
{
    self = [self initWithCollectionView:collectionView dataSource:source selectionCommand:command];
    
    self.cellIdentifier = classCell;
    [_collectionView registerClass:NSClassFromString(classCell) forCellWithReuseIdentifier:_cellIdentifier];
    
    return self;
}

#pragma mark - DataSource and Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self dequeueCellAndBindInCollectionView:collectionView indexPath:indexPath];
}

- (UICollectionViewCell *)dequeueCellAndBindInCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath
{
    id<BindViewDelegate> cell = [collectionView dequeueReusableCellWithReuseIdentifier:_cellIdentifier forIndexPath:indexPath];
    [cell bindModel:_data[indexPath.row]];
    return (UICollectionViewCell *)cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [_selectCommand execute:_data[indexPath.row]];
}


@end
