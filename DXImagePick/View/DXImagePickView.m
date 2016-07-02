//
//  DXImagePickView.m
//  DXImagePickController
//
//  Created by simon on 16/7/1.
//  Copyright © 2016年 DINGXU. All rights reserved.
//

#import "DXImagePickView.h"
#import "DXLoadImageTool.h"
#import "DXRowImageView.h"
#import "DXImagePickController.h"
@interface DXImagePickView ()<DXRowImageViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *containView;
@property (weak, nonatomic) IBOutlet UIButton *photoAlbumBtn;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UIButton *origalImageBtn;
@property (weak, nonatomic) IBOutlet UIView *toolBar;
@property (nonatomic, strong) DXRowImageView *rowImageView;

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableArray *seletedArray;

@end
@implementation DXImagePickView

+ (instancetype)imagePickView{
    DXImagePickView *pickView = [[NSBundle mainBundle] loadNibNamed:@"DXImagePickView" owner:nil options:nil].lastObject;
    pickView.frame = [UIScreen mainScreen].bounds;
    return pickView;
    
}

- (void)awakeFromNib{
    self.editBtn.enabled = NO;
    self.sendBtn.enabled = NO;
    self.rowImageView = [DXRowImageView rowImageViewWithFrame:self.containView.bounds];
    self.rowImageView.rowImageViewDelegate = self;
    [self.containView addSubview:self.rowImageView];
    [self loadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageCollectionDidSend:) name:@"DXImageCollectionVcDidSendNotice" object:nil];
    
}

- (void)loadData{
    [DXLoadImageTool loadImagesFromCamerarollSucess:^(NSArray *images) {
        self.dataArray = [images copy];
        self.rowImageView.dataArray = self.dataArray;
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}

- (void)rowImageView:(DXRowImageView *)collectionView didSeletectedArray:(NSArray *)array{
    self.sendBtn.enabled = array.count;
    NSArray *images = [array valueForKeyPath:@"image"];
    [self.seletedArray removeAllObjects];
    [self.seletedArray addObjectsFromArray:images];
    if (array.count) {
        [self.sendBtn setTitle:[NSString stringWithFormat:@"发送(%zd)",array.count] forState:UIControlStateNormal];
    }else{
        [self.sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    }
    
    self.editBtn.enabled = array.count == 1;

}

- (void)imageCollectionDidSend:(NSNotification *)notice{
    NSArray *array = notice.userInfo[@"DXImageCollectionVcDidSendNoticeKey"];
    NSArray *images = [array valueForKeyPath:@"image"];
    [self.seletedArray removeAllObjects];
    [self.seletedArray addObjectsFromArray:images];
    if (self.seletedArray.count) {
        if ([self.delegate respondsToSelector:@selector(imagePickView:didSendImages:)]) {
            [self.delegate imagePickView:self didSendImages:self.seletedArray];
            
        }
        [self.seletedArray removeAllObjects];
    }

}
- (IBAction)photoAlbumBtnClick:(UIButton *)sender {
    [self.seletedArray removeAllObjects];
    [self.rowImageView removeAllSeletedImage];
    
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:[DXImagePickController new]];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:navc animated:YES completion:nil];
}
- (IBAction)editBtnClick:(UIButton *)sender {
}
- (IBAction)origalImageBtnClick:(UIButton *)sender {
}

- (IBAction)sendBtnClick:(UIButton *)sender {
    [sender setTitle:@"发送" forState:UIControlStateNormal];
    sender.enabled = NO;
    if (self.seletedArray.count) {
    if ([self.delegate respondsToSelector:@selector(imagePickView:didSendImages:)]) {
        [self.delegate imagePickView:self didSendImages:self.seletedArray];
   
    }
        [self.seletedArray removeAllObjects];
        [self.rowImageView removeAllSeletedImage];
  }
}
- (IBAction)dismissBtn:(UIButton *)sender {
    [self removeFromSuperview];
}

- (NSMutableArray *)seletedArray{
    if (!_seletedArray) {
        _seletedArray = [NSMutableArray array];
    }
    return _seletedArray;
}

@end
