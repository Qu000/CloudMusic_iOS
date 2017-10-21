//
//  main.m
//  CloudMusic_iOS
//
//  Created by qujiahong on 2017/9/17.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:JHMusicFMDB];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
