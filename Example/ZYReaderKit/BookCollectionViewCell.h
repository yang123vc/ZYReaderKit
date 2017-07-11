//
//  BookCollectionViewCell.h
//  ZYReaderKit
//
//  Created by luzhiyong on 2017/7/11.
//  Copyright © 2017年 luzhiyongGit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) NSString *bookName;

@property (nonatomic, strong) NSString *bookPath;

@property (nonatomic, strong) UIImage *bookCover;

@property (weak, nonatomic) IBOutlet UIImageView *bookImageView;

@end
