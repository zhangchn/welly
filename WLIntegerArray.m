//
//  XIIntegerArray.m
//  Welly
//
//  Created by boost on 7/28/08.
//  Copyright 2008 Xi Wang. All rights reserved.
//

#import "WLIntegerArray.h"


@implementation WLIntegerArray

+ (instancetype) integerArray {
    return [[WLIntegerArray alloc] init];
}

- (instancetype)init {
    if (self = [super init]) {
        [self clear];
    }
    return self;
}


- (void)push_back:(NSInteger)integer {
    [_array addPointer:(void *)integer];
}

- (void)pop_front {
    [_array removePointerAtIndex:0];
}

- (NSInteger)at:(NSUInteger)index {
    return (NSInteger)[_array pointerAtIndex:index];
}

- (void)set:(NSInteger)value at:(NSUInteger)index {
    [_array replacePointerAtIndex:index withPointer:(void *)value];
}

- (NSInteger)front {
    return [self at:0];
}

- (BOOL)empty {
    return _array.count == 0;
}

- (NSUInteger)size {
    return _array.count;
}

- (void)clear {
    NSPointerFunctionsOptions options = NSPointerFunctionsOpaqueMemory|NSPointerFunctionsIntegerPersonality;
    _array = [NSPointerArray pointerArrayWithOptions:options];
}

@end
