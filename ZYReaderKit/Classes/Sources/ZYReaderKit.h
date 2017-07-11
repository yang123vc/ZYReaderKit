//
//  ZYReaderKit.h
//  Pods
//
//  Created by luzhiyong on 2017/7/6.
//
//

#import <Foundation/Foundation.h>

@interface ZYReaderKit : NSObject

+ (UIImage *)getCoverImage:(NSString *)epubPath unzipPath:(NSString *)unzipPath;

+ (NSString *)getTitle:(NSString *)epubPath unzipPath:(NSString *)unzipPath;

+ (NSString *)getAuthorName:(NSString *)epubPath unzipPath:(NSString *)unzipPath;

- (void)presentReader:(UIViewController *)parentViewController epubPath:(NSString *)epubPath;

@end
