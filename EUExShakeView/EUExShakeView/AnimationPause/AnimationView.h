//
//  AnimationView.h
//  EUExShakeView
//
//  Created by 杨广 on 16/4/15.
//  Copyright © 2016年 AppCan.can. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EUExBase.h"
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>
@interface AnimationView : UIView{
    //添加
    UIImageView *imgUp;
    UIImageView *imgDown;
    SystemSoundID soundID;
    SystemSoundID soundIDAfter;
    UIActivityIndicatorView *aiLoad;
}
@property(nonatomic, retain) UIImageView *imgUp;
@property(nonatomic, retain) UIImageView *imgDown;
@property(nonatomic, retain) NSMutableDictionary *frameDict;
//添加
- (void)addAnimations;
+ (id)sharedInstance;
@end