//
//  DLTMessage.h
//  ViecNha
//
//  Created by ttiamap on 07/01/2016.
//  Copyright © 2016 tiamap. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^completeBlock)();

@protocol DLTMessageDelegate <NSObject>

- (void)DLTMessageDelegate_DidTapMessage;

@end

@interface DLTMessage : NSObject

@property(nonatomic, weak) id <DLTMessageDelegate> delegate;

+ (DLTMessage *)shareController;

/** Showing Notification Without Duration to dissmiss ViewMess */
+ (void)showNotificationWithTitle:(NSString *)title
                          message:(NSString *)message;

/** Showing Notification With Duration to dissmiss ViewMess */
+ (void)showNotificationWithTitle:(NSString *)title
                          message:(NSString *)message
                         duration:(NSTimeInterval)duration;
/** Dissmiss ViewMess */
+ (void)dismissDLTMessage:(completeBlock)complete;

@end
