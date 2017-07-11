//
//  ZYResources.h
//  Pods
//
//  Created by luzhiyong on 2017/7/6.
//
//

#import <Foundation/Foundation.h>

#import "ZYResource.h"

@interface ZYResources : NSObject

@property (nonatomic, strong) NSMutableDictionary *resources;

- (void)addResource:(ZYResource *)resource;

- (ZYResource *)findByMediaType:(MediaType *)mediaType;

- (ZYResource *)findByExtension:(NSString *)extension;

- (ZYResource *)findByProperty:(NSString *)property;

- (ZYResource *)findByHref:(NSString *)href;

- (ZYResource *)findById:(NSString *)resourceID;

- (BOOL)containsByHref:(NSString *)href;

- (BOOL)containsById:(NSString *)resourceID;

@end
