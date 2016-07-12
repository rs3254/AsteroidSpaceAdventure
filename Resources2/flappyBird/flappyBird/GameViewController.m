//
//  GameViewController.m
//  flappyBird
//
//  Created by Ray Sabbineni on 9/2/15.
//  Copyright (c) 2015 Ray Sabbineni. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController


-(void)score
{
    scoreNumber = scoreNumber +1;
    self.score2.text = [NSString stringWithFormat:@"%i", scoreNumber];
    
    
}

-(IBAction)startGame:(id)sender
{
    
    self.tunnellVerticalbottom.hidden = NO;
    self.tunnelVerticaltop.hidden = NO;
    self.startGame.hidden = YES;
    birdMovement = [NSTimer scheduledTimerWithTimeInterval:.05 target:self selector:@selector(BirdMoving) userInfo:nil repeats:YES];
    
    
    [self placeTunnel];
    
    tunnelMovement = [ NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(tunnelMoving) userInfo:nil repeats:YES];
    
    
}

-(void)tunnelMoving{
    
    self.tunnelVerticaltop.center = CGPointMake(self.tunnelVerticaltop.center.x -1 , self.tunnelVerticaltop.center.y);
    
    
    self.tunnellVerticalbottom.center = CGPointMake(self.tunnellVerticalbottom.center.x -1, self.tunnellVerticalbottom.center.y);
    
    if(self.tunnelVerticaltop.center.x < -28) {
        [self placeTunnel];
    }
    
    if(self.tunnelVerticaltop.center.x == 0)
    {
        [self score];
    }
    
    if(CGRectIntersectsRect(self.bird.frame, self.tunnelVerticaltop.frame))
    {
        [self gameOver];
    }
    if(CGRectIntersectsRect(self.bird.frame, self.tunnellVerticalbottom.frame))
    {
        [self gameOver];
    }
    
    if(self.bird.center.y == 0)
    {
        [self gameOver];
    }
    
}

-(void) gameOver {
    
    if(scoreNumber > highscore)
    {
        [[NSUserDefaults standardUserDefaults]setInteger:scoreNumber forKey:@"HighScoreSaved"]; 
    }
    
    
    [tunnelMovement invalidate];
    [birdMovement invalidate];
    self.exit.hidden = NO;
    self.tunnellVerticalbottom.hidden = YES;
    self.tunnelVerticaltop.hidden = YES;
    self.bird.hidden = YES;
    
}


-(void)placeTunnel {
    
    randpositionTop = arc4random_uniform(350);
    randpositionTop = randpositionTop - 228;
    
    randpositionBottom = randpositionTop + 750;
    
    self.tunnelVerticaltop.center = CGPointMake(340, randpositionTop);
    self.tunnellVerticalbottom.center = CGPointMake(340, randpositionBottom);
    
    
    
    
} 
-(void)BirdMoving
{
    self.bird.center = CGPointMake(self.bird.center.x, self.bird.center.y -birdFlight);

    birdFlight = birdFlight - 5;
    
    
    if( birdFlight < -15) {
        
        birdFlight = - 15;
    }
    
    if(birdFlight > 0)
    {
        self.bird.image = [ UIImage imageNamed:@"bird.png"];
        
    }
    if(birdFlight < 0)
    {
        self.bird.image = [ UIImage imageNamed:@"flappyBird.png"];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    birdFlight = 30;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tunnellVerticalbottom.hidden = YES;
    self.tunnelVerticaltop.hidden = YES;
    
    self.exit.hidden = YES;

    self.score2.text = @"0";

    scoreNumber = 0;

    highscore = [[NSUserDefaults standardUserDefaults]integerForKey:@"HighScoreSaved"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
