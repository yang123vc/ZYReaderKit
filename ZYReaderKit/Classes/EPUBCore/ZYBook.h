//
//  ZYBook.h
//  Pods
//
//  Created by luzhiyong on 2017/7/6.
//
//

#import <Foundation/Foundation.h>

#import "ZYResources.h"

#import "ZYResource.h"

#import "ZYMetadata.h"

#import "ZYSmils.h"

#import "ZYSpine.h"

@interface ZYBook : NSObject

@property (nonatomic, strong) ZYResources *resources;

@property (nonatomic, strong) ZYMetadata *metadata;

@property (nonatomic, strong) ZYResource *opfResource;

@property (nonatomic, strong) ZYResource *tocResource;

@property (nonatomic, strong) ZYResource *coverImage;

@property (nonatomic, strong) ZYSmils *smils;

@property (nonatomic, strong) ZYSpine *spine;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) double version;

@property (nonatomic, strong) NSString *uniqueIdentifier;

@end
