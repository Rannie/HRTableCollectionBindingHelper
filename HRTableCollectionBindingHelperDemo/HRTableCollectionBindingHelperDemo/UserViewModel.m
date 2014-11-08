//
//  UserViewModel.m
//  HRTableCollectionBindingHelperDemo
//
//  Created by Rannie on 14/11/8.
//  Copyright (c) 2014年 Rannie. All rights reserved.
//

#import "UserViewModel.h"
#import "User.h"

@implementation UserViewModel

- (void)fetchUsers {
    NSInteger count = arc4random()%20 + 1;
    
    NSMutableArray *list = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        User *user = [User new];
        user.name = [NSString stringWithFormat:@"user--%d", i];
        user.age = arc4random()%100;
        [list addObject:user];
    }
    
    self.userList = list;
}

@end
