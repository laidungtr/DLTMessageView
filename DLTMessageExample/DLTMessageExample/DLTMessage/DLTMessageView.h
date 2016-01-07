//
//  DLTMessageView.h
//  ViecNha
//
//  Created by ttiamap on 07/01/2016.
//  Copyright © 2016 tiamap. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLTMessage.h"

@interface DLTMessageView : UIView{
    
}

@property(nonatomic, weak) id <DLTMessageDelegate> delegate;

- (void)initWithMessageTitle:(NSString *)title
                     message:(NSString *)message
                    duration:(NSTimeInterval)duration;

- (void)setLabelMessage:(NSString *)message;
- (void)setLabelTitle:(NSString *)title;

- (void)dismissMessageView:(completeBlock)complete;

@end
