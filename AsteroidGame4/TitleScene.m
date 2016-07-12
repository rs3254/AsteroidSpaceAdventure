//
//  GameScene.m
//  AsteroidGame4
//
//  Created by Ray Sabbineni on 9/13/15.
//  Copyright (c) 2015 Ray Sabbineni. All rights reserved.
//

#import "TitleScene.h"
#import "GameScene.h"

SKNode * bgImage;
TitleScene * scene;
float highScoreFloat;
@implementation TitleScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */

    
    highScoreFloat = [[NSUserDefaults standardUserDefaults]floatForKey:@"RayScoreKey"];
    NSLog(@"%f", highScoreFloat);
    bgImage = [SKNode node];
    [self addChild:bgImage];
    
    
    SKTexture * bgTexture = [SKTexture textureWithImageNamed:@"space2"];
    SKAction * bgMove = [SKAction moveByX:0 y:-bgTexture.size.height*2 duration:.08*bgTexture.size.height];
    SKAction * bgReset = [SKAction moveByX:0 y:bgTexture.size.height*2 duration:0];
    SKAction * moveForever = [SKAction repeatActionForever:[SKAction sequence:@[bgMove, bgReset]]];
    for (int i = 0; i < 2 + self.frame.size.height/(bgTexture.size.height*2); ++i)
    {
        SKSpriteNode * bgSprite = [ SKSpriteNode spriteNodeWithTexture:bgTexture];
        bgSprite.zPosition = - 20;
        bgSprite.anchorPoint = CGPointZero;
        bgSprite.position = CGPointMake(0,i*bgSprite.size.height);
        [bgSprite runAction:moveForever];
        [bgImage addChild:bgSprite];
        
        
        
    }
    
    
    SKSpriteNode * spaceShip = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
    spaceShip.xScale = .15;
    spaceShip.yScale = .15;
    spaceShip.position = CGPointMake(self.size.width/2, self.size.height/2);
    
    SKLabelNode * label = [SKLabelNode node];
    label.fontName = @"Times New Roman";
    label.fontSize = 20;
    label.text = @"Asteroid Space Adventure";
    label.fontColor = [ SKColor whiteColor];
    label.position = CGPointMake(self.size.width/2, self.size.height/1.2);

    
    highScore = [ SKLabelNode node];
    highScore.fontSize = 16;
    highScore.fontName  = @"Times New Roman";
    highScore.text = [NSString stringWithFormat:@"High Score  %.0f", highScoreFloat];
                            
    highScore.fontColor = [ SKColor whiteColor];
    highScore.position = CGPointMake(self.size.width/2, self.size.height/1.6);
    

    
   [self fireEmitter];
   [self addChild:spaceShip];
   [self addChild:highScore];
   [self addChild:label];
}


-(void)fireEmitter {
    SKEmitterNode * fire = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle]pathForResource:@"MyParticle" ofType:@"sks"]];
    
    
        fire.position = CGPointMake(self.size.width/2, self.size.height/2-30);
        fire.targetNode =  self.scene;
                            
                            
    [self addChild:fire];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    GameScene *scene= [GameScene sceneWithSize:self.frame.size];
    SKTransition * transition = [SKTransition fadeWithDuration:1.0];
    [self.view presentScene:scene transition:transition];
    
    
}


-(void)update:(CFTimeInterval)currentTime {
   
}

@end
