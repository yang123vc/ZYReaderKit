//
//  ZYResources.m
//  Pods
//
//  Created by luzhiyong on 2017/7/6.
//
//

#import "ZYResources.h"

@implementation ZYResources

- (void)addResource:(ZYResource *)resource {
    [self.resources setObject:resource forKey:resource.href];
}

- (ZYResource *)findByMediaType:(MediaType *)mediaType {
    for (ZYResource *resource in _resources.allValues) {
        if (resource.mediaType != nil && [resource.mediaType isEqual:mediaType]) {
            return resource;
        }
    }
    return nil;
}

- (ZYResource *)findByExtension:(NSString *)extension {
    for (ZYResource *resource in _resources.allValues) {
        if (resource.mediaType != nil && [resource.mediaType.defaultExtension isEqualToString:extension]) {
            return resource;
        }
    }
    return nil;
}

- (ZYResource *)findByProperty:(NSString *)property {
    for (ZYResource *resource in _resources.allValues) {
        if ([resource.properties isEqualToString:property]) {
            return resource;
        }
    }
    return nil;
}

- (ZYResource *)findById:(NSString *)resourceID {
    for (ZYResource *resource in _resources.allValues) {
        if ([resource.bID isEqualToString:resourceID]) {
            return resource;
        }
    }
    return nil;
}

- (BOOL)containsByHref:(NSString *)href {
    return [_resources.allKeys containsObject:href];
}

- (BOOL)containsById:(NSString *)resourceID {
    for (ZYResource *resource in _resources.allValues) {
        if ([resource.bID isEqualToString:resourceID]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - Getter

- (NSMutableDictionary *)resources {
    if (!_resources) {
        _resources = [[NSMutableDictionary alloc] init];
    }
    return _resources;
}

@end
