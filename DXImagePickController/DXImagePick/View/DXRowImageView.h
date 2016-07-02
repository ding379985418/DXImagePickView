//
//  DXRowImageView.h
//  DXImagePickController
//
//  Created by simon on 16/7/1.
//  Copyright © 2016年 DINGXU. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DXRowImageView;
@protocol DXRowImageViewDelegate <NSObject>
@optional
/// 选择或取消选择照片的代理方法
- (void)rowImageView:(DXRowImageView *)collectionView didSeletectedArray:(NSArray *)array;
;
@end

@interface DXRowImageView : UICollectionView
@property(nonatomic, strong) NSArray *dataArray;
@property (nonatomic, weak) id<DXRowImageViewDelegate> rowImageViewDelegate;

+ (instancetype)rowImageViewWithFrame:(CGRect)frame;
- (void)removeAllSeletedImage;
@end
