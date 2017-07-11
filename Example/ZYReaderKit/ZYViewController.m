//
//  ZYViewController.m
//  ZYReaderKit
//
//  Created by luzhiyongGit on 07/06/2017.
//  Copyright (c) 2017 luzhiyongGit. All rights reserved.
//

#import "ZYViewController.h"

#import "BookCollectionViewCell.h"

#import <ZYReaderKit/ZYReaderKit.h>

@interface ZYViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *books;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ZYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _books = @[@"不是每个故事都有结局", @"我们都一样，年轻又彷徨（标准）", @"我的遥远的清平湾：插图版", @"夏天的玫瑰：插图版", @"The Silver Chair"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource && UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _books.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    BookCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    NSString *bookName = _books[indexPath.row];
    cell.bookName = bookName;
    cell.bookPath = [[NSBundle mainBundle] pathForResource:bookName ofType:@"epub"];
    cell.bookCover = [ZYReaderKit getCoverImage:cell.bookPath unzipPath:nil];
    cell.bookImageView.image = cell.bookCover;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    BookCollectionViewCell *cell = (BookCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSString *bookPath = cell.bookPath;
    ZYReaderKit *reader = [[ZYReaderKit alloc] init];
    [reader presentReader:self epubPath:bookPath];
}

@end
