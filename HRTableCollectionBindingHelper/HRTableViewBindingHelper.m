//
//  HRTableViewBindingHelper.m
//  HRTableCollectionBindingDemo
//
//  Created by Ran on 14/11/5.
//  Copyright (c) 2014年 Rannie. All rights reserved.
//

#import "HRTableViewBindingHelper.h"
#import "BindViewDelegate.h"

@interface HRTableViewBindingHelper ()
@property (nonatomic, strong) NSString * cellIdentifier;
@end

@implementation HRTableViewBindingHelper

#pragma  mark - initialization
// RAC
+ (instancetype)bindingForTableView:(UITableView *)tableView sourceSignal:(RACSignal *)source didSelectionCommand: didSelection templateCell:(UINib *)templateCellNib {
    return [[self alloc] initWithTableView:tableView sourceSignal:source didSelectionCommand:didSelection templateCell:templateCellNib];
}

+ (instancetype)bindingForTableView:(UITableView *)tableView sourceSignal:(RACSignal *)source didSelectionCommand:(RACCommand *)didSelection templateCellClassName:(NSString *)classCell {
    return [[self alloc] initWithTableView:tableView sourceSignal:source didSelectionCommand:didSelection templateCellClassName:classCell];
}

- (instancetype)initWithTableView:(UITableView *)tableView sourceSignal:(RACSignal *)source didSelectionCommand:(RACCommand *)didSelection {
    NSParameterAssert(tableView);
    NSParameterAssert(source);
    self = [super init];
    if (self) {
        _tableView = tableView;
        _data = @[];
        _selectionCommand = didSelection;
        
        [source subscribeNext:^(id x) {
            self->_data = x;
            [self->_tableView reloadData];
        }];
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return self;
}

- (instancetype)initWithTableView:(UITableView *)tableView sourceSignal:(RACSignal *)source didSelectionCommand:(RACCommand *)didSelection templateCell:(UINib *)templateCellNib {
    if (self = [self initWithTableView:tableView sourceSignal:source didSelectionCommand:didSelection]) {
        _templateCell = [[templateCellNib instantiateWithOwner:nil options:nil] firstObject];
        [_tableView registerNib:templateCellNib forCellReuseIdentifier:_templateCell.reuseIdentifier];
        _tableView.rowHeight = _templateCell.bounds.size.height;
        
        [self customInitialization];
    }
    return self;
}

- (instancetype)initWithTableView:(UITableView *)tableView sourceSignal:(RACSignal *)source didSelectionCommand:(RACCommand *)didSelection templateCellClassName:(NSString *)classCell {
    if (self = [self initWithTableView:tableView sourceSignal:source didSelectionCommand:didSelection]) {
        self.cellIdentifier = classCell;
        [tableView registerClass:NSClassFromString(classCell) forCellReuseIdentifier:classCell];
        
        [self customInitialization];
    }
    return self;
}

//Normal
+ (instancetype)bindingForTableView:(UITableView *)tableView sourceList:(NSArray *)source didSelectionBlock:(TableSelectionBlock)block templateCell:(UINib *)templateCellNib {
    return [[self alloc] initWithTableView:tableView sourceList:source didSelectionBlock:block templateCell:templateCellNib];
}

+ (instancetype)bindingForTableView:(UITableView *)tableView sourceList:(NSArray *)source didSelectionBlock:(TableSelectionBlock)block templateCellClassName:(NSString *)templateCellClass {
    return [[self alloc] initWithTableView:tableView sourceList:source didSelectionBlock:block templateCellClassName:templateCellClass];
}

- (instancetype)initWithTableView:(UITableView *)tableView sourceList:(NSArray *)source didSelectionBlock:(TableSelectionBlock)block {
    NSParameterAssert(tableView);
    NSParameterAssert(source);
    self = [super init];
    if (self) {
        _tableView = tableView;
        _data = source;
        _selectionBlock = [block copy];
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return self;
}

- (instancetype)initWithTableView:(UITableView *)tableView sourceList:(NSArray *)source didSelectionBlock:(TableSelectionBlock)block templateCell:(UINib *)templateCellNib {
    self = [self initWithTableView:tableView sourceList:source didSelectionBlock:block];
    if (self) {
        _templateCell = [[templateCellNib instantiateWithOwner:nil options:nil] firstObject];
        [_tableView registerNib:templateCellNib forCellReuseIdentifier:_templateCell.reuseIdentifier];
        _tableView.rowHeight = _templateCell.bounds.size.height;
        
        [self customInitialization];
    }
    return self;
}

- (instancetype)initWithTableView:(UITableView *)tableView sourceList:(NSArray *)source didSelectionBlock:(TableSelectionBlock)block templateCellClassName:(NSString *)templateCellClass {
    self = [self initWithTableView:tableView sourceList:source didSelectionBlock:block];
    if (self) {
        self.cellIdentifier = templateCellClass;
        [tableView registerClass:NSClassFromString(templateCellClass) forCellReuseIdentifier:templateCellClass];
        
        [self customInitialization];
    }
    return self;
}

- (void)customInitialization {
    //abstract...
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self dequeueCellAndBindInTable:tableView indexPath:indexPath];
}

- (UITableViewCell *)dequeueCellAndBindInTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    id<BindViewDelegate> cell = [tableView dequeueReusableCellWithIdentifier:_templateCell.reuseIdentifier];
    [cell bindModel:_data[indexPath.row]];
    return (UITableViewCell *)cell;
}

#pragma mark - UITableViewDelegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_selectionCommand) {
        [_selectionCommand execute:_data[indexPath.row]];
    } else if (_selectionBlock) {
        _selectionBlock(_data[indexPath.row]);
    }
}

#pragma mark - Action
- (void)reloadDataWithSourceList:(NSArray *)source {
    if (source) {
        _data = source;
    }
    [_tableView reloadData];
}

@end
