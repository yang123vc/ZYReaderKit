//
//  ZYMetadata.m
//  Pods
//
//  Created by luzhiyong on 2017/7/7.
//
//

#import "ZYMetadata.h"

@implementation Author

- (id)initWithName:(NSString *)name role:(NSString *)role fileAs:(NSString *)fileAs {
    if (self = [super init]) {
        _name = name;
        _role = role;
        _fileAs = fileAs;
    }
    return self;
}

@end

@implementation Identifier

- (id)initWithId:(NSString *)identifier scheme:(NSString *)scheme value:(NSString *)value {
    self = [super init];
    if (self) {
        _identifier = identifier;
        _scheme = scheme;
        _value = value;
    }
    return self;
}

@end

@implementation Date

- (id)initWithDate:(NSString *)date event:(NSString *)event {
    if (self = [super init]) {
        _date = date;
        _event = event;
    }
    return self;
}

@end

@implementation Meta

- (id)initWithName:(NSString *)name content:(NSString *)content {
    if (self = [super init]) {
        _name = name;
        _content = content;
    }
    return self;
}

- (id)initWithId:(NSString *)mID property:(NSString *)property value:(NSString *)value {
    if (self = [super init]) {
        _mID = mID;
        _property = property;
        _value = value;
    }
    return self;
}

- (id)initWithProperty:(NSString *)property value:(NSString *)value refines:(NSString *)refines {
    if (self = [super init]) {
        _property = property;
        _value = value;
        _refines = refines;
    }
    return self;
}

@end

@implementation ZYMetadata

- (id)init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _creators = [NSMutableArray new];
    _contributors = [NSMutableArray new];
    _dates = [NSMutableArray new];
    _language = @"en-US";
    _titles = [NSMutableArray new];
    _identifiers = [NSMutableArray new];
    _subjects = [NSMutableArray new];
    _descriptions = [NSMutableArray new];
    _publishers = [NSMutableArray new];
    _format = [NSMutableArray new];
    _rights = [NSMutableArray new];
    _metaAttributes = [NSMutableArray new];
}

- (NSString *)findIdentifierById:(NSString *)bID {
    for (Identifier *identifier in _identifiers) {
        if ([identifier.identifier isEqualToString:bID]) {
            return identifier.value;
        }
    }
    return nil;
}

- (NSString *)findMetaByName:(NSString *)name {
    for (Meta *meta in _metaAttributes) {
        if ([meta.name isEqualToString:name]) {
            return meta.content;
        }
    }
    return nil;
}

- (NSString *)findMetaByProperty:(NSString *)property {
    return [self findMetaByProperty:property refinedBy:nil];
}

- (NSString *)findMetaByProperty:(NSString *)property refinedBy:(NSString *)refine {
    for (Meta *meta in _metaAttributes) {
        if (meta.property != nil) {
            if ([meta.property isEqualToString:property] && refine == nil && meta.refines == nil) {
                return meta.value;
            }
            if (meta.property == property && [meta.refines isEqualToString:refine]) {
                return meta.value;
            }
        }
    }
    return nil;
}

@end
