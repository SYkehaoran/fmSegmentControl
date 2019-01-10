//
//  NSArray+Functional.m
//  HXHQT
//
//  Created by 柯浩然 on 2017/1/9.
//  Copyright © 2017年 China Asset Management Co., Ltd. All rights reserved.
//

#import "NSArray+Functional.h"

@implementation NSArray (Functional)

- (NSArray *)map:(id (^) (id obj))block {
    NSCParameterAssert(block != NULL);
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id element = block(obj);
        if (element) {
            [array addObject:element];
        }
    }];
    return array;
}

- (NSArray *)filter:(BOOL (^) (id obj))block {
    NSCParameterAssert(block != NULL);
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL element = block(obj);
        if (element) {
            [array addObject:obj];
        }
    }];
    return array;
}

@end
