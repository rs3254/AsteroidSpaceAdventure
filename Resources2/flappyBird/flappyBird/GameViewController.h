//
//  GameViewController.h
//  flappyBird
//
//  Created by Ray Sabbineni on 9/2/15.
//  Copyright (c) 2015 Ray Sabbineni. All rights reserved.
//

#import <UIKit/UIKit.h>
int birdFlight;
int randpositionTop, randpositionBottom, scoreNumber;
NSInteger highscore;

@interface GameViewController : UIViewController
{
    NSTimer * birdMovement;
    NSTimer * tunnelMovement;
    
}

@property (strong, nonatomic) IBOutlet UIButton *startGame;

@property (strong, nonatomic) IBOutlet UIImageView *bird;


@property(strong, nonatomic)IBOutlet UIImageView * tunnelVerticaltop;
@property(strong, nonatomic)IBOutlet UIImageView * tunnellVerticalbottom;

@property (strong, nonatomic) IBOutlet UILabel *score2;

-(IBAction)startGame:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *exit;

-(void)BirdMoving;
-(void)tunnelMoving;
-(void)placeTunnel;
-(void)score;
-(void)gameOver;

@end
