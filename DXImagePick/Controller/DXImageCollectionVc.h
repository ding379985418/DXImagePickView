//
//  DXImageCollectionVc.h
//  DXImagePickController
//
//  Created by simon on 16/7/2.
//  Copyright © 2016年 DINGXU. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DXPhotoGroupModel;
@interface DXImageCollectionVc : UICollectionViewController
///照片组模型
@property (nonatomic, strong) DXPhotoGroupModel *groupModel;

+ (instancetype)imageCollectionVc;
@end
