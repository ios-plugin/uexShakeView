//
//  AnimationPauseViewController.m
//  AnimationPause
//
//  Created by gamy on 12-1-5.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "AnimationPauseViewController.h"
#import "EUtility.h"

@implementation AnimationPauseViewController{
    CGPoint bgViewPoint;
    float moveY;
    float moveX;
}
//添加
@synthesize imgUp;
@synthesize imgDown;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
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
    //  NSLog(@"begin");
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    
    if(motion==UIEventSubtypeMotionShake)
    {
        //添加
        [self addAnimations];
        //添加
        AudioServicesPlaySystemSound (soundID);
    }
    [self performSelector:@selector(motionEndAfter) withObject:self afterDelay:1.0];
}

- (void)motionEndAfter {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"uexShakeView/shake_match" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:path], &soundIDAfter);
    AudioServicesPlaySystemSound (soundIDAfter);
    [[NSNotificationCenter defaultCenter]postNotificationName:@"onShake" object:self];
    
}

//添加
-(void)dealloc{
    [imgDown release];
    [imgUp release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //float x = [[self.frameDict objectForKey:@"x"] floatValue];
    //float y = [[self.frameDict objectForKey:@"y"] floatValue];
    float width = [[self.frameDict objectForKey:@"w"] floatValue];
    float heigh = [[self.frameDict objectForKey:@"h"] floatValue];
    
    if (width <= 0||width>[EUtility screenWidth]) {
        width = [EUtility screenWidth];
    }
    if (heigh <= 0||heigh>[EUtility screenHeight]) {
        heigh = [EUtility screenHeight];
    }
    
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, heigh)];
    bgView.image = [UIImage imageNamed:@"uexShakeView/ShakeHideImg_women.png"];
    [self.view addSubview:bgView];
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(width/4, heigh/4, width/2, heigh/2);
    [bgView addSubview:view];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"uexShakeView/shake" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:path], &soundID);
    imgUp = [[UIImageView alloc] initWithFrame:CGRectMake(0, -10, width/2, heigh/4)];
    imgUp.image = [UIImage imageNamed:@"uexShakeView/Shake_Logo_Up"];
    [view addSubview:imgUp];
    imgDown = [[UIImageView alloc] initWithFrame:CGRectMake(0,  heigh/4-10, width/2,heigh/4)];
    imgDown.image = [UIImage imageNamed:@"uexShakeView/Shake_Logo_Down"];
    [view addSubview:imgDown];
    moveX = imgUp.center.x;
    moveY = heigh/4;
    [bgView release];
    [view release];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;// default is NO
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self resignFirstResponder];
}

- (void)viewDidUnload
{
    
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate {
    
    return  NO;
}
@end
