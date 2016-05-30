//
//  UIColor+Hex.h
//  i美工
//
//  Created by 柴炫炫 on 16/4/27.
//  Copyright © 2016年 柴炫炫. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIColor (Hex)

// 默认alpha位1
+ (UIColor *)colorWithHexString:(NSString *)hexString;

// 从十六进制字符串获取颜色，
// color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

@end
