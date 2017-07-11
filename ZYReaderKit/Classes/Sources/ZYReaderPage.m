//
//  ZYReaderPage.m
//  Pods
//
//  Created by luzhiyong on 2017/7/6.
//
//

#import "ZYReaderPage.h"

@implementation ZYReaderPage

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    [self.contentView addSubview:self.webView];
    self.webView.scrollView.pagingEnabled = YES;
    self.webView.paginationMode = UIWebPaginationModeLeftToRight;
    self.webView.paginationBreakingMode = UIWebPaginationBreakingModePage;
    self.webView.scrollView.bounces = NO;
    self.webView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture)];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.delegate = self;
    [self.webView addGestureRecognizer:tapGesture];
}

- (void)loadHTMLString:(NSString *)htmlContent baseURL:(NSURL *)baseURL {
    [_webView loadHTMLString:htmlContent baseURL:baseURL];
}

- (void)handleTapGesture {
    if (self.toggleBars) {
        self.toggleBars();
    }
}

#pragma mark - Gesture Recognizer

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(nonnull UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

#pragma mark - Getter

- (ZYReaderWebView *)webView {
    if (!_webView) {
        _webView = [[ZYReaderWebView alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - 40)];
    }
    return _webView;
}

@end
