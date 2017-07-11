//
//  ZYMediaType.h
//  Pods
//
//  Created by luzhiyong on 2017/7/7.
//
//

#import <Foundation/Foundation.h>

#define ZYMediaTypeInstance [ZYMediaType shareInstance]

@interface MediaType : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *defaultExtension;

@property (nonatomic, strong) NSMutableArray *extensions;

- (id)initWithName:(NSString *)name defaultExtension:(NSString *)defaultExtension;

- (id)initWithName:(NSString *)name defaultExtension:(NSString *)defaultExtension extensions:(NSArray *)extensions;

@end

@interface ZYMediaType : NSObject

@property (nonatomic, strong) MediaType *XHTML;

@property (nonatomic, strong) MediaType *EPUB;

@property (nonatomic, strong) MediaType *NCX;

@property (nonatomic, strong) MediaType *OPF;

@property (nonatomic, strong) MediaType *JAVASCRIPT;

@property (nonatomic, strong) MediaType *CSS;

@property (nonatomic, strong) MediaType *JPG;

@property (nonatomic, strong) MediaType *PNG;

@property (nonatomic, strong) MediaType *GIF;

@property (nonatomic, strong) MediaType *SVG;

@property (nonatomic, strong) MediaType *TTF;

@property (nonatomic, strong) MediaType *TTF1;

@property (nonatomic, strong) MediaType *TTF2;

@property (nonatomic, strong) MediaType *OPENTYPE;

@property (nonatomic, strong) MediaType *WOFF;

@property (nonatomic, strong) MediaType *MP3;

@property (nonatomic, strong) MediaType *MP4;

@property (nonatomic, strong) MediaType *OGG;

@property (nonatomic, strong) MediaType *SMIL;

@property (nonatomic, strong) MediaType *XPGT;

@property (nonatomic, strong) MediaType *PLS;

@property (nonatomic, strong) NSArray   *mediatypes;

+ (instancetype)shareInstance;

- (MediaType *)mediaTypeByName:(NSString *)name fileName:(NSString *)fileName;

- (BOOL)isBitmapImage:(MediaType *)mediaType;

- (MediaType *)determineMediaType:(NSString *)fileName;

@end
