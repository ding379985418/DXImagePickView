//
//  DXImagePickView.h
//  DXImagePickController
//
//  Created by simon on 16/7/1.
//  Copyright © 2016年 DINGXU. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DXImagePickView;
@protocol DXImagePickViewDelegate <NSObject>
@optional
///点击发送按钮的代理方法得到照片
- (void)imagePickView:(DXImagePickView *)imagePickView didSendImages:(NSArray *)images;
;
@end
@interface DXImagePickView : UIView
///imagePickView 代理
@property (nonatomic, weak) id<DXImagePickViewDelegate> delegate;

+ (instancetype)imagePickView;

@end
