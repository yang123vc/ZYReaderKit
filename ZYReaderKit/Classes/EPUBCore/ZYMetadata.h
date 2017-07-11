//
//  ZYMetadata.h
//  Pods
//
//  Created by luzhiyong on 2017/7/7.
//
//

#import <Foundation/Foundation.h>

@interface Author : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *role;

@property (nonatomic, strong) NSString *fileAs;

- (id)initWithName:(NSString *)name role:(NSString *)role fileAs:(NSString *)fileAs;

@end

@interface Identifier : NSObject

@property (nonatomic, strong) NSString *identifier;

@property (nonatomic, strong) NSString *scheme;

@property (nonatomic, strong) NSString *value;

- (id)initWithId:(NSString *)identifier scheme:(NSString *)scheme value:(NSString *)value;

@end

@interface Date : NSObject

@property (nonatomic, strong) NSString *date;

@property (nonatomic, strong) NSString *event;

- (id)initWithDate:(NSString *)date event:(NSString *)event;

@end

@interface Meta : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *content;

@property (nonatomic, strong) NSString *mID;

@property (nonatomic, strong) NSString *property;

@property (nonatomic, strong) NSString *value;

@property (nonatomic, strong) NSString *refines;

- (id)initWithName:(NSString *)name content:(NSString *)content;

- (id)initWithId:(NSString *)mID property:(NSString *)property value:(NSString *)value;

- (id)initWithProperty:(NSString *)property value:(NSString *)value refines:(NSString *)refines;

@end

@interface ZYMetadata : NSObject

@property (nonatomic, strong) NSMutableArray <Author *> *creators;

@property (nonatomic, strong) NSMutableArray <Author *> *contributors;

@property (nonatomic, strong) NSMutableArray <Date *> *dates;

@property (nonatomic, strong) NSString *language;

@property (nonatomic, strong) NSMutableArray <NSString *> *titles;

@property (nonatomic, strong) NSMutableArray <Identifier *> *identifiers;

@property (nonatomic, strong) NSMutableArray <NSString *> *subjects;

@property (nonatomic, strong) NSMutableArray <NSString *> *descriptions;

@property (nonatomic, strong) NSMutableArray <NSString *> *publishers;

@property (nonatomic, strong) NSMutableArray *format;

@property (nonatomic, strong) NSMutableArray <NSString *> *rights;

@property (nonatomic, strong) NSMutableArray <Meta *> *metaAttributes;

- (NSString *)findIdentifierById:(NSString *)bID;

- (NSString *)findMetaByName:(NSString *)name;

- (NSString *)findMetaByProperty:(NSString *)property;

- (NSString *)findMetaByProperty:(NSString *)property refinedBy:(NSString *)refine;


@end
