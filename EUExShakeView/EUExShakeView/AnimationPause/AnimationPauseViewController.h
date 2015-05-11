//
//  AnimationPauseViewController.h
//  AnimationPause
//
//  Created by gamy on 12-1-5.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//添加
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>
@interface AnimationPauseViewController : UIViewController {
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

@end
