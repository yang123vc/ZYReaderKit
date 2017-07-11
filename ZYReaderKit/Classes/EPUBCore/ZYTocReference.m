//
//  ZYTocReference.m
//  Pods
//
//  Created by luzhiyong on 2017/7/10.
//
//

#import "ZYTocReference.h"

@implementation ZYTocReference

- (id)initWithTitle:(NSString *)title resource:(ZYResource *)resource fragmentID:(NSString *)fragmentID {
    if (self = [super init]) {
        _resource = resource;
        _title = title;
        _fragmentID = fragmentID;
    }
    return self;
}

- (id)initWithTitle:(NSString *)title resource:(ZYResource *)resource fragmentID:(NSString *)fragmentID children:(NSArray *)children {
    if (self = [super init]) {
        _resource = resource;
        _title = title;
        _fragmentID = fragmentID;
        _children = children;
    }
    return self;
}

@end
