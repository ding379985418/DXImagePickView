//
//  DXImageCollectionCell.h
//  DXImagePickController
//
//  Created by simon on 16/7/1.
//  Copyright © 2016年 DINGXU. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DXImagePickModel;
@class DXImageCollectionCell;
@protocol DXImageCollectionCellDelegate <NSObject>
@optional
///点击选择照片或者取消选择的小按钮
- (void)imageCollectionCell:(DXImageCollectionCell *)collectionCell selectedButtonDidSelected:(UIButton *)selectedButton;
@end

@interface DXImageCollectionCell : UICollectionViewCell

@property (nonatomic, strong) DXImagePickModel *model;
//@property (nonatomic, assign) CGPoint offset;


@property (nonatomic, weak) id <DXImageCollectionCellDelegate>delegate;

@end
