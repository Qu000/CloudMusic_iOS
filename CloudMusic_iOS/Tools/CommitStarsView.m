//
//  CommitStarsView.m
//  PeopleStreet
//
//  Created by 辰领科技 on 16/1/18.
//  Copyright © 2016年 yuf. All rights reserved.
//

#import "CommitStarsView.h"

@implementation CommitStarsView

- (instancetype)initWithFrame:(CGRect)frame Stars:(CGFloat)stars{
    self = [super initWithFrame:frame];
    if (self) {
        int Ynumber = stars/1;
        int Cnumber = 0;
        int YCnumber = 0;
        int number = stars/0.5;
        if (number%2==0) {
            YCnumber = 0;
            Cnumber = 5-Ynumber;
        }else{
            YCnumber = 1;
            Cnumber = 4-Ynumber;
        }
        
        for (int i = 0; i<Ynumber; i++) {
            UIImageView * star = [[UIImageView alloc]initWithFrame:flexibleFrame(CGRectMake(13*i, 0, 12, 12), NO)];
            star.image = [UIImage imageNamed:@"waimai1"];
            [self addSubview:star];
            
        }
        
        if (YCnumber==0) {
            for (int i = 0;i<Cnumber ; i++) {
                UIImageView * star = [[UIImageView alloc]initWithFrame:flexibleFrame(CGRectMake((Ynumber+i)*13, 0, 12, 12), NO)];
                star.image = [UIImage imageNamed:@"waimai2"];
                [self addSubview:star];
            }
            
        }else{
            UIImageView * star = [[UIImageView alloc]initWithFrame:flexibleFrame(CGRectMake((Ynumber)*13, 0, 12, 12), NO)];
            star.image = [UIImage imageNamed:@"waimai3"];
            [self addSubview:star];
            
            for (int i = 0;i<Cnumber ; i++) {
                UIImageView * star = [[UIImageView alloc]initWithFrame:flexibleFrame(CGRectMake((Ynumber+i+1)*13, 0, 12, 12), NO)];
                star.image = [UIImage imageNamed:@"waimai2"];
                [self addSubview:star];
            }
        }
       
        UILabel * score = [[UILabel alloc]initWithFrame:flexibleFrame(CGRectMake(68, 0, 20, 12), NO)];
        score.textAlignment = NSTextAlignmentLeft;
        score.textColor = kGetColor(252, 189, 48);
        score.font =[UIFont systemFontOfSize:13*VerticalTexeRatio()];
        score.text = [NSString stringWithFormat:@"%.1f",stars];
        [self addSubview:score];
        
    }
    return self;

}




@end
