//
//  UserCell.m
//  HRTableCollectionBindingHelperDemo
//
//  Created by Rannie on 14/11/8.
//  Copyright (c) 2014年 Rannie. All rights reserved.
//

#import "UserCell.h"
#import "User.h"

@implementation UserCell

- (void)bindModel:(User *)model {
    self.nameLabel.text = model.name;
    self.ageLabel.text = [NSString stringWithFormat:@"%zd", model.age];
}

@end
