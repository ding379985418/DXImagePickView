//
//  DXLoadImageTool.m
//  DXImagePickController
//
//  Created by simon on 16/7/1.
//  Copyright © 2016年 DINGXU. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "DXLoadImageTool.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIImage+Category.h"
#import "DXImagePickModel.h"
#import "DXPhotoGroupModel.h"
@implementation DXLoadImageTool
+ (void)loadImagesFromCamerarollSucess:(void(^)(NSArray *images))sucessBlock failure:(void(^)(NSError *error))failureBlock{

    ALAssetsLibrary *library = [ALAssetsLibrary new];
    [library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
      NSString *groupName =(NSString *)[group valueForProperty:ALAssetsGroupPropertyName];
        NSLog(@"%@",groupName);
        if ([groupName isEqualToString:@"相机胶卷"] ||[groupName isEqualToString:@"Camera Roll"]) {
            
          NSArray *imagesArray = [self getImagesFromGroup:group];
            if (sucessBlock) {
                sucessBlock(imagesArray);
            }
            
        }
        
    } failureBlock:^(NSError *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];

}
///获取所有照片
+ (void)loadAllPhotoSucess:(void(^)(NSArray *photos))sucessBlock failure:(void(^)(NSError *error))failureBlock{
    ALAssetsLibrary *library = [ALAssetsLibrary new];
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:10];
    __block NSInteger count = 0;
    [library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        NSString *groupName =(NSString *)[group valueForProperty:ALAssetsGroupPropertyName];
        NSLog(@"groupName:%@",groupName);
        if (groupName) {
            DXPhotoGroupModel *model = [DXPhotoGroupModel new];
            model.groupName = groupName;
            model.images =  [self getImagesFromGroup:group];
            [arrayM addObject:model];
        }
         count ++;
        if (count != arrayM.count) {
            if (sucessBlock) {
                sucessBlock([[arrayM reverseObjectEnumerator] allObjects]);
            }
        }
        
      
    } failureBlock:^(NSError *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];

}

+ (NSArray *)getImagesFromGroup:(ALAssetsGroup *)group{
    NSMutableArray *imagesArray = [NSMutableArray arrayWithCapacity:10];
    
    [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        
        UIImage *image = [UIImage imageWithCGImage:[result aspectRatioThumbnail]];
        
        if (image) {
            image = [image imageCompressForHeight:image targetHeight:150];
            DXImagePickModel *model = [DXImagePickModel new];
            model.image = image;
            model.count = 0;
            [imagesArray addObject:model];
        }
        
    }];
    return [imagesArray copy];
}

@end
