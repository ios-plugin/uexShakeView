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
@property (nonatomic,unsafe_unretained) AnimationView *animationView;
@end
@implementation EUExShakeView {
    
    CGPoint bgViewPoint;
    BOOL currenOpenStaus;
}
-(id)initWithBrwView:(EBrowserView *) eInBrwView {
    self = [super initWithBrwView:eInBrwView];
    if (self) {
        
    }
    return self;
}
- (void)open:(NSMutableArray *) inArguments {
   
    [[NSNotificationCenter defaultCenter]addObserver:self
                                                selector:@selector(onShakeView:)
                                                    name:@"onShake"
                                                  object:nil];
    
    self.animationView = [AnimationView sharedInstance];
    NSString *jsonStr = nil;
    if (inArguments.count > 0) {
        jsonStr = [inArguments objectAtIndex:0];
        self.animationView.frameDict = [jsonStr JSONValue];
        
    } else {
        
        return;
    }
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    [self.animationView becomeFirstResponder];
    float x = [[ self.animationView.frameDict objectForKey:@"x"] floatValue];
    float y = [[ self.animationView.frameDict objectForKey:@"y"] floatValue];
    float width = [[ self.animationView.frameDict objectForKey:@"w"] floatValue];
    float heigh = [[ self.animationView.frameDict objectForKey:@"h"] floatValue];
    self.animationView.frame = CGRectMake(x, y, width, heigh);
     
     [EUtility brwView:self.meBrwView addSubview:self.animationView];
    
}
- (BOOL)canBecomeFirstResponder
{
    return YES;
}
//- (BOOL)canResignFirstResponder{
//    
//    return NO;
//}

- (void)close:(NSMutableArray *) inArguments {
    
    if (self.animationView) {
        [self.animationView removeFromSuperview];
        self.animationView = nil;
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    
        
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
