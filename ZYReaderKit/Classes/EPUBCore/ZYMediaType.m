//
//  ZYMediaType.m
//  Pods
//
//  Created by luzhiyong on 2017/7/7.
//
//

#import "ZYMediaType.h"

@implementation MediaType

- (id)initWithName:(NSString *)name defaultExtension:(NSString *)defaultExtension {
    if (self = [super init]) {
        _name = name;
        _defaultExtension = defaultExtension;
        _extensions = [[NSMutableArray alloc] initWithObjects:defaultExtension, nil];
    }
    return self;
}

- (id)initWithName:(NSString *)name defaultExtension:(NSString *)defaultExtension extensions:(NSArray *)extensions {
    if (self = [super init]) {
        _name = name;
        _defaultExtension = defaultExtension;
        _extensions = [NSMutableArray arrayWithArray:extensions];
    }
    return self;
}

@end

@implementation ZYMediaType

+ (instancetype)shareInstance {
    static ZYMediaType *_obj;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _obj = [[ZYMediaType alloc] init];
    });
    return _obj;
}

#pragma mark - Getter

- (MediaType *)XHTML {
    return [[MediaType alloc] initWithName:@"application/xhtml+xml" defaultExtension:@".xhtml" extensions:@[@".htm", @"html", @".xhtml", @".xml"]];
}

- (MediaType *)EPUB {
    return [[MediaType alloc] initWithName:@"application/epub+zip" defaultExtension:@".epub"];
}

- (MediaType *)NCX {
    return [[MediaType alloc] initWithName:@"application/x-dtbncx+xml" defaultExtension:@".ncx"];
}

@end
