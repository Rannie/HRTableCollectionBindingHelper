//
//  HRTableViewBindingHelper.h
//  HRTableCollectionBindingDemo
//
//  Created by Ran on 14/11/5.
//  Copyright (c) 2014年 Rannie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa.h>

typedef void (^TableSelectionBlock)(id model);

@interface HRTableViewBindingHelper : NSObject <UITableViewDataSource, UITableViewDelegate>
{
    UITableView             *_tableView;
    NSArray                 *_data;
    UITableViewCell         *_templateCell;
    RACCommand              *_selectionCommand;
    TableSelectionBlock      _selectionBlock;
}

+ (instancetype) bindingForTableView:(UITableView *)tableView
                        sourceSignal:(RACSignal *)source
                 didSelectionCommand:(RACCommand *)didSelection
                        templateCell:(UINib *)templateCellNib;

+ (instancetype) bindingForTableView:(UITableView *)tableView
                        sourceSignal:(RACSignal *)source
                 didSelectionCommand:(RACCommand *)didSelection
               templateCellClassName:(NSString *)classCell;

+ (instancetype)bindingForTableView:(UITableView *)tableView
                         sourceList:(NSArray *)source
                  didSelectionBlock:(TableSelectionBlock)block
                       templateCell:(UINib *)templateCellNib;

+ (instancetype)bindingForTableView:(UITableView *)tableView
                         sourceList:(NSArray *)source
                  didSelectionBlock:(TableSelectionBlock)block
              templateCellClassName:(NSString *)templateCellClass;

- (void)customInitialization;
- (void)reloadDataWithSourceList:(NSArray *)source;
- (UITableViewCell *)dequeueCellAndBindInTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
