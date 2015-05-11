//
//  EUExShakeView.m
//  EUExShakeView
//
//  Created by liguofu on 14/12/31.
//  Copyright (c) 2014年 AppCan.can. All rights reserved.
//

#import "EUExShakeView.h"
#import "EUtility.h"

@implementation EUExShakeView {
    
    CGPoint bgViewPoint;
    BOOL currenOpenStaus;
}

- (void)open:(NSMutableArray *) inArguments {
    
    if (currenOpenStaus == YES) {
        return;
    }
    //注册通知
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(onShakeView:)
                                                name:@"onShake"
                                              object:nil];
    
    self.AVC = [[AnimationPauseViewController alloc]init];
    NSString *jsonStr = nil;
    currenOpenStaus = YES;
    if (inArguments.count > 0) {
        
        jsonStr = [inArguments objectAtIndex:0];
        self.AVC.frameDict = [jsonStr JSONValue];
        
    } else {
        
        return;
    }
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    [self.AVC becomeFirstResponder];
    float x = [[ self.AVC.frameDict objectForKey:@"x"] floatValue];
    float y = [[ self.AVC.frameDict objectForKey:@"y"] floatValue];
    float width = [[ self.AVC.frameDict objectForKey:@"w"] floatValue];
    float heigh = [[ self.AVC.frameDict objectForKey:@"h"] floatValue];
    
    self.AVC.view.frame = CGRectMake(x, y, width, heigh);
    [EUtility brwView:self.meBrwView addSubview:self.AVC.view];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate {
    
    return  NO;
}

- (void)close:(NSMutableArray *) inArguments {
    
    if (self.AVC) {
        [self.AVC.view removeFromSuperview];
        self.AVC = nil;
        currenOpenStaus = NO;
        [[NSNotificationCenter defaultCenter] removeObserver:self];

    }
}
- (void) onShakeView:(NSNotification *)notification {
    
[self.meBrwView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"uexShakeView.onShake()"]];
}

@end
