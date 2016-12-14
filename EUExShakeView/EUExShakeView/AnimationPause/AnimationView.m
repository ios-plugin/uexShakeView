//
//  AnimationView.m
//  EUExShakeView
//
//  Created by 杨广 on 16/4/15.
//  Copyright © 2016年 AppCan.can. All rights reserved.
//

#import "AnimationView.h"
#import "EUtility.h"
@implementation AnimationView{
    CGPoint bgViewPoint;
    float moveY;
    float moveX;
}
@synthesize imgUp;
@synthesize imgDown;
<<<<<<< HEAD
-(id)initWithFrame:(CGRect)frame backgroundImagePath:(NSString*)backgroundImagePath upImagePath:(NSString*)upImagePath downImagePath:(NSString*)downImagePath{
=======
-(id)initWithFrame:(CGRect)frame backgroundImagePath:(NSString*)backgroundImagePath upImagePath:(NSString*)upImagePath downImagePath:(NSString*)downImagePath imageWidth:(CGFloat)imageWidth imageHeight:(CGFloat)imageHeight{
>>>>>>> origin/dev-4.0
    if ( self = [super initWithFrame:frame]) {
        [self becomeFirstResponder];
        self.userInteractionEnabled = YES;
        CGSize size = frame.size;
        float width = size.width;
        float heigh = size.height;
        UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, heigh)];
<<<<<<< HEAD
         NSLog(@"self.backgroundImagePath:%@",backgroundImagePath);
        if (backgroundImagePath) {
            bgView.image = [UIImage imageWithContentsOfFile:backgroundImagePath];
        }else{
             bgView.image = [self imagesNamedFromCustomBundle:@"ShakeHideImg_women"];
        }
       
=======
        NSLog(@"self.backgroundImagePath:%@",backgroundImagePath);
        if (backgroundImagePath) {
            bgView.image = [UIImage imageWithContentsOfFile:backgroundImagePath];
        }else{
            bgView.image = [self imagesNamedFromCustomBundle:@"ShakeHideImg_women"];
        }
        
>>>>>>> origin/dev-4.0
        [self addSubview:bgView];
        UIView *view = [[UIView alloc] init];
        NSLog(@"height:%f",heigh);
        if (imageWidth !=0 && imageHeight !=0) {
            view.frame = CGRectMake(0,  0, imageWidth, imageHeight);
            view.center = bgView.center;
        }else{
            view.frame = CGRectMake(width/4,  heigh/4, width/2, heigh/2);
        }
        
        [bgView addSubview:view];
        NSString *path = [[EUtility bundleForPlugin:@"uexShakeView"] pathForResource:@"shake" ofType:@"wav"];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundID);
<<<<<<< HEAD
        imgUp = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width/2, heigh/4)];
        if (upImagePath) {
           imgUp.image = [UIImage imageWithContentsOfFile:upImagePath];
        }else{
           imgUp.image = [self imagesNamedFromCustomBundle:@"Shake_Logo_Up"];
        }
        
        [view addSubview:imgUp];
        imgDown = [[UIImageView alloc] initWithFrame:CGRectMake(0,  heigh/4, width/2,heigh/4)];
        if (downImagePath) {
            imgDown.image = [UIImage imageWithContentsOfFile:downImagePath];
        }else{
           imgDown.image = [self imagesNamedFromCustomBundle:@"Shake_Logo_Down"];
=======
        imgUp = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height/2)];
        if (upImagePath) {
            imgUp.image = [UIImage imageWithContentsOfFile:upImagePath];
        }else{
            imgUp.image = [self imagesNamedFromCustomBundle:@"Shake_Logo_Up"];
        }
        
        [view addSubview:imgUp];
        imgDown = [[UIImageView alloc] initWithFrame:CGRectMake(0,  view.frame.size.height/2, view.frame.size.width,view.frame.size.height/2)];
        if (downImagePath) {
            imgDown.image = [UIImage imageWithContentsOfFile:downImagePath];
        }else{
            imgDown.image = [self imagesNamedFromCustomBundle:@"Shake_Logo_Down"];
>>>>>>> origin/dev-4.0
        }
        
        [view addSubview:imgDown];
        moveX = imgUp.center.x;
        moveY = view.frame.size.height/2;
        
        
    }
    return self;
}

//添加
#pragma mark - 摇一摇动画效果
- (void)addAnimations
{
    AudioServicesPlaySystemSound (soundID);
    //让imgup上下移动
    CAAnimationGroup *groupUp = [CAAnimationGroup animation];
    CAAnimationGroup *groupDown = [CAAnimationGroup animation];
    
    CABasicAnimation *translation = [CABasicAnimation animationWithKeyPath:@"position"];
    translation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    translation.fromValue = [NSValue valueWithCGPoint:CGPointMake(moveX, imgUp.frame.origin.y+moveY/2)];
    translation.toValue = [NSValue valueWithCGPoint:CGPointMake(moveX, imgUp.frame.origin.y)];
    translation.duration = 0.5;
    translation.fillMode = kCAFillModeForwards;
    translation.removedOnCompletion = NO;
    
    CABasicAnimation *translation1 = [CABasicAnimation animationWithKeyPath:@"position"];
    translation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    translation1.fromValue = [NSValue valueWithCGPoint:CGPointMake(moveX, imgUp.frame.origin.y)];
    translation1.toValue = [NSValue valueWithCGPoint:CGPointMake(moveX, imgUp.frame.origin.y+moveY/2)];
    translation1.duration = 0.5;
    translation1.beginTime = 0.8;
    translation1.fillMode = kCAFillModeForwards;
    translation1.removedOnCompletion = NO;
    groupUp.animations = [NSArray arrayWithObjects:translation,translation1, nil];
    groupUp.duration = 1.8;
    
    //让imagdown上下移动
    CABasicAnimation *translation2 = [CABasicAnimation animationWithKeyPath:@"position"];
    translation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    translation2.fromValue = [NSValue valueWithCGPoint:CGPointMake(moveX, imgDown.frame.origin.y+moveY/2)];
    translation2.toValue = [NSValue valueWithCGPoint:CGPointMake(moveX, imgDown.frame.origin.y+moveY)];
    translation2.duration = 0.5;
    translation2.repeatCount = 1;
    translation2.removedOnCompletion = NO;
    translation2.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *translation3 = [CABasicAnimation animationWithKeyPath:@"position"];
    translation3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    translation3.fromValue = [NSValue valueWithCGPoint:CGPointMake(moveX, imgDown.frame.origin.y+moveY)];
    translation3.toValue = [NSValue valueWithCGPoint:CGPointMake(moveX, imgDown.frame.origin.y+moveY/2)];
    translation3.duration = 0.5;
    
    groupDown.animations = [NSArray arrayWithObjects:translation2,translation3, nil];
    groupDown.duration = 1.8;
    translation3.beginTime = 0.8;
    translation3.removedOnCompletion = NO;
    translation3.fillMode = kCAFillModeForwards;
    [imgDown.layer addAnimation:groupDown forKey:nil];
    [imgUp.layer addAnimation:groupUp forKey:nil];
}

#pragma mark - 摇一摇
//onShake
-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    
    
    
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    // [self callBackJsonWithFunction:@"onShake"];
    if(motion==UIEventSubtypeMotionShake)
    {
        [self addAnimations];
        NSLog(@"addAnimations:%@", [NSThread currentThread]);
        //添加
        AudioServicesPlaySystemSound (soundID);
        
    }
    [self performSelector:@selector(motionEndAfter) withObject:self afterDelay:1.0];
    
    
}

- (void)motionEndAfter {
    // AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    NSString *path = [[EUtility bundleForPlugin:@"uexShakeView"] pathForResource:@"shake_match" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundIDAfter);
    [[NSNotificationCenter defaultCenter]postNotificationName:@"onShake" object:self];
    AudioServicesPlaySystemSound (soundIDAfter);
    
}
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (UIImage *)imagesNamedFromCustomBundle:(NSString *)imgName
{
    
    NSBundle *bundle = [EUtility bundleForPlugin:@"uexShakeView"];
    NSString *img_path = [[bundle resourcePath]stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",imgName]];
    return [UIImage imageWithContentsOfFile:img_path];
}

@end


