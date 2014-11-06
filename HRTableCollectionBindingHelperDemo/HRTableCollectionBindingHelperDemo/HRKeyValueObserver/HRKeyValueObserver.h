//
//  HRKeyValueObserver.h
//  ReactiveDemo
//
//  Created by Ran on 14-9-11.
//  Copyright (c) 2014年 ran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HRKeyValueObserver : NSObject

- (instancetype)initWithObject:(id)object keyPath:(NSString *)keyPath target:(id)target selector:(SEL)selector;
- (instancetype)initWithObject:(id)object keyPathList:(NSArray *)keyPaths target:(id)target selector:(SEL)selector;
- (instancetype)initWithObject:(id)object keyPathSelectorMap:(NSDictionary *)map target:(id)target;

@end
