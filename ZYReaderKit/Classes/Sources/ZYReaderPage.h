//
//  ZYReaderPage.h
//  Pods
//
//  Created by luzhiyong on 2017/7/6.
//
//

#import <UIKit/UIKit.h>

#import "ZYReaderWebView.h"

#import "ZYBook.h"

#define CellIdentifier_ZYReaderPage  @"CellIdentifier_ZYReaderPage"

@interface ZYReaderPage : UICollectionViewCell<UIGestureRecognizerDelegate>

@property (nonatomic, strong) ZYReaderWebView *webView;

@property (nonatomic, copy) void (^toggleBars)();

- (void)loadHTMLString:(NSString *)htmlContent baseURL:(NSURL *)baseURL;

@end
