//
//  PhotoPopView.m
//  Edumap
//
//  Created by 刘建峰 on 16/8/23.
//  Copyright © 2016年 yuf. All rights reserved.
//

#import "PhotoChoseView.h"

@interface PhotoChoseView ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property(nonatomic,strong)void (^complect)(UIImage * image);
@property(nonatomic,strong)UIViewController * viewController;
@end
@implementation PhotoChoseView

- (instancetype)initWithController:(UIViewController *)viewController complect:(void (^)(UIImage*))complect{
    if (self = [super init]) {//0, 418, 320, 165
        self.frame = flexibleFrame(CGRectMake(0, 152, 320, 416), NO);
        self.backgroundColor = [UIColor whiteColor];
        _complect = complect;
        _viewController = viewController;
        UIView * showView = [[UIView alloc]init];
        showView.frame = flexibleFrame(CGRectMake(0, 10, 320, 247),0);
        showView.backgroundColor = [UIColor blueColor];
        [self addSubview:showView];
        
        UIImageView *showImage = [[UIImageView alloc]init];
        showImage.frame = flexibleFrame(CGRectMake(12, 14, 296, 197),0);
        showImage.backgroundColor = [UIColor whiteColor];
        [showView addSubview:showImage];
        
        for (int i = 0; i<3; i++) {
            UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
            backButton.frame = flexibleFrame(CGRectMake(320, 50*i, 320, 50), NO);
            backButton.tag = 100+i;
            [backButton addTarget:self action:@selector(chilkHandel:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:backButton];
            
            UIView * line = [[UIView alloc]initWithFrame:flexibleFrame(CGRectMake(0, 49, 320, 1), NO)];
            line.backgroundColor = kGetColor(240, 240, 240);
            [backButton addSubview:line];
            
//            UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"popPhoto%d",i+1]]];
//            imageView.frame = flexibleFrame(CGRectMake(98, 14, 24, 22), NO);
//            [backButton addSubview:imageView];
            
            
            UILabel * title = [[UILabel alloc]initWithFrame:flexibleFrame(CGRectMake(115, 0, 95, 55), NO)];
            title.font = [UIFont systemFontOfSize:15*VerticalTexeRatio()];
            title.textColor = [UIColor colorWithWhite:0.275 alpha:1.000];
            title.textAlignment = NSTextAlignmentCenter;
            NSArray * names = @[@"拍照",@"从相册选择",@"取消"];
            title.text = names[i];
            [backButton addSubview:title];
            
        }
        [self showAnimation];
    }
    return self;
}



- (void)chilkHandel:(UIButton *)sender{
    if (sender.tag==100) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing = YES;
        [_viewController presentViewController:picker animated:YES completion:nil];
        self.backWindow.frame = flexibleFrame(CGRectMake(320, 0, 320, 568), NO);
    }else if (sender.tag==101){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        [_viewController presentViewController:picker animated:YES completion:nil];
        self.backWindow.frame = flexibleFrame(CGRectMake(320, 0, 320, 568), NO);
    }else{
        [self hide];
    }
}
-(void)wouldBeShow{
    
}
- (void)showAnimation{
    for (int i = 0; i<3; i++) {
        UIButton * buttonView = [self viewWithTag:100+i];
        [UIView animateWithDuration:0.4 delay:0.05*i usingSpringWithDamping:0.7 initialSpringVelocity:15 options:UIViewAnimationOptionCurveLinear animations:^{
            buttonView.frame = flexibleFrame(CGRectMake(0, 270+50*i, 320, 50), NO);
        } completion:^(BOOL finished) {
        }];
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (image == nil) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    _complect(image);
    [picker dismissViewControllerAnimated:YES completion:^{}];
    [self hide];

}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{}];
    [self hide];
}

//@"拍照上传",@"取消
- (instancetype)initWithPhotoController:(UIViewController *)viewController complect:(void (^)(UIImage*))complect{
    if (self = [super init]) {
        self.frame = flexibleFrame(CGRectMake(0, 468, 320, 100), NO);
        self.backgroundColor = [UIColor whiteColor];
        _complect = complect;
        _viewController = viewController;
        for (int i = 0; i<2; i++) {
            UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
            backButton.frame = flexibleFrame(CGRectMake(320, 50*i, 320, 50), NO);
            backButton.tag = 100+i;
            [backButton addTarget:self action:@selector(photochilkHandel:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:backButton];
            
            UIView * line = [[UIView alloc]initWithFrame:flexibleFrame(CGRectMake(0, 49, 320, 1), NO)];
            line.backgroundColor = kGetColor(240, 240, 240);
            [backButton addSubview:line];
            
             NSArray * imagenames = @[@"popPhoto1",@"popPhoto3"];
            UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed: imagenames[i]]];
            imageView.frame = flexibleFrame(CGRectMake(98, 14, 24, 22), NO);
            [backButton addSubview:imageView];
            
            
            UILabel * title = [[UILabel alloc]initWithFrame:flexibleFrame(CGRectMake(135, 0, 95, 50), NO)];
            title.font = [UIFont systemFontOfSize:15*VerticalTexeRatio()];
            title.textColor = [UIColor colorWithWhite:0.275 alpha:1.000];
            title.textAlignment = NSTextAlignmentCenter;
            NSArray * names = @[@"拍照上传",@"取消"];
            title.text = names[i];
            [backButton addSubview:title];
            
        }
        [self photoshowAnimation];
    }
    return self;
}



- (void)photochilkHandel:(UIButton *)sender{
    if (sender.tag==100) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing = YES;
        [_viewController presentViewController:picker animated:YES completion:nil];
        self.backWindow.frame = flexibleFrame(CGRectMake(320, 0, 320, 568), NO);
    }
//    else if (sender.tag==101){
//        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//        picker.delegate = self;
//        picker.allowsEditing = YES;
//        [_viewController presentViewController:picker animated:YES completion:nil];
//        self.backWindow.frame = flexibleFrame(CGRectMake(320, 0, 320, 568), NO);
//    }
    else{
        [self hide];
    }
}

- (void)photoshowAnimation{
    for (int i = 0; i<2; i++) {
        UIButton * buttonView = [self viewWithTag:100+i];
        [UIView animateWithDuration:0.4 delay:0.05*i usingSpringWithDamping:0.7 initialSpringVelocity:15 options:UIViewAnimationOptionCurveLinear animations:^{
            buttonView.frame = flexibleFrame(CGRectMake(0, 50*i, 320, 50), NO);
        } completion:^(BOOL finished) {
        }];
    }
}


@end
