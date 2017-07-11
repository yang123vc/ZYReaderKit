//
//  ZYEpubParser.h
//  Pods
//
//  Created by luzhiyong on 2017/7/6.
//
//

#import <Foundation/Foundation.h>

#import "ZYBook.h"

@interface ZYEpubParser : NSObject

- (UIImage *)parseCoverImage:(NSString *)epubPath unzipPath:(NSString *)unzipPath;

- (NSString *)parseTitle:(NSString *)epubPath;

- (NSString *)parseAuthorName:(NSString *)epubPath;

- (ZYBook *)readEpub:(NSString *)epubPath unzipPath:(NSString *)unzipPath;

@end
