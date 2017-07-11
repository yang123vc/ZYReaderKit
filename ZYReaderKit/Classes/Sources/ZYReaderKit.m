//
//  ZYReaderKit.m
//  Pods
//
//  Created by luzhiyong on 2017/7/6.
//
//

#import "ZYReaderKit.h"

#import "ZYEpubParser.h"

#import "ZYReaderContainer.h"

@implementation ZYReaderKit


#pragma mark - 图片封面

+ (UIImage *)getCoverImage:(NSString *)epubPath unzipPath:(NSString *)unzipPath{
    ZYEpubParser *parser = [[ZYEpubParser alloc] init];
    return [parser parseCoverImage:epubPath unzipPath:unzipPath];
}

+ (NSString *)getTitle:(NSString *)epubPath unzipPath:(NSString *)unzipPath {
    return nil;
}

+ (NSString *)getAuthorName:(NSString *)epubPath unzipPath:(NSString *)unzipPath {
    return nil;
}

- (void)presentReader:(UIViewController *)parentViewController epubPath:(NSString *)epubPath {
    ZYReaderContainer *readerContainer = [[ZYReaderContainer alloc] init];
    readerContainer.epubPath = epubPath;
    [parentViewController presentViewController:readerContainer animated:YES completion:nil];
}

@end
