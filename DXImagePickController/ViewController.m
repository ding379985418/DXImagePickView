//
//  ViewController.m
//  DXImagePickController
//
//  Created by simon on 16/7/1.
//  Copyright © 2016年 DINGXU. All rights reserved.
//

#import "ViewController.h"
#import "DXLoadImageTool.h"
//#import "DXImagePickController.h"
#import "DXImagePickView.h"
#import "UIColor+Category.h"

@interface ViewController ()<DXImagePickViewDelegate>

@property (nonatomic, strong) NSMutableArray *acceptArray;

@property (nonatomic, strong) NSMutableArray *imageViews;

@property (nonatomic, strong)  DXImagePickView *pickView;
@end

@implementation ViewController
- (DXImagePickView *)pickView{
    if (!_pickView) {
        _pickView = [DXImagePickView imagePickView];
        _pickView.frame = self.view.bounds;
        _pickView.delegate = self;
    }
    return _pickView;
}
- (NSMutableArray *)imageViews{
    if (!_imageViews) {
        _imageViews = [NSMutableArray array];
    }
    return _imageViews;
}
- (NSMutableArray *)acceptArray{
    if (!_acceptArray) {
        _acceptArray = [NSMutableArray array];
    }
    return _acceptArray;
}

- (void)awakeFromNib{
    UINavigationBar *bar = [UINavigationBar appearance];
    bar.translucent = NO;
    bar.barTintColor = [UIColor colorWithR:46 G:178 B:243];
    bar.tintColor = [UIColor whiteColor];
    
    [bar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];

}

- (IBAction)addImages:(id)sender {

    
    [self.view addSubview:self.pickView];
}

- (void)imagePickView:(DXImagePickView *)imagePickView didSendImages:(NSArray *)images{
    [self.acceptArray addObjectsFromArray:images];
    for (UIImageView  *imageView in self.imageViews) {
        [imageView removeFromSuperview];
    }
    for (int i =0; i < self.acceptArray.count; i++) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:[self rectAtIndex:i]];
        imgView.image = self.acceptArray[i];
        [self.imageViews addObject:imgView];
        [self.view addSubview:imgView];
    }
}
-(CGRect)rectAtIndex:(NSInteger)index{
    //    KcolNumber 每行的个数
    //    Kwidth     控件的宽
    NSInteger KcolNumber = 5;
    CGFloat margin = 10;
    
    CGFloat X = 0;
    CGFloat Y = 0;
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - (margin * KcolNumber -1))/(KcolNumber);
    
    CGFloat height = width;
    
    NSUInteger rowIndex = 0;
    NSUInteger colIndex = 0;
    rowIndex = index /KcolNumber;
    colIndex = index %KcolNumber;
    X = colIndex * width + (colIndex+1)*margin;
    Y = rowIndex * width + (rowIndex+1)*margin ;
    return CGRectMake(X, Y, width, height);
}


@end
