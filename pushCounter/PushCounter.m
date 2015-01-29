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
NSTimer *fontSize;
bool finished;

@interface PushCounter ()

@end

@implementation PushCounter




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self Reset];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)Reset{
    [initCountDown invalidate];
    [gameDuration invalidate];
    [fontSize invalidate];
    countDown = 3;
    counter = 0;
    finished = false;
    self.btnStart.hidden = false;
    self.btnPusher.hidden = true;
    self.btnResults.hidden = true;
    self.lblCounter.hidden = true;
    self.lblCounter.text = @"0";
    self.lblCountDown.hidden = true;
    self.lblCountDown.text = @"";
    self.lblCountDown.font = [UIFont systemFontOfSize:100];
    
    
}

-(void)CountToDown{
    countDown--;
    if (countDown==0) {
        [initCountDown invalidate];
        [fontSize invalidate];
        self.btnPusher.hidden = false;
        self.lblCountDown.text = @"Push!";
        countDown = 11;
        self.lblCountDown.font = [UIFont systemFontOfSize:50];
        gameDuration = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(GameCountToDown) userInfo:nil repeats:YES];
    } else
    [self animatedLabelCountDown:[NSString stringWithFormat:@"%d",countDown]];
}

-(void)GameCountToDown{
    countDown--;
    if (countDown==0) {
        [gameDuration invalidate];
        [fontSize invalidate];
        self.lblCountDown.text = @"Finish!";
        self.lblCountDown.font = [UIFont systemFontOfSize:50];
        finished = true;
        self.btnPusher.hidden = true;
        self.btnResults.hidden = false;
        self.btnStart.hidden = false;
        //
        // Finalizar
        // Mostrar resultados
        //
    } else
        [self animatedLabelCountDown:[NSString stringWithFormat:@"%d",countDown]];
}


-(void)FontToDown{
    self.lblCountDown.font = [UIFont systemFontOfSize:self.lblCountDown.font.pointSize-10];
}

-(void)animatedLabelCountDown:(NSString*) text{
    [UIView animateWithDuration:0.45 animations:^{
        self.lblCountDown.alpha = 0;
        [fontSize invalidate];
    } completion:^(BOOL finished) {
        self.lblCountDown.text =  text;
        self.lblCountDown.alpha = 1;
        self.lblCountDown.font = [UIFont systemFontOfSize:100];
        fontSize = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(FontToDown) userInfo:nil repeats:YES];
        
    }];
    
}

- (IBAction)btnStartPressed:(id)sender {
    [self Reset];
    self.btnStart.hidden = true;
    self.lblCountDown.hidden = false;
    [self animatedLabelCountDown:[NSString stringWithFormat:@"%d",countDown]];
    initCountDown = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(CountToDown) userInfo:nil repeats:YES];
    
}

- (IBAction)btnPusherPressed:(id)sender {
    if (!finished) {
        counter++;
        self.lblCounter.text = [NSString stringWithFormat:@"%d",counter];
        self.lblCounter.hidden =false;
    }

}
@end
