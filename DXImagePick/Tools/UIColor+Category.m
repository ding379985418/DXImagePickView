//
//  UIColor+Category.m
//  catergory
//
//  Created by No on 16/2/23.
//  Copyright © 2016年 com.beauty. All rights reserved.
//

#import "UIColor+Category.h"

@implementation UIColor (Category)
/**
 *  随机颜色
 */
+ (UIColor *)randomColor{

    return [self colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
}
/**
 *  根据GRB生成指定颜色
 */
+ (UIColor *)colorWithR:(CGFloat)R G:(CGFloat)G B:(CGFloat)B{

    return [self colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];
}
@end
