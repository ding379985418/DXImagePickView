//
//  DXLoadImageTool.h
//  DXImagePickController
//
//  Created by simon on 16/7/1.
//  Copyright © 2016年 DINGXU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXLoadImageTool : NSObject
///获取相册图片
+ (void)loadImagesFromCamerarollSucess:(void(^)(NSArray *images))sucessBlock failure:(void(^)(NSError *error))failureBlock;
///获取所有照片
+ (void)loadAllPhotoSucess:(void(^)(NSArray *photos))sucessBlock failure:(void(^)(NSError *error))failureBlock;
@end
