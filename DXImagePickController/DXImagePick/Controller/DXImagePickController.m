//
//  DXImagePickController.m
//  DXImagePickController
//
//  Created by simon on 16/7/2.
//  Copyright © 2016年 DINGXU. All rights reserved.
//

#import "DXImagePickController.h"
#import "UIColor+Category.h"
#import "DXLoadImageTool.h"
#import "DXImagePickModel.h"
#import "DXPhotoGroupModel.h"
#import "DXImageCollectionVc.h"

@interface DXImagePickController ()



@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation DXImagePickController
 static NSString *cellReuseIdentifier = @"cellReuseIdentifier";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self loadData];
   }

- (void)setUpUI{
    self.title = @"照片";
    UINavigationBar *bar = [UINavigationBar appearance];
    bar.translucent = NO;
    bar.barTintColor = [UIColor colorWithR:46 G:178 B:243];
    bar.tintColor = [UIColor whiteColor];
    [bar setBackgroundColor:[UIColor colorWithR:46 G:178 B:243]];
    [bar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelItemClick)];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellReuseIdentifier];
    self.tableView.tableFooterView = [UIView new];//self.tableViewFooter;
    self.tableView.rowHeight = 80;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0);

}
- (void)loadData{
    [DXLoadImageTool loadAllPhotoSucess:^(NSArray *photos) {
        self.dataArray = [photos copy];
      
        [self.tableView reloadData];
       
        DXPhotoGroupModel *group = self.dataArray.firstObject;
        DXImageCollectionVc *imgVc = [DXImageCollectionVc imageCollectionVc];
        imgVc.groupModel = group;
        [self.navigationController pushViewController:imgVc animated:NO];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    DXPhotoGroupModel *group = self.dataArray[indexPath.row];
    DXImagePickModel *imgModel = group.images.lastObject;
    cell.textLabel.text = [NSString stringWithFormat:@"%@ (%zd)",group.groupName,group.images.count];
    cell.imageView.image = imgModel.image;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DXPhotoGroupModel *group = self.dataArray[indexPath.row];
    DXImageCollectionVc *imgVc = [DXImageCollectionVc imageCollectionVc];
    imgVc.groupModel = group;
    [self.navigationController pushViewController:imgVc animated:YES];

}

- (void)cancelItemClick{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];

}

@end
