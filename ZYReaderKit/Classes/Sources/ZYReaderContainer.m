//
//  ZYReaderContainer.m
//  Pods
//
//  Created by luzhiyong on 2017/7/10.
//
//

#import "ZYReaderContainer.h"

#import "ZYReaderCenter.h"

#import "ZYBook.h"

#import "ZYEpubParser.h"

@interface ZYReaderContainer ()

@property (nonatomic, strong) UINavigationController *centerNavigationController;

@property (nonatomic, strong) ZYReaderCenter *centerViewController;

@property (nonatomic, strong) ZYBook *book;

@end

@implementation ZYReaderContainer

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.centerViewController = [[ZYReaderCenter alloc] init];
    
    self.centerNavigationController = [[UINavigationController alloc] initWithRootViewController:_centerViewController];
    
    self.centerNavigationController.navigationBarHidden = YES;
    
    [self.view addSubview:_centerNavigationController.view];
    [self addChildViewController:_centerNavigationController];
    [self.centerNavigationController didMoveToParentViewController:self];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ZYEpubParser *parser = [[ZYEpubParser alloc] init];
        ZYBook *book = [parser readEpub:_epubPath unzipPath:nil];
        _book = book;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.centerViewController.book = _book;
            [self.centerViewController reloadData];
        });
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
