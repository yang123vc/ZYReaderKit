//
//  ZYResource.h
//  Pods
//
//  Created by luzhiyong on 2017/7/6.
//
//

#import <Foundation/Foundation.h>

#import "ZYMediaType.h"

@interface ZYResource : NSObject

@property (nonatomic, strong) NSString *bID;

@property (nonatomic, strong) NSString *properties;

@property (nonatomic, strong) NSString *href;

@property (nonatomic, strong) NSString *fullHref;

@property (nonatomic, strong) MediaType *mediaType;

@property (nonatomic, strong) NSString *mediaOverlay;

@end
