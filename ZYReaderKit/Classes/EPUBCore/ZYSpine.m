//
//  ZYSpine.m
//  Pods
//
//  Created by luzhiyong on 2017/7/7.
//
//

#import "ZYSpine.h"

@implementation Spine

- (id)initWithResource:(ZYResource *)resource linear:(BOOL)linear {
    if (self = [super init]) {
        _resource = resource;
        _linear = linear;
    }
    return self;
}

@end

@implementation ZYSpine

- (ZYResource *)nextChapter:(NSString *)href {
    BOOL found = NO;
    
    for (Spine *item in _spineReferences) {
        if (found) {
            return item.resource;
        }
        
        if ([item.resource.href isEqualToString:href]) {
            found = YES;
        }
    }
    return nil;
}

#pragma mark - Getter

- (BOOL)isRtl {
    if ([_pageProgressionDirection isEqualToString:@"rtl"]) {
        return YES;
    }
    return NO;
}

- (NSMutableArray *)spineReferences {
    if (!_spineReferences) {
        _spineReferences = [NSMutableArray new];
    }
    return _spineReferences;
}

@end
