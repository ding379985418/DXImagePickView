# DXImagePickView
仿QQ照片选择效果,可以快速选择相册中的照片，也可以选择每个照片组的所用照片
# 效果图
![image](https://github.com/ding379985418/DXImagePickView/blob/master/photoPickView.gif)
# 使用方法
## 1、快速初始化：
	DXImagePickView *pickView = [DXImagePickView imagePickView];
	pickView.frame = self.view.bounds;
## 2、设置代理并添加到视图上
	self.pickView.delegate = self;
	[self.view addSubview:self.pickView];
## 3、实现代理方法
	- (void)imagePickView:(DXImagePickView *)imagePickView didSendImages:(NSArray *)images{
	//拿到选择的照片的数组 images
	}
