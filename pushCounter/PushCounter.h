//
//  ViewController.h
//  pushCounter
//
//  Created by Chiunti on 27/01/15.
//  Copyright (c) 2015 Chiunti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PushCounter : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *lblCounter;

@property (strong, nonatomic) IBOutlet UIButton *btnPusher;
@property (strong, nonatomic) IBOutlet UIButton *btnStart;
@property (strong, nonatomic) IBOutlet UILabel *lblCountDown;

- (IBAction)btnStartPressed:(id)sender;
- (IBAction)btnPusherPressed:(id)sender;

@end

