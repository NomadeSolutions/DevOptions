//
//  XFATPosition.m
//  XFAssistiveTouchExample
//
//  Created by 徐亚非 on 2016/9/24.
//  Copyright © 2016年 XuYafei. All rights reserved.
//

#import "XFATPosition.h"

@implementation XFATPosition

+ (instancetype)positionWithIndex:(NSInteger)index {
    return [[self alloc] initWithIndex:index];
}

- (instancetype)init {
    return [self initWithIndex:0];
}

- (instancetype)initWithIndex:(NSInteger)index {
    self = [super init];
    if (self) {
        _index = index < 0? 0: index;
        _frame = [self getFrame];
    }
    return self;
}

- (CGRect)getFrame {
    CGRect frame = CGRectMake(
                              [XFATLayoutAttributes contentViewSpreadFrame].origin.x + [XFATLayoutAttributes itemMargin],
                              self.index * [XFATLayoutAttributes itemHeight] + [XFATLayoutAttributes contentViewSpreadFrame].origin.y + (self.index + 1) * [XFATLayoutAttributes itemMargin],
                              [XFATLayoutAttributes itemWidth],
                              [XFATLayoutAttributes itemHeight]);
    return frame;
}

@end
