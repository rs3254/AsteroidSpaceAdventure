//
//  GameScene.h
//  
//
//  Created by Ray Sabbineni on 9/13/15.
//
//

#import <SpriteKit/SpriteKit.h>
#import <UIKit/UIKit.h>
#import "TitleScene.h"
#import <AudioToolBox/AudioServices.h>

@interface GameScene : SKScene<SKPhysicsContactDelegate> {
    NSTimer *timer2;
    NSTimer * timer3;
    NSTimer * timer4;
    NSTimer * timer5;
    NSTimer * timer6;
    NSTimer * timer7;
    
    UIDynamicAnimator * animator;
    UICollisionBehavior * collision;
    UIAttachmentBehavior * attachement;
    SystemSoundID ExplosionID;
}



@property(strong, nonatomic) SKSpriteNode * spaceShip2;
@property(strong, nonatomic)UITouch * spaceShipTouch;

@property(strong, nonatomic) SKEmitterNode * fire;
//@property(strong, nonatomic)SKEmitterNode * explosionTemplate;

@property(strong, nonatomic)SKSpriteNode * plasma;
@property (nonatomic) BOOL isFingerOnSpaceShip;


@property(strong, nonatomic) SKSpriteNode * brownAsteroid1;
@property(strong, nonatomic) SKSpriteNode * brownAsteroid2;
@property(strong, nonatomic) SKSpriteNode * brownAsteroid3;

@property(strong,nonatomic)SKSpriteNode * asteroid1;
@property(strong, nonatomic) SKSpriteNode * asteroid2;

@property(strong, nonatomic)NSMutableArray * shiplaser;
@property(strong, nonatomic)NSMutableArray * explosionArray; 
@property(strong, nonatomic)NSMutableArray * asteroidArray; 

@property(strong, nonatomic)SKLabelNode * label;
@property(strong, nonatomic)SKLabelNode * scoreNum; 
@property(nonatomic)float timeobj;

@end
