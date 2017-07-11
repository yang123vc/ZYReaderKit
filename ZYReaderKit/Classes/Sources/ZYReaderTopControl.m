//
//  ZYReaderTopControl.m
//  Pods
//
//  Created by luzhiyong on 2017/7/11.
//
//

#import "ZYReaderTopControl.h"

@interface ZYReaderTopControl ()

@property (nonatomic, strong) UIButton *backButton;

@end

@implementation ZYReaderTopControl

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        [self addSubview:self.backButton];
    }
    return self;
}

- (void)setupViews {
    [self addSubview:self.backButton];
}

#pragma mark - Action

- (void)backButtonAction:(id)sender {
    if (self.backBlock) {
        self.backBlock();
    }
}

#pragma mark - Getter
- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(20, 20, 60, 30);
        _backButton.backgroundColor = [UIColor orangeColor];
        [_backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

@end
