//
//  ViewController.m
//  pushCounter
//
//  Created by Chiunti on 27/01/15.
//  Copyright (c) 2015 Chiunti. All rights reserved.
//

#import "PushCounter.h"
int counter;
int countDown;
NSTimer *initCountDown;
NSTimer *gameDuration;

@interface PushCounter ()

@end

@implementation PushCounter

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    countDown = 3;
    counter = 0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)CountToDown{
    countDown--;

    [self animatedLabelCountDown:countDown==0? @"Push!": [NSString stringWithFormat:@"%d",countDown]];
    //[UIView animateWithDuration:0.4 animations:^{
    //    self.lblCountDown.alpha = 0;
    //} completion:^(BOOL finished) {
    //    self.lblCountDown.text =  countDown==0? @"Push!": [NSString stringWithFormat:@"%d",countDown];
    //    [UIView animateWithDuration:0.4 animations:^{
    //        self.lblCountDown.alpha = 1;
    //    }];
    //}];

    
    if (countDown==0) {
        [initCountDown invalidate];
        self.btnPusher.hidden = false;
    }
}

-(void)animatedLabelCountDown:(NSString*) text{
    [UIView animateWithDuration:0.4 animations:^{
        self.lblCountDown.alpha = 0;
    } completion:^(BOOL finished) {
        self.lblCountDown.text =  text;
        [UIView animateWithDuration:0.4 animations:^{
            self.lblCountDown.alpha = 1;
        }];
    }];
    
}

- (IBAction)btnStartPressed:(id)sender {
    //self.btnPusher.hidden = false;
    self.btnStart.hidden = true;
    self.lblCountDown.hidden = false;
    [self animatedLabelCountDown:[NSString stringWithFormat:@"%d",countDown]];
    initCountDown = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(CountToDown) userInfo:nil repeats:YES];
    
}

- (IBAction)btnPusherPressed:(id)sender {
    counter++;
    self.lblCounter.text = [NSString stringWithFormat:@"%d",counter];
    self.lblCounter.hidden =false;
}
@end
