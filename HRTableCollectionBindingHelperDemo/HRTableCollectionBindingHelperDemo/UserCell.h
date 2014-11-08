//
//  UserCell.h
//  HRTableCollectionBindingHelperDemo
//
//  Created by Rannie on 14/11/8.
//  Copyright (c) 2014年 Rannie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BindViewDelegate.h"

@interface UserCell : UITableViewCell <BindViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;

- (void)bindModel:(id)model;

@end
