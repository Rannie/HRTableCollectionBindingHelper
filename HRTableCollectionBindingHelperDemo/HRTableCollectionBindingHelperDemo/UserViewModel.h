//
//  UserViewModel.h
//  HRTableCollectionBindingHelperDemo
//
//  Created by Rannie on 14/11/8.
//  Copyright (c) 2014年 Rannie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserViewModel : NSObject
@property (nonatomic, strong) NSArray *userList;

- (void)fetchUsers;
@end
