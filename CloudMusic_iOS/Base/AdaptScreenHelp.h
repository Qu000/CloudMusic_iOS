//
//  AdaptScreenHelp.h
//  CloudMusic_iOS
//
//  Created by qujiahong on 2017/9/17.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#ifndef _____AdaptScreenHelp_h
#define _____AdaptScreenHelp_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#warning 传入的要是基准屏幕下的值

//内联函数
#define LYS_INLINE static inline
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
//以iphone5s为基准
static const CGFloat originWidth_ = 320.f;
static const CGFloat originHeight_ = 568.f;

/**
 *  水平、竖直方向比例计算
 *
 *  @param value 基准屏幕的值
 *
 *  @return 等比例适配后的值
 */
LYS_INLINE CGFloat HorizontalRatio()
{
    return SCREEN_WIDTH / originWidth_;
}

LYS_INLINE CGFloat VerticalRatio()
{
    return SCREEN_HEIGHT / originHeight_;
}
LYS_INLINE CGFloat VerticalTexeRatio()
{
    if (SCREEN_WIDTH == 375) {
        return 1.04f;
    }else if (SCREEN_WIDTH > 375){
        return 1.15f;
    }
    return SCREEN_HEIGHT / originHeight_;
}
/**
 *  通过frame计算center
 *
 *  @param frame frame
 *
 *  @return 计算出来的frame的center
 */
LYS_INLINE CGPoint centerFromFrame(CGRect frame)
{
    return CGPointMake(frame.origin.x + frame.size.width / 2, frame.origin.y + frame.size.height / 2);
}

/**
 *  通过size和center确定一个frame
 *
 *  @param size   size
 *  @param center center
 *
 *  @return 确定的frame
 */
LYS_INLINE CGRect frameWithSizeAndCenter(CGSize size, CGPoint center)
{
    return CGRectMake(center.x - size.width / 2, center.y - size.height / 2, size.width, size.height);
}

/**
 *  等比例适配center
 *
 *  @param center 基准屏幕下的center
 *
 *  @return 当前屏幕下的适配的center
 */
LYS_INLINE CGPoint flexibleCenter(CGPoint center)
{
    CGFloat x = center.x * HorizontalRatio();
    CGFloat y = center.y * VerticalRatio();
    return CGPointMake(x, y);
}

/**
 *  等比例适配size
 *
 *  @param size        基准屏幕下的size
 *  @param adjustWidth 如果是yes,则返回size的宽高同时乘高的比例 否则分别乘各自比例(用来适配Iphone4)
 *
 *  @return 适配后的size
 */

LYS_INLINE CGSize flexibleSize(CGSize size, BOOL adjustWidth)
{
    if (adjustWidth) {
        return CGSizeMake(size.width * VerticalRatio(), size.height *VerticalRatio());
    }else {
        return CGSizeMake(size.width * HorizontalRatio(), size.height *VerticalRatio());
    }
    
}

/**
 *  等比例适配frame
 *
 *  @param frame       基准屏幕下的frame
 *  @param adjustWidth 如果是yes,则返回size的宽高同时乘高的比例 否则分别乘各自比例(用来适配Iphone4)
 *
 *  @return 适配后的frame
 */

LYS_INLINE CGRect flexibleFrame(CGRect frame, BOOL adjustWidth)
{
    //拿到frame的center，然后对x和y等比例缩放
    CGPoint center = centerFromFrame(frame);
    center = flexibleCenter(center);
    //对宽高等比例缩放,拿到一个CGSize
    CGSize size = flexibleSize(frame.size, adjustWidth);
    //用上面等比例缩放后的center和size组成一个frame后返回
    return frameWithSizeAndCenter(size, center);
}



#endif
