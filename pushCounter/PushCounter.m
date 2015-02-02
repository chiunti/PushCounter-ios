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

typedef enum{Idle,Show,Start,Game,Finish} gameState;
gameState currentState = Idle;



@interface PushCounter ()

@end

@implementation PushCounter

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if (currentState==Idle) {
        [self setState:Show];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setState: (gameState)state{
    self.btnStart.hidden       = ! (state == Show|state == Finish);
    self.btnPusher.hidden      = ! (state == Game);
    self.btnResults.hidden     = ! (state == Finish);
    self.lblCounter.hidden     = ! (state == Game|state == Finish);
    //self.lblCountDown.hidden   = ! (state == Start|state == Game);
    self.lblStartFinish.hidden = ! (state == Start|state == Game);
    self.lblInstructions.hidden= ! (state == Show);
    currentState = state;
    switch (state){
        case Show:
            [initCountDown invalidate];
            [gameDuration invalidate];
            [fontSize invalidate];
            countDown = 3;
            counter = 0;
            self.lblCounter.text = @"0";
            self.lblCountDown.text = @"";
            self.lblCountDown.font = [UIFont systemFontOfSize:100];
            break;
        case Start:
            [initCountDown invalidate];
            [gameDuration invalidate];
            [fontSize invalidate];
            countDown = 3;
            counter = 0;
            self.lblCounter.text = @"0";
            self.lblCountDown.text = @"";
            self.lblCountDown.font = [UIFont systemFontOfSize:100];
            self.lblStartFinish.text = @"The game start in";
            [self animatedLabelCountDown:[NSString stringWithFormat:@"%d",countDown]];
            initCountDown = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(CountToDown) userInfo:nil repeats:YES];
            break;
        case Game:
            [initCountDown invalidate];
            [fontSize invalidate];
            self.lblStartFinish.text = @"The game finish in";
            self.lblCountDown.text = @"";
            countDown = 10;
            self.lblCountDown.font = [UIFont systemFontOfSize:50];
            [self animatedLabelCountDown:[NSString stringWithFormat:@"%d",countDown]];
            gameDuration = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(GameCountToDown) userInfo:nil repeats:YES];
            break;
        case Finish:
            [gameDuration invalidate];
            [fontSize invalidate];
            self.lblCountDown.text = @"Finish!";
            self.lblCountDown.font = [UIFont systemFontOfSize:50];
            finished = true;
            //
            [self Save];
            // cambiar a resultados
            [self performSegueWithIdentifier:@"HomeToResults" sender:self];
            break;
            
        default:
            break;
    }
}


-(BOOL)Save{
    BOOL success = NO;
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];

    
    success = [[DBManager getSharedInstance]saveData:
               [NSString stringWithFormat:@"%i",counter]
               detail:[DateFormatter stringFromDate:[NSDate date]]];
    return success;
}


-(void)CountToDown{
    countDown--;
    if (countDown==0) {
        [self labelCountDown:[NSString stringWithFormat:@"%d",countDown]];
        [self setState:Game];
    } else
        [self animatedLabelCountDown:[NSString stringWithFormat:@"%d",countDown]];
}

-(void)GameCountToDown{
    countDown--;
    if (countDown==0) {
        [self labelCountDown:[NSString stringWithFormat:@"%d",countDown]];
        [self setState:Finish];
    } else
        [self animatedLabelCountDown:[NSString stringWithFormat:@"%d",countDown]];
}


-(void)FontToDown{
    self.lblCountDown.font = [UIFont systemFontOfSize:self.lblCountDown.font.pointSize*.8];
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
-(void)labelCountDown:(NSString*) text{
        self.lblCountDown.text =  text;
        self.lblCountDown.alpha = 1;
        self.lblCountDown.font = [UIFont systemFontOfSize:100];
}

- (IBAction)btnStartPressed:(id)sender {
    [self setState:Start];
    
}

- (IBAction)btnPusherPressed:(id)sender {
    if (currentState == Game) {
        counter++;
        self.lblCounter.text = [NSString stringWithFormat:@"%d",counter];
        self.lblCounter.hidden =false;
    }

}
@end
