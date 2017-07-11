//
//  ZYTocReference.h
//  Pods
//
//  Created by luzhiyong on 2017/7/10.
//
//

#import <Foundation/Foundation.h>

#import "ZYResource.h"

@interface ZYTocReference : NSObject

@property (nonatomic, strong) ZYResource *resource;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *fragmentID;
@property (nonatomic, strong) NSArray <ZYTocReference *> *children;

- (id)initWithTitle:(NSString *)title resource:(ZYResource *)resource fragmentID:(NSString *)fragmentID;

- (id)initWithTitle:(NSString *)title resource:(ZYResource *)resource fragmentID:(NSString *)fragmentID children:(NSArray *)children;

@end
