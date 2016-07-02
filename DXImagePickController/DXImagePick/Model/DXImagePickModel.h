//
//  DXImagePickModel.h
//  DXImagePickController
//
//  Created by simon on 16/7/1.
//  Copyright © 2016年 DINGXU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DXImagePickModel : NSObject
///图片
@property (nonatomic, strong) UIImage *image;
///被选中的个数
@property (nonatomic, assign) NSInteger count;
///记录collection的contOffset
@property (nonatomic, assign) CGPoint offset;
@end
