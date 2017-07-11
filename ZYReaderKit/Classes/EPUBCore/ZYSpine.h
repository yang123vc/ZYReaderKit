//
//  ZYSpine.h
//  Pods
//
//  Created by luzhiyong on 2017/7/7.
//
//

#import <Foundation/Foundation.h>

#import "ZYResource.h"

@interface Spine : NSObject

@property (nonatomic, assign) BOOL linear;

@property (nonatomic, strong) ZYResource *resource;

- (id)initWithResource:(ZYResource *)resource linear:(BOOL)linear;

@end

@interface ZYSpine : NSObject

@property (nonatomic, strong) NSString *pageProgressionDirection;

@property (nonatomic, strong) NSMutableArray <Spine *> *spineReferences;

@property (nonatomic, assign) BOOL isRtl;

@end
