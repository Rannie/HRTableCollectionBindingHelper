//
//  HRTableViewBindingHelper.h
//  HRTableCollectionBindingDemo
//
//  Created by Ran on 14/11/5.
//  Copyright (c) 2014年 Rannie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa.h>

@interface HRTableViewBindingHelper : NSObject <UITableViewDataSource, UITableViewDelegate>
{
    UITableView     *_tableView;
    NSArray         *_data;
    UITableViewCell *_templateCell;
    RACCommand      *_disSelection;
}

+ (instancetype) bindingForTableView:(UITableView *)tableView
                        sourceSignal:(RACSignal *)source
                 didSelectionCommand:(RACCommand *)didSelection
                        templateCell:(UINib *)templateCellNib;

+ (instancetype) bindingForTableView:(UITableView *)tableView
                        sourceSignal:(RACSignal *)source
                 didSelectionCommand:(RACCommand *)didSelection
               templateCellClassName:(NSString *)classCell;

- (UITableViewCell *)dequeueCellAndBindInTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
