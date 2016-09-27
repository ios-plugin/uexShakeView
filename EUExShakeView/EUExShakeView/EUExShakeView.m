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
@property(nonatomic, retain) NSMutableDictionary *frameDict;
@end
static AnimationView *animationView = nil;
@implementation EUExShakeView {
    
    BOOL currenOpenStaus;
}
-(id)initWithBrwView:(EBrowserView *) eInBrwView {
    self = [super initWithBrwView:eInBrwView];
    if (self) {
        
    }
    return self;
}
- (void)open:(NSMutableArray *) inArguments {
    if (currenOpenStaus) {
        return;
    }
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(onShakeView:)
                                                name:@"onShake"
                                              object:nil];
    
    
    NSString *jsonStr = nil;
    if (inArguments.count > 0) {
        jsonStr = [inArguments objectAtIndex:0];
        self.frameDict = [jsonStr JSONValue];
        
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
    animationView = [[AnimationView alloc]initWithFrame:CGRectMake(x, y, width, heigh)];
    [animationView becomeFirstResponder];
    [EUtility brwView:self.meBrwView addSubview:animationView];
    currenOpenStaus = YES;
}


- (void)close:(NSMutableArray *) inArguments {
    
    if (animationView) {
        [animationView resignFirstResponder];
        [animationView removeFromSuperview];
        animationView = nil;
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        currenOpenStaus = NO;
        
    }
}
- (void) onShakeView:(NSNotification *)notification {
    
    [self callBackJsonWithFunction:@"onShake"];
    
    
}
const static NSString *kPluginName=@"uexShakeView";
-(void)callBackJsonWithFunction:(NSString *)functionName {
    NSString *jsonStr = [NSString stringWithFormat:@"if(%@.%@ != null){%@.%@();}",kPluginName,functionName,kPluginName,functionName];
    [EUtility brwView:self.meBrwView evaluateScript:jsonStr];
    
}
@end
