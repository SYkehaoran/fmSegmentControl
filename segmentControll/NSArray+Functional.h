//
//  NSArray+Functional.h
//  HXHQT
//
//  Created by 柯浩然 on 2017/1/9.
//  Copyright © 2017年 wangyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Functional)
/**
 *一个数组通过一定的运算法则转化为另一个数组，这两个数组里的元素个数是一样的，但是元素类型是可以不一样的
 */
- (NSArray *)map:(id (^) (id obj))block;

/**
 *一个数组通过一定的运算法则过滤掉相应的元素，成为另一个数组，这两个数组里的元素个数是不一样的，但是元素类型是一样的
 */
- (NSArray *)filter:(BOOL (^) (id obj))block;



@end
