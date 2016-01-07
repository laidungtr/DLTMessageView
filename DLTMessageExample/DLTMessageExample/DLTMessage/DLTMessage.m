//
//  DLTMessage.m
//  ViecNha
//
//  Created by ttiamap on 07/01/2016.
//  Copyright © 2016 tiamap. All rights reserved.
//

#import "DLTMessage.h"
#import "DLTMessageView.h"

#define SCREEN_WIDTH  [[UIScreen mainScreen]bounds].size.width

@implementation DLTMessage{
    
    DLTMessageView *messageView;
}

static DLTMessage *_shareController = nil;

+ (DLTMessage *)shareController {
    
    @synchronized(self){
        if(_shareController == nil){
            _shareController= [DLTMessage new];
        }
    }
    return _shareController;
}

#pragma mark - Show Notification

/** Showing Notification Without Duration to dissmiss ViewMess */

+ (void)showNotificationWithTitle:(NSString *)title message:(NSString *)message{
    [[self shareController] showNotificationWithTitle:title message:message];
}

- (void)showNotificationWithTitle:(NSString *)title message:(NSString *)message{
    [self showMessageViewWithTitle:title message:message duration:0];
}

/**
 Showing Notification With Duration to dissmiss ViewMess */

+ (void)showNotificationWithTitle:(NSString *)title message:(NSString *)message duration:(NSTimeInterval)duration{
    [[self shareController] showNotificationWithTitle:title message:message duration:duration];
}

- (void)showNotificationWithTitle:(NSString *)title message:(NSString *)message duration:(NSTimeInterval)duration{
    [self showMessageViewWithTitle:title message:message duration:duration];
}

- (void)showMessageViewWithTitle:(NSString *)title message:(NSString *)message duration:(NSTimeInterval)duration{
    if (!messageView) {
        NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"DLTMessageView" owner:nil options:nil];
        
        // Find the view among nib contents (not too hard assuming there is only one view in it).
        messageView = [nibContents lastObject];
    }
    messageView.delegate = self.delegate;
    [messageView initWithMessageTitle:title message:message duration:duration];
    
    messageView.frame = (CGRect){0, -75.0, SCREEN_WIDTH,75.0};
    [[[UIApplication sharedApplication] keyWindow] addSubview:messageView];
}

#pragma mark - Dissmiss
+ (void)dismissDLTMessage:(completeBlock)complete{
    [[self shareController] dismissDLTMessage:complete];
}

- (void)dismissDLTMessage:(completeBlock)complete{
    if (messageView) {
        [messageView dismissMessageView:complete];
    }
}

@end
