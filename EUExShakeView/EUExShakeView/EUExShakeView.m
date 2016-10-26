//
//  EUExShakeView.m
//  EUExShakeView
//
//  Created by liguofu on 14/12/31.
//  Copyright (c) 2014年 AppCan.can. All rights reserved.
//

#import "EUExShakeView.h"
#import "EUtility.h"
@interface EUExShakeView ()
@property(nonatomic, retain) NSDictionary *frameDict;
@end
static AnimationView *animationView = nil;
@implementation EUExShakeView {
    
    BOOL currenOpenStaus;
}
- (void)open:(NSMutableArray *) inArguments {
    if (currenOpenStaus) {
        return;
    }
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(onShakeView:)
                                                name:@"onShake"
                                              object:nil];
    
    
    if (inArguments.count > 0) {
        ACArgsUnpack(NSDictionary *dic) = inArguments;
        self.frameDict = dic;
        
    } else {
        
        return;
    }
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    
    float x = [[self.frameDict objectForKey:@"x"] floatValue];
    float y = [[self.frameDict objectForKey:@"y"] floatValue];
    float width = [[self.frameDict objectForKey:@"w"] floatValue];
    float heigh = [[self.frameDict objectForKey:@"h"] floatValue];
    if (width <= 0||width>[EUtility screenWidth]) {
        width = [EUtility screenWidth];
    }
    if (heigh <= 0||heigh>[EUtility screenHeight]) {
        heigh = [EUtility screenHeight];
    }
    
    NSString* backgroundImagePath =self.frameDict[@"backgroundImagePath"]? [self absPath:self.frameDict[@"backgroundImagePath"]]:nil;
    NSString* upImagePath = self.frameDict[@"upImagePath"]?[self absPath:self.frameDict[@"upImagePath"]]:nil;
    NSString* downImagePath = self.frameDict[@"downImagePath"]?[self absPath:self.frameDict[@"downImagePath"]]:nil;
    if (!animationView) {
        animationView = [[AnimationView alloc]initWithFrame:CGRectMake(x, y, width, heigh) backgroundImagePath:backgroundImagePath upImagePath:upImagePath downImagePath:downImagePath];
    }

    [animationView becomeFirstResponder];
    [[self.webViewEngine webView] addSubview:animationView];
    currenOpenStaus = YES;
}


- (void)close:(NSMutableArray *) inArguments {
    
    if (animationView) {
        [animationView resignFirstResponder];
        [animationView removeFromSuperview];
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        currenOpenStaus = NO;
        
    }
}
- (void) onShakeView:(NSNotification *)notification {
    
    [self callBack];
    
    
}
const static NSString *kPluginName=@"uexShakeView";
-(void)callBack{
    [self.webViewEngine callbackWithFunctionKeyPath:@"uexShakeView.onShake" arguments:nil];
    
    
}
@end
