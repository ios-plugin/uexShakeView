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
//添加
@synthesize imgUp;
@synthesize imgDown;
+ (id)sharedInstance {
    //创建一个静态的空的单例对象
    static AnimationView *sharedDataCenter = nil;
    //声明一个静态的gcd的单次任务
    static dispatch_once_t onceToken;
    //执行单次任务；
    dispatch_once(&onceToken, ^{
        //对对象进行初始化
        sharedDataCenter = [[self alloc] init];
    });
    
    return sharedDataCenter;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
-(id)init{
    if ( self = [super init]) {
        [self becomeFirstResponder];
        self.userInteractionEnabled = YES;
        float width = [[self.frameDict objectForKey:@"w"] floatValue];
        float heigh = [[self.frameDict objectForKey:@"h"] floatValue];
        
        if (width <= 0||width>[EUtility screenWidth]) {
            width = [EUtility screenWidth];
        }
        if (heigh <= 0||heigh>[EUtility screenHeight]) {
            heigh = [EUtility screenHeight];
        }
        
        UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, heigh)];
        bgView.image = [self imagesNamedFromCustomBundle:@"ShakeHideImg_women"];
        [self addSubview:bgView];
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(width/4, heigh/4, width/2, heigh/2);
        [bgView addSubview:view];
        NSString *path = [[EUtility bundleForPlugin:@"uexShakeView"] pathForResource:@"shake" ofType:@"wav"];
        AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:path], &soundID);
        imgUp = [[UIImageView alloc] initWithFrame:CGRectMake(0, -10, width/2, heigh/4)];
        imgUp.image = [self imagesNamedFromCustomBundle:@"Shake_Logo_Up"];//[UIImage imageNamed:@"uexShakeView/Shake_Logo_Up"];
        [view addSubview:imgUp];
        imgDown = [[UIImageView alloc] initWithFrame:CGRectMake(0,  heigh/4-10, width/2,heigh/4)];
        imgDown.image = [self imagesNamedFromCustomBundle:@"Shake_Logo_Down"];//[UIImage imageNamed:@"uexShakeView/Shake_Logo_Down"];
        [view addSubview:imgDown];
        moveX = imgUp.center.x;
        moveY = heigh/4;
        
        
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
    NSLog(@"我被执行了");
}

#pragma mark - 摇一摇
//onShake
-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    //[self becomeFirstResponder];
    
    //  NSLog(@"begin");
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    // [self callBackJsonWithFunction:@"onShake"];
    if(motion==UIEventSubtypeMotionShake)
    {
        //[self becomeFirstResponder];
            [self addAnimations];
            NSLog(@"addAnimations:%@", [NSThread currentThread]);
            //添加
            AudioServicesPlaySystemSound (soundID);
       
    }
    [self performSelector:@selector(motionEndAfter) withObject:self afterDelay:1.0];
    
   
}

- (void)motionEndAfter {
    [self becomeFirstResponder];
    //AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    NSString *path = [[EUtility bundleForPlugin:@"uexShakeView"] pathForResource:@"shake_match" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:path], &soundIDAfter);
    [[NSNotificationCenter defaultCenter]postNotificationName:@"onShake" object:self];
    AudioServicesPlaySystemSound (soundIDAfter);
    
}
- (BOOL)canBecomeFirstResponder
{
    return YES;// default is NO
}
- (BOOL)canResignFirstResponder{
    return NO;
}
- (UIImage *)imagesNamedFromCustomBundle:(NSString *)imgName
{
    
    NSBundle *bundle = [EUtility bundleForPlugin:@"uexShakeView"];
    NSString *img_path = [[bundle resourcePath]stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",imgName]];
    return [UIImage imageWithContentsOfFile:img_path];
}
@end


