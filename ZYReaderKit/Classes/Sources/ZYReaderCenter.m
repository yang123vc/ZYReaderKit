//
//  ZYReaderCenter.m
//  Pods
//
//  Created by luzhiyong on 2017/7/10.
//
//

#import "ZYReaderCenter.h"

#import "ZYReaderPage.h"

#import "ZYReaderTopControl.h"

#import "ZYReaderBottomControl.h"

@interface ZYReaderCenter ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewLayout;

@property (nonatomic, strong) ZYReaderTopControl *topControl;

@property (nonatomic, strong) ZYReaderBottomControl *bottomControl;

@property (nonatomic, assign) NSInteger totalPages;

@property (nonatomic, assign) BOOL isShowControl;

@end

@implementation ZYReaderCenter

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.collectionView];
    
    [self.view addSubview:self.topControl];
    
    [self.view addSubview:self.bottomControl];
    
    [self.collectionView reloadData];
    
    _isShowControl = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Public Methods

- (void)reloadData {
    self.totalPages = self.book.spine.spineReferences.count;
    
    [self.collectionView reloadData];
    
}

#pragma mark - Private Methods

- (void)toggleControls {
    if (_isShowControl) {
        [self hideControls];
    } else {
        [self showControls];
    }
}

- (void)showControls {
    _topControl.frame = CGRectMake(0, -64, CGRectGetWidth(self.view.bounds), 64);
    _bottomControl.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds), CGRectGetWidth(self.view.bounds), 44);
    [UIView animateWithDuration:0.5f animations:^{
        _topControl.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 64);
        _bottomControl.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds) - 44, CGRectGetWidth(self.view.bounds), 44);
    } completion:^(BOOL finished) {
        _topControl.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 64);
        _bottomControl.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds) - 44, CGRectGetWidth(self.view.bounds), 44);
        _isShowControl = YES;
    }];
}

- (void)hideControls {
    _topControl.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 64);
    _bottomControl.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds) - 44, CGRectGetWidth(self.view.bounds), 44);
    [UIView animateWithDuration:0.5f animations:^{
        _topControl.frame = CGRectMake(0, -64, CGRectGetWidth(self.view.bounds), 64);
        _bottomControl.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds), CGRectGetWidth(self.view.bounds), 44);
    } completion:^(BOOL finished) {
        _topControl.frame = CGRectMake(0, -64, CGRectGetWidth(self.view.bounds), 64);
        _bottomControl.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds), CGRectGetWidth(self.view.bounds), 44);
        _isShowControl = NO;
    }];
}

#pragma mark - UICollectionViewDelegate && UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _totalPages;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZYReaderPage *reuseableCell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier_ZYReaderPage forIndexPath:indexPath];
    
    ZYResource *resource = self.book.spine.spineReferences[indexPath.row].resource;
    
    NSString *html = [NSString stringWithContentsOfFile:resource.fullHref encoding:NSUTF8StringEncoding error:nil];
    
    NSString *htmlPath = resource.fullHref;
    
    [reuseableCell loadHTMLString:html baseURL:[NSURL fileURLWithPath:[htmlPath stringByDeletingLastPathComponent]]];
    
    reuseableCell.toggleBars = ^() {
        [self toggleControls];
    };
    return reuseableCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width, collectionView.frame.size.height);
}

#pragma mark - Getter

- (UICollectionViewLayout *)collectionViewLayout {
    if (!_collectionViewLayout) {
        _collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionViewLayout.sectionInset = UIEdgeInsetsZero;
        _collectionViewLayout.minimumLineSpacing = 0;
        _collectionViewLayout.minimumInteritemSpacing = 0;
        _collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _collectionViewLayout;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.collectionViewLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [_collectionView registerClass:[ZYReaderPage class] forCellWithReuseIdentifier:CellIdentifier_ZYReaderPage];
    }
    return _collectionView;
}

- (ZYReaderTopControl *)topControl {
    if (!_topControl) {
        _topControl = [[ZYReaderTopControl alloc] initWithFrame:CGRectMake(0, -64, CGRectGetWidth(self.view.bounds), 64)];
        _topControl.backBlock = ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        };
    }
    return _topControl;
}

- (ZYReaderBottomControl *)bottomControl {
    if (!_bottomControl) {
        _bottomControl = [[ZYReaderBottomControl alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds), CGRectGetWidth(self.view.bounds), 44)];
    }
    return _bottomControl;
}

@end
