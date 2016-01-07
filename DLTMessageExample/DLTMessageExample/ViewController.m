//
//  ViewController.m
//  DLTMessageExample
//
//  Created by ttiamap on 1/7/16.
//  Copyright © 2016 ttiamap. All rights reserved.
//

#import "ViewController.h"
#import "DLTMessage.h"

@interface ViewController ()<DLTMessageDelegate>{
    BOOL isShowing;
}

@property(nonatomic, weak) IBOutlet UIButton *btnShow;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [DLTMessage shareController].delegate = (id)self;
}

- (IBAction)btnShowMessTap:(id)sender{
    if (isShowing) {
        isShowing = NO;
        [_btnShow setTitle:@"Show Message" forState:UIControlStateNormal];
        [DLTMessage dismissDLTMessage:^{
            NSLog(@"Message view was Dissmiss");
        }];
    }else{
        isShowing = YES;
        [_btnShow setTitle:@"Dismiss Message" forState:UIControlStateNormal];
        [DLTMessage showNotificationWithTitle:@"You have a notification" message:@"This is a sample notification view"];
    }
}

#pragma mark - Delegate
- (void)DLTMessageDelegate_DidTapMessage{
    isShowing = NO;
    [_btnShow setTitle:@"Show Message" forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
