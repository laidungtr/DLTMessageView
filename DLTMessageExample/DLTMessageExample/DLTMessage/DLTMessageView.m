//
//  DLTMessageView.m
//  ViecNha
//
//  Created by ttiamap on 07/01/2016.
//  Copyright © 2016 tiamap. All rights reserved.
//

#import "DLTMessageView.h"

#define kAnimateDuration 0.25

@interface DLTMessageView (){
    
    NSTimer *timerShowing;
    NSTimeInterval _duration;
}

@property(nonatomic, weak) IBOutlet UILabel *lbTitle;
@property(nonatomic, weak) IBOutlet UILabel *lbMessage;
@property(nonatomic, weak) IBOutlet UIView *viewMessageContain;

@end

@implementation DLTMessageView

-(void)awakeFromNib{
    NSLog(@"view awake from nib");
}

#pragma mark - Init
- (void)initWithMessageTitle:(NSString *)title message:(NSString *)message duration:(NSTimeInterval)duration{
    
    [self setLabelTitle:title];
    [self setLabelMessage:message];
    _duration = duration;
    
    [self gestureTapAddToView:self.viewMessageContain];
    [self performSelector:@selector(animateView) withObject:nil afterDelay:kAnimateDuration];
}

- (void)gestureTapAddToView:(UIView *)targetView{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(DLTMessageTap)];
    targetView.userInteractionEnabled = YES;
    [targetView addGestureRecognizer:tapGesture];
}

#pragma mark - Setter
- (void)setLabelMessage:(NSString *)message{
    _lbMessage.text = message;
}

- (void)setLabelTitle:(NSString *)title{
    _lbTitle.text = title;
}

#pragma mark - Action
- (void)DLTMessageTap{
    NSLog(@"Notification Message Tap");
    [self timeEndShowingView:nil];
    if (_delegate) {
        [[self delegate] DLTMessageDelegate_DidTapMessage];
    }
}

- (void)dismissMessageView:(completeBlock)complete{
    [self timeEndShowingView:complete];
}


#pragma mark - Animate
- (void)animateView{
    
    CGRect frame = self.bounds;
    [UIView animateWithDuration:kAnimateDuration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.frame = CGRectMake(frame.origin.x, 0, frame.size.width, frame.size.height);
    } completion:^(BOOL finished) {
        
        if (_duration > 0) {
            timerShowing = [NSTimer scheduledTimerWithTimeInterval:_duration target:self selector:@selector(timeEndShowingView:) userInfo:nil repeats:NO];
        }
        
        NSLog(@"animate run complete");
    }];
    
}

- (void)timeEndShowingView:(completeBlock)complete{
    
    [timerShowing invalidate];
    timerShowing = nil;
    
    CGRect frame = self.bounds;
    frame.origin.y = -100.0;
    
    [UIView animateWithDuration:kAnimateDuration animations:^{
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
        if (complete) {
            complete();
        }
    }];
}


@end
