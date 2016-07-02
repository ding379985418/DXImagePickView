//
//  DXRowImageView.m
//  DXImagePickController
//
//  Created by simon on 16/7/1.
//  Copyright © 2016年 DINGXU. All rights reserved.
//

#import "DXRowImageView.h"
#import "DXImageCollectionCell.h"
#import "DXImagePickModel.h"
@interface DXRowImageView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,DXImageCollectionCellDelegate>
@property (nonatomic, strong) NSMutableArray *seletedArray;



@end
@implementation DXRowImageView
NSString *cellId = @"collectionCell";
+ (instancetype )rowImageViewWithFrame:(CGRect)frame{
    return [[self alloc]initWithFrame:frame collectionViewLayout:nil];
}


- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{

    UICollectionViewFlowLayout *fowlayout = [[UICollectionViewFlowLayout alloc]init];
    fowlayout.itemSize = CGSizeMake(150, 150);
    fowlayout.minimumInteritemSpacing = 4;
    fowlayout.minimumLineSpacing = 4;
    fowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self = [super initWithFrame:frame collectionViewLayout:fowlayout];
    self.backgroundColor = [UIColor clearColor];
    self.autoresizingMask = UIViewAutoresizingNone;
    [self registerClass:[DXImageCollectionCell class] forCellWithReuseIdentifier:cellId];
    self.delegate = self;
    self.dataSource = self;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    self.contentInset = UIEdgeInsetsMake(0, 0, 0, 400);
    return self;
}
- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [self reloadData];
    [self scrollViewDidScroll:self];
}
#pragma mark -UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DXImageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    DXImagePickModel *model = self.dataArray[indexPath.item];
    model.offset = self.contentOffset;
    cell.model = model;
    cell.delegate = self;
    return cell;
}
#pragma mark -UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    DXImagePickModel *model = self.dataArray[indexPath.item];
    return model.image.size;
}
#pragma mark -UICollectionViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

      NSArray *cells =  [self visibleCells];
    for (DXImageCollectionCell *cell in cells) {
        DXImagePickModel *model = self.dataArray[[[self indexPathForCell:cell] item]];
        model.offset = scrollView.contentOffset;
        cell.model = model;
    };
    
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}

- (void)removeAllSeletedImage{
    [self.seletedArray removeAllObjects];
    [self.dataArray setValue:@(0) forKeyPath:@"count"];
    [self reloadData];

}
#pragma mark -DXImageCollectionCellDelegate
- (void)imageCollectionCell:(DXImageCollectionCell *)collectionCell selectedButtonDidSelected:(UIButton *)selectedButton{
    DXImagePickModel *selectedModel = collectionCell.model;
    
    for (DXImagePickModel *model in self.dataArray) {
        if ([model isEqual:selectedModel]) {
            if ([self.seletedArray containsObject:model]) {
                model.count = 0;
                [self.seletedArray removeObject:model];
                NSMutableArray *temp = [NSMutableArray arrayWithCapacity:10];
                
                for (DXImagePickModel *seltedModel in self.seletedArray) {
                    [temp addObject:seltedModel];
                }
                [self.seletedArray removeAllObjects];
                [self.seletedArray addObjectsFromArray:temp];
                
            }else{
                [self.seletedArray addObject:model];
            }
        }
    }
    for (DXImagePickModel *model in self.dataArray) {
        long long index = [self.seletedArray indexOfObject:model];
        if (index != NSNotFound && index +1) {
            model.count = index +1;
        }else{
            model.count = 0;
        }
    }
    if ([self.rowImageViewDelegate respondsToSelector:@selector(rowImageView:didSeletectedArray:)]) {
        [self.rowImageViewDelegate rowImageView:self didSeletectedArray:[self.seletedArray copy]];
    }
     [self reloadData];

}


- (NSMutableArray *)seletedArray{
    if (!_seletedArray) {
        _seletedArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _seletedArray;
}


@end
