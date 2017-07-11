//
//  ZYBook.m
//  Pods
//
//  Created by luzhiyong on 2017/7/6.
//
//

#import "ZYBook.h"

@implementation ZYBook

- (id)init {
    if (self = [super init]) {
        _resources = [[ZYResources alloc] init];
        _metadata = [[ZYMetadata alloc] init];
        _spine = [[ZYSpine alloc] init];
    }
    return self;
}

@end
