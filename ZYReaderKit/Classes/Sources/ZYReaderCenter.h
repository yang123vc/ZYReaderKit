//
//  ZYReaderCenter.h
//  Pods
//
//  Created by luzhiyong on 2017/7/10.
//
//

#import <UIKit/UIKit.h>

#import "ZYBook.h"

@interface ZYReaderCenter : UIViewController

@property (nonatomic, weak) ZYBook *book;

- (void)reloadData;

@end
