//
//  ZYReaderKitConstance.h
//  Pods
//
//  Created by luzhiyong on 2017/7/7.
//
//

#ifndef ZYReaderKitConstance_h
#define ZYReaderKitConstance_h

// 文档目录
#define kApplicationDocumentsDirectory [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

// weakself 快捷方法
#define WS(weakSelf)    __weak __typeof(&*self)weakSelf = self

// 字符串匹配对比
#define IsEqualString(x,y) [x isEqualToString:y]

// 手机尺寸
#define SCREEN_WIDTH  CGRectGetWidth([UIScreen mainScreen].bounds)
#define SCREEN_HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)

#endif /* ZYReaderKitConstance_h */
