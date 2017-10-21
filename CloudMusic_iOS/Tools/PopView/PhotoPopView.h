//
//  PhotoPopView.h
//  Edumap
//
//  Created by 刘建峰 on 16/8/23.
//  Copyright © 2016年 yuf. All rights reserved.
//

#import "MyPopWindow.h"

@interface PhotoPopView : MyPopWindow
- (instancetype)initWithcomplect:(void(^)(NSInteger index))complect;
- (instancetype)initWithPhotocomplect:(void(^)(NSInteger index))complect;//只有拍照或者拍视频
@end
