//
//  DXImageCollectionVc.m
//  DXImagePickController
//
//  Created by simon on 16/7/2.
//  Copyright © 2016年 DINGXU. All rights reserved.
//

#import "DXImageCollectionVc.h"
#import "DXImageCollectionCell.h"
#import "DXPhotoGroupModel.h"
#import "UIColor+Category.h"
#import "DXImagePickModel.h"
#define KItemMargin 2
#define KBarItemHeight 50
@interface DXImageCollectionVc ()<UICollectionViewDelegateFlowLayout,DXImageCollectionCellDelegate>
@property (nonatomic, strong) UIView *barView;

@property (nonatomic, strong) UIButton *senderButton;

@property (nonatomic, strong) NSMutableArray *seletedArray;
@end

@implementation DXImageCollectionVc

static NSString * const reuseIdentifier = @"DXImageCollectionCell";

+ (instancetype)imageCollectionVc{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    NSInteger width = (NSInteger )([UIScreen mainScreen].bounds.size.width - KItemMargin * 4) /5;
    layout.itemSize = CGSizeMake(width, width);
    layout.minimumInteritemSpacing = KItemMargin;
    layout.minimumLineSpacing = KItemMargin;

    return [[self alloc]initWithCollectionViewLayout:layout];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

- (void)setUpUI{
    [self.collectionView registerClass:[DXImageCollectionCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    self.title = self.groupModel.groupName;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.contentInset = UIEdgeInsetsMake(KItemMargin, 0, KBarItemHeight, 0);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelItemClick)];
    [self setUpBarView];
}
- (void)setUpBarView{
    CGSize size = [UIScreen mainScreen].bounds.size;//self.view.frame.size;
    self.barView = [[UIView alloc]initWithFrame:CGRectMake(0, size.height - KBarItemHeight - 64, size.width, KBarItemHeight)];
    self.barView.backgroundColor = [UIColor colorWithR:239 G:239 B:239];
    
    [self.view addSubview:self.barView];
    [self.view bringSubviewToFront:self.barView];
    CGFloat sendBtnW = 70;
    CGFloat sendBtnH = 30;
    _senderButton = [[UIButton alloc]initWithFrame:CGRectMake(size.width - sendBtnW - 10,(self.barView.frame.size.height - sendBtnH )*0.5, sendBtnW, sendBtnH)];
    _senderButton.enabled = NO;
    [_senderButton setTitle:@"发送" forState:UIControlStateNormal];
    [_senderButton setTitleColor:[UIColor colorWithR:239 G:239 B:239] forState:UIControlStateNormal];
    [_senderButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    _senderButton.titleLabel.font = [UIFont systemFontOfSize:12];
    _senderButton.layer.masksToBounds = YES;
    _senderButton.layer.cornerRadius = 5;
    _senderButton.backgroundColor = [UIColor colorWithR:46 G:178 B:243];
    [_senderButton addTarget:self action:@selector(sendBtnDidClick:) forControlEvents:UIControlEventTouchDown];
    [self.barView addSubview:_senderButton];
    
}
- (void)setGroupModel:(DXPhotoGroupModel *)groupModel{
    _groupModel = groupModel;

    [self.collectionView reloadData];
}

- (void)sendBtnDidClick:(UIButton *)button{

    [[NSNotificationCenter defaultCenter] postNotificationName:@"DXImageCollectionVcDidSendNotice" object:nil userInfo:@{@"DXImageCollectionVcDidSendNoticeKey":[self.seletedArray copy]}];
    [self cancelItemClick];

}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.groupModel.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DXImageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    DXImagePickModel *model = self.groupModel.images[indexPath.row];
    cell.model = model;
    cell.delegate = self;
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *resusable = nil;
    if (kind == UICollectionElementKindSectionFooter) {

        resusable = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];

       UILabel *footer = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
        footer.textAlignment = NSTextAlignmentCenter;
        footer.textColor = [UIColor lightGrayColor];
        footer.font = [UIFont systemFontOfSize:15];
        footer.text = [NSString stringWithFormat:@"一共有%zd张照片",_groupModel.images.count];
        [resusable addSubview: footer];
     
    }
    return resusable;
}
- (void)imageCollectionCell:(DXImageCollectionCell *)collectionCell selectedButtonDidSelected:(UIButton *)selectedButton{
    DXImagePickModel *selectedModel = collectionCell.model;
    
    for (DXImagePickModel *model in self.groupModel.images) {
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
    for (DXImagePickModel *model in self.groupModel.images) {
        long long index = [self.seletedArray indexOfObject:model];
        if (index != NSNotFound && index +1) {
            model.count = index +1;
        }else{
            model.count = 0;
        }
    }
    [self.collectionView reloadData];
    self.senderButton.enabled =self.seletedArray.count;
    if (self.seletedArray.count) {
        [self.senderButton setTitle:[NSString stringWithFormat:@"发送(%zd)",self.seletedArray.count] forState:UIControlStateNormal];
    }else{
    
        [self.senderButton setTitle:@"发送" forState:UIControlStateNormal];

    }
    

}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 40);
}
- (void)cancelItemClick{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];

}

- (NSMutableArray *)seletedArray{
    if (!_seletedArray) {
        _seletedArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _seletedArray;
}
@end





