//
//  PhotoPopView.h
//  Edumap
//
//  Created by 刘建峰 on 16/8/23.
//  Copyright © 2016年 yuf. All rights reserved.
//

#import "MyPopWindow.h"

@interface PhotoChoseView : MyPopWindow
// 拍照上传",@"从相册中选择",@"取消
- (instancetype)initWithController:(UIViewController *)viewController complect:(void(^)(UIImage *image))complect;
// 拍照上传",@"取消
- (instancetype)initWithPhotoController:(UIViewController *)viewController complect:(void (^)(UIImage*))complect;

@property(nonatomic,copy)void(^selectBlock)(NSString *remindStr,UIImageView *imageView);
@end
