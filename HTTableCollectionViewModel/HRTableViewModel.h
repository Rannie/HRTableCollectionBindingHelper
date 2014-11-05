//
//  HRTableViewModel.h
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

@interface HRTableViewModel : NSObject <UITableViewDataSource, UITableViewDelegate>
{
    UITableView     *_tableView;
    NSArray         *_data;
    UITableViewCell *_templateCell;
#ifdef RACSupport
    RACCommand      *_disSelection;
#endif
}

#ifdef RACSupport
+ (instancetype) bindingForTableView:(UITableView *)tableView
                        sourceSignal:(RACSignal *)source
                 didSelectionCommand:(RACCommand *)didSelection
                        templateCell:(UINib *)templateCellNib;

+ (instancetype) bindingForTableView:(UITableView *)tableView
                        sourceSignal:(RACSignal *)source
                 didSelectionCommand:(RACCommand *)didSelection
               templateCellClassName:(NSString *)classCell;
#endif

- (UITableViewCell *)dequeueCellAndBindInTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
