//
//  GameScene.h
//  AsteroidGame4
//

//  Copyright (c) 2015 Ray Sabbineni. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@class GameScene;

@interface TitleScene : SKScene {
    NSTimer * timer;

    SKLabelNode * highScore;

}

@property(nonatomic) float HighScoreInt;
@property(nonatomic) float HighScoreFloat2;

@property(nonatomic, retain)GameScene * floatObj;

@end
