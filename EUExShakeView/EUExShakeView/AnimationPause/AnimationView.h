//
//  AnimationView.h
//  EUExShakeView
//
//  Created by 杨广 on 16/4/15.
//  Copyright © 2016年 AppCan.can. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>
@interface AnimationView : UIView{
    //添加
    UIImageView *imgUp;
    UIImageView *imgDown;
    SystemSoundID soundID;
    SystemSoundID soundIDAfter;
    
}
@property(nonatomic, retain) UIImageView *imgUp;
@property(nonatomic, retain) UIImageView *imgDown;


//添加
<<<<<<< HEAD
-(id)initWithFrame:(CGRect)frame backgroundImagePath:(NSString*)backgroundImagePath upImagePath:(NSString*)upImagePath downImagePath:(NSString*)downImagePath;
=======
-(id)initWithFrame:(CGRect)frame backgroundImagePath:(NSString*)backgroundImagePath upImagePath:(NSString*)upImagePath downImagePath:(NSString*)downImagePath imageWidth:(CGFloat)imageWidth imageHeight:(CGFloat)imageHeight;
>>>>>>> origin/dev-4.0
- (void)addAnimations;

@end
