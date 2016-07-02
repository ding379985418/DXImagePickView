//
//  DXPhotoGroupModel.h
//  DXImagePickController
//
//  Created by simon on 16/7/2.
//  Copyright © 2016年 DINGXU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXPhotoGroupModel : NSObject
///照片分组名称
@property (nonatomic, copy) NSString *groupName;
//照片数组
@property (nonatomic, strong) NSArray *images;
@end
