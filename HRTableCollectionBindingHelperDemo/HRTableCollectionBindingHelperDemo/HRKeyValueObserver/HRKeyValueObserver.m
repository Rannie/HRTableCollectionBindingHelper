//
//  HRKeyValueObserver.m
//  ReactiveDemo
//
//  Created by Ran on 14-9-11.
//  Copyright (c) 2014年 ran. All rights reserved.
//

#import "HRKeyValueObserver.h"
#import <objc/message.h>

typedef NS_ENUM(NSInteger, OBSERVER_TYPE) {
    OBSERVER_TYPE_SINGLE    =   0x01,
    OBSERVER_TYPE_LIST,
    OBSERVER_TYPE_MAP
};

@interface HRKeyValueObserver ()

@property (nonatomic, strong) id target;
@property (nonatomic, strong) id observedObject;
@property (nonatomic) SEL selector;
@property (nonatomic, assign) OBSERVER_TYPE observType;
@property (nonatomic, strong) NSDictionary *keypathSelMap;

@end

@implementation HRKeyValueObserver

- (instancetype)initWithObject:(id)object target:(id)target
{
    NSAssert(object != nil && target != nil, @"Observer must have observed object and target!");
    self = [super init];
    if (self) {
        self.observedObject = object;
        self.target = target;
    }
    return self;
}

- (instancetype)initWithObject:(id)object keyPathList:(NSArray *)keyPaths target:(id)target selector:(SEL)selector
{
    NSAssert(keyPaths != nil && selector != nil, @"Observer must have keypath list and performed selector");
    self = [self initWithObject:object target:target];
    if (self) {
        self.observType = OBSERVER_TYPE_LIST;
        self.selector = selector;
        for (NSString *keyPath in keyPaths) {
            [self.observedObject addObserver:self
                                  forKeyPath:keyPath
                                     options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld)
                                     context:(__bridge void *)(self)];
        }
    }
    return self;
}

- (instancetype)initWithObject:(id)object keyPath:(NSString *)keyPath target:(id)target selector:(SEL)selector
{
    NSAssert(keyPath != nil && selector != nil, @"Observer must have keypath and performed selector");
    self = [self initWithObject:object target:target];
    if (self) {
        self.observType = OBSERVER_TYPE_SINGLE;
        self.selector = selector;
        [self.observedObject addObserver:self
                              forKeyPath:keyPath
                                 options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld)
                                 context:(__bridge void *)(self)];
    }
    return self;
}

- (instancetype)initWithObject:(id)object keyPathSelectorMap:(NSDictionary *)map target:(id)target
{
    NSAssert(map != nil, @"Observer must have a keypath-selector map");
    self = [self initWithObject:object target:target];
    if (self) {
        self.observType = OBSERVER_TYPE_MAP;
        self.keypathSelMap = map;
        for (NSString *keyPath in map.allKeys) {
            [self.observedObject addObserver:self
                                  forKeyPath:keyPath
                                     options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld)
                                     context:(__bridge void *)(self)];
        }
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == (__bridge void *)(self)) {
        NSLog(@"[func : %@] change : %@", NSStringFromSelector(_cmd), change);
        
        id observeTarget = self.target;
        if (self.observType == OBSERVER_TYPE_SINGLE || self.observType == OBSERVER_TYPE_LIST) {
            if ([observeTarget respondsToSelector:self.selector]) {
                objc_msgSend(observeTarget, self.selector);
            }
        } else {
            SEL selector = NSSelectorFromString(self.keypathSelMap[keyPath]);
            if ([observeTarget respondsToSelector:selector]) {
                objc_msgSend(observeTarget, selector);
            }
        }
    }
}

- (void)dealloc
{
    [self.observedObject removeObserver:self];
}

@end
