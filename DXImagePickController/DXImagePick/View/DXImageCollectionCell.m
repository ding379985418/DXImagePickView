//
//  DXImageCollectionCell.m
//  DXImagePickController
//
//  Created by simon on 16/7/1.
//  Copyright © 2016年 DINGXU. All rights reserved.
//

#import "DXImageCollectionCell.h"
#import "DXImagePickModel.h"
#import "UIColor+Category.h"
#define KCountLabelWidth 27
@interface DXImageCollectionCell ()
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIButton *seletedButton;


@end

@implementation DXImageCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    self.imageView = [[UIImageView alloc]init];
    self.imageView.contentMode = UIViewContentModeScaleToFill;
    
    [self addSubview:self.imageView];
    self.seletedButton = [[UIButton alloc]init];
    self.seletedButton.bounds = CGRectMake(0, 0, KCountLabelWidth, KCountLabelWidth);
    self.seletedButton.layer.masksToBounds = YES;
    self.seletedButton.layer.cornerRadius = KCountLabelWidth *0.5;
    self.seletedButton.titleLabel.font = [UIFont systemFontOfSize:12];
    self.seletedButton.backgroundColor = [UIColor grayColor];
    self.seletedButton.alpha = 0.5;
    [self.seletedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    self.seletedButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.seletedButton.layer.borderWidth = 2;
    [self addSubview:self.seletedButton];
//    self.backgroundColor = [UIColor randomColor];
//    self.model.selButtonPoint = CGPointMake(0, 0);
    [self.seletedButton addTarget:self action:@selector(seletedButtonDidSelected:) forControlEvents:UIControlEventTouchDown];

 
    return self;
}

- (void)pointSeleteButton:(CGPoint )offset{
    CGPoint rightPoint = CGPointMake(offset.x + [UIScreen mainScreen].bounds.size.width, KCountLabelWidth);
    CGFloat rightPoint_x = offset.x + [UIScreen mainScreen].bounds.size.width;
    if (CGRectContainsPoint(self.frame, rightPoint)) {
        CGPoint newCenter = CGPointMake(rightPoint_x - self.frame.origin.x - KCountLabelWidth * 0.5 -3   , KCountLabelWidth * 0.5);
        if ( newCenter.x < KCountLabelWidth *0.5 + 3) {
            newCenter = CGPointMake( KCountLabelWidth *0.5 + 3 , KCountLabelWidth * 0.5);
        }
        self.seletedButton.center = newCenter;
    }else{

        self.seletedButton.center =CGPointMake(self.frame.size.width - KCountLabelWidth *0.5 -3, KCountLabelWidth *0.5);
    }

}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
}

- (void)setModel:(DXImagePickModel *)model{
    _model = model;
    self.imageView.image = model.image;
    [self pointSeleteButton:model.offset];
   
    if (model.count > 0) {
        self.seletedButton.alpha = 0.9;
        self.seletedButton.selected = YES;
        self.seletedButton.backgroundColor = [UIColor colorWithR:46 G:178 B:243];;
        [self.seletedButton setTitle:[NSString stringWithFormat:@"%zd",model.count] forState:UIControlStateSelected];
    }else{
        self.seletedButton.alpha = 0.5;
        self.seletedButton.selected = NO;
        self.seletedButton.backgroundColor = [UIColor grayColor];
        [self.seletedButton setTitle:@"" forState:UIControlStateNormal];
    
    }
}

- (void)seletedButtonDidSelected:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(imageCollectionCell:selectedButtonDidSelected:)]) {
        [self.delegate imageCollectionCell:self selectedButtonDidSelected:button];
    }

}
@end
