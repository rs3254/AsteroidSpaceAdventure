//
//  GameScene.m
//  
//
//  Created by Ray Sabbineni on 9/13/15.
//
//

#import "GameScene.h"
#import "TitleScene.h"


static const uint32_t plasmaCategory    =  0x1 << 3;
static const uint32_t AsteroidCategory  =  0x1 << 1;
static const uint32_t spaceShipCategory  =  0x1 << 2;

SKSpriteNode * plasmaWeapon;
SKEmitterNode * fire2;
UITapGestureRecognizer * object;
SKNode * bgImage2;
SKLabelNode * p;
SKLabelNode * Game;

SKSpriteNode * smallAsteroid1;
SKSpriteNode* smallAsteroid2;
SKSpriteNode* smallAsteroid3;
SKSpriteNode* smallAsteroid4;


float xtime;
float time1 = 0;
float time2;
float HighScoreTime;

@implementation GameScene


-(void)didMoveToView:(SKView *)view {

    HighScoreTime = [[NSUserDefaults standardUserDefaults]floatForKey:@"RayScoreKey"];
    
    TitleScene * titleS = [[ TitleScene alloc]init];
    titleS.HighScoreFloat2 = HighScoreTime;
    
    
    bgImage2 = [SKNode node];
    [self addChild:bgImage2];
    
    self.size = view.bounds.size;

    
    SKTexture * bgTexture2 = [SKTexture textureWithImageNamed:@"space2"];
    
    SKAction *bgMove2 = [SKAction moveByX:0 y:-bgTexture2.size.height*2 duration:.08*bgTexture2.size.height];
    SKAction * bgReset2 = [SKAction moveByX:0 y:bgTexture2.size.height*2 duration:0];
    SKAction * moveForever2 = [SKAction repeatActionForever:[SKAction sequence:@[bgMove2, bgReset2]]];
    
    for( int i = 0; i < 2+ self.frame.size.height/(bgTexture2.size.height*2); ++i )
    {
        SKSpriteNode * bgSprite = [SKSpriteNode spriteNodeWithTexture:bgTexture2];
        bgSprite.zPosition = -20;
        bgSprite.anchorPoint = CGPointZero;
        bgSprite.position = CGPointMake(0, i*bgSprite.size.height);
        [bgSprite runAction:moveForever2];
        [bgImage2 addChild:bgSprite];
        
    }
        
    
    
    self.shiplaser = [[NSMutableArray alloc]init];
    self.explosionArray = [[NSMutableArray alloc]init];

   

    self.spaceShip2 = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
    self.spaceShip2.xScale = .15;
    self.spaceShip2.yScale = .15;
    self.spaceShip2.position = CGPointMake(self.size.width/2, self.size.height/5);
    self.spaceShip2.name = @"Space";
    
    self.spaceShip2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.spaceShip2.frame.size];
    self.spaceShip2.physicsBody.restitution = 0.1f;
    self.spaceShip2.physicsBody.friction = 0.0f;
    self.spaceShip2.physicsBody.dynamic = NO;
    self.spaceShip2.physicsBody.affectedByGravity = NO;
    
    self.brownAsteroid1 = [self createBrownAsteroid:100 position:600 name:@"ballName"];
    [self addChild:self.brownAsteroid1];

    self.brownAsteroid2 = [self createBrownAsteroid:200 position:600 name:@"ball2Name"];
    [self addChild:self.brownAsteroid2];
    
    self.brownAsteroid3 = [self createBrownAsteroid:300 position:600 name:@"ball3Name"];
    [self addChild:self.brownAsteroid3];

    
    self.asteroid1 = [self createAsteroids:self.view.frame.size.width/2 position:self.view.frame.size.height*1.7 name:@"asteroid1"];
    self.asteroid1.xScale = .2;
    self.asteroid1.yScale = .2;
    [self addChild:self.asteroid1];
    
    self.asteroid2 = [self createAsteroids:self.view.frame.size.width/4 position:self.view.frame.size.height*1.3 name:@"asteroid2"];
    self.asteroid2.xScale = .15;
    self.asteroid2.yScale = .15;
    [self addChild:self.asteroid2];
    

    smallAsteroid1 = [self createSmallAsteroid:self.scene.size.width/3 position:self.scene.size.height*2 name:@"smallAsteroid1"];
    [self addChild:smallAsteroid1];


    
    smallAsteroid2 = [self createSmallAsteroid:self.scene.size.width/1.2 position:self.scene.size.height*2.2 name:@"smallAsteroid2"];
    [self addChild:smallAsteroid2];
    
    
    smallAsteroid3 = [self createSmallAsteroid:self.scene.size.width/1.5 position:self.scene.size.height*2.2 name:@"smallAsteroid3"];
    [self addChild:smallAsteroid3];
    

    
    smallAsteroid4 = [self createSmallAsteroid:self.scene.size.width/1.5 position:self.scene.size.height*2.2 name:@"smallAsteroid4"];
    [self addChild:smallAsteroid4];
    
    // Set category bit masks and contact bit masks 
    self.asteroid1.physicsBody.categoryBitMask = AsteroidCategory;
    self.asteroid1.physicsBody.contactTestBitMask = spaceShipCategory | plasmaCategory;
    
    
    self.brownAsteroid1.physicsBody.categoryBitMask = AsteroidCategory;
    self.spaceShip2.physicsBody.categoryBitMask = spaceShipCategory;
    self.brownAsteroid1.physicsBody.contactTestBitMask = spaceShipCategory | plasmaCategory;
    
    self.brownAsteroid2.physicsBody.categoryBitMask = AsteroidCategory;
    self.brownAsteroid2.physicsBody.contactTestBitMask = spaceShipCategory | plasmaCategory;

    self.brownAsteroid3.physicsBody.categoryBitMask = AsteroidCategory;
    self.brownAsteroid3.physicsBody.contactTestBitMask = spaceShipCategory | plasmaCategory;
    

    self.asteroid1.physicsBody.categoryBitMask = AsteroidCategory;
    self.asteroid1.physicsBody.contactTestBitMask = spaceShipCategory | plasmaCategory;

    self.asteroid2.physicsBody.categoryBitMask = AsteroidCategory;
    self.asteroid2.physicsBody.contactTestBitMask = spaceShipCategory| plasmaCategory;
    
    smallAsteroid1.physicsBody.categoryBitMask = AsteroidCategory;
    smallAsteroid1.physicsBody.contactTestBitMask = spaceShipCategory | plasmaCategory;
    
    smallAsteroid2.physicsBody.categoryBitMask = AsteroidCategory;
    smallAsteroid2.physicsBody.contactTestBitMask = spaceShipCategory | plasmaCategory;
    
    smallAsteroid3.physicsBody.categoryBitMask = AsteroidCategory;
    smallAsteroid3.physicsBody.contactTestBitMask = spaceShipCategory | plasmaCategory;
    
    smallAsteroid4.physicsBody.categoryBitMask = AsteroidCategory;
    smallAsteroid4.physicsBody.contactTestBitMask = spaceShipCategory | plasmaCategory;
    
    object = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(plasmaBomb)];
    [self.view addGestureRecognizer:object];
    
    
    self.label = [SKLabelNode node];
    self.label.fontName = @"Times New Roman";
    self.label.text = @"Score";
    self.label.fontColor = [ SKColor whiteColor];
    self.label.position = CGPointMake(self.size.width/5, self.size.height/1.1);
    self.label.xScale = 1.0;
    
    self.scoreNum = [SKLabelNode node];
    self.scoreNum.fontName = @"Times New Roman";
    self.scoreNum.fontColor = [SKColor whiteColor];
    self.scoreNum.fontSize = 22;
    self.scoreNum.position = CGPointMake(self.size.width/2.2, self.size.height/1.1);
    [self addChild:self.scoreNum];

    
    timer3 = [ NSTimer scheduledTimerWithTimeInterval:.05 target:self selector:@selector(plasmaBombMove) userInfo:nil repeats:YES];
    timer4 =[NSTimer scheduledTimerWithTimeInterval:.05 target:self selector:@selector(MoveAsteroid) userInfo:nil repeats:YES];
  
    timer7 = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    
    [self addChild:self.spaceShip2];
    [self fireEmitter];

    [self addChild:self.label];

    self.physicsWorld.contactDelegate = self;
    
  
    [self addChild:[self buttonPress]];
    
    
    NSString * ExplosionPath = [[NSBundle mainBundle]pathForResource:@"Explosion" ofType:@"wav"];
    CFURLRef explosionPath = (__bridge CFURLRef)[NSURL fileURLWithPath:ExplosionPath];
    AudioServicesCreateSystemSoundID (explosionPath, &ExplosionID);
}





-(SKLabelNode*)buttonPress {
    p = [SKLabelNode node];
    p.position = CGPointMake(self.size.width/1.2, self.size.height/1.1);
    p.fontColor = [SKColor whiteColor];
    p.fontName = @"Times New Roman";
    p.text = @"Pause";
    p.name = @"Pause";
    return p;
    
}

-(SKLabelNode*)PlayAgain{
    Game = [SKLabelNode node];
    Game.position = CGPointMake(self.size.width/2, self.size.height/2);
    Game.fontName = @"Times New Roman";
    Game.fontColor = [SKColor whiteColor];
    Game.text = @"Play Again";
    Game.name = @"Play";
    return Game;
    
}

-(void) MoveAsteroid {
   
    int xrand = arc4random_uniform(4);
    int yrand = arc4random_uniform(4);

     xtime =(1+ time2*(.0005));
    
    
    self.brownAsteroid1.position = CGPointMake(self.brownAsteroid1.position.x, self.brownAsteroid1.position.y-((10 +xrand)*xtime));
    self.brownAsteroid2.position = CGPointMake(self.brownAsteroid2.position.x, self.brownAsteroid2.position.y-((10+yrand)*xtime));
    self.brownAsteroid3.position = CGPointMake(self.brownAsteroid3.position.x, self.brownAsteroid3.position.y-(10*xtime));
    
    self.asteroid1.position = CGPointMake(self.asteroid1.position.x, self.asteroid1.position.y -(10*xtime));
   
    self.asteroid2.position = CGPointMake(self.asteroid2.position.x, self.asteroid2.position.y - (10*xtime));
    
    smallAsteroid1.position = CGPointMake(smallAsteroid1.position.x, smallAsteroid1.position.y -(15*xtime));
    smallAsteroid2.position = CGPointMake(smallAsteroid2.position.x, smallAsteroid2.position.y - (15*xtime));
    
    smallAsteroid3.position = CGPointMake(smallAsteroid3.position.x-1, smallAsteroid3.position.y - (16*xtime));
    
    smallAsteroid4.position = CGPointMake(smallAsteroid4.position.x+1.5, smallAsteroid4.position.y - (14*xtime));

if(self.brownAsteroid1.position.y <-300 || self.brownAsteroid2.position.y < -300 || self.brownAsteroid3.position.y <-300)
    
{
    

    [self createAsteroid];
    
}
    
if(self.asteroid1.position.y < -300 || self.asteroid2.position.y < - 300)
{
    [self createAsteroidType2];
}
    
    if(smallAsteroid1.position.y <-100 || smallAsteroid2.position.y <-100)
    {
        [self createsmallAsteroid];
    }

}




-(void) createAsteroid {
    float x = arc4random_uniform(self.view.frame.size.width - self.view.frame.size.width/3) + self.view.frame.size.width/3;
    float y = arc4random_uniform(self.view.frame.size.width - self.view.frame.size.width/2) + self.view.frame.size.width /2 ;
    float z = arc4random_uniform(self.view.frame.size.width - self.view.frame.size.width/10) + self.view.frame.size.width/10;
    
    
    self.brownAsteroid1.hidden = NO;
    self.brownAsteroid2.hidden = NO;
    self.brownAsteroid3.hidden = NO;
    
    self.brownAsteroid1.position = CGPointMake(x, self.view.frame.size.height);
    self.brownAsteroid2.position = CGPointMake(y, self.view.frame.size.height);
    self.brownAsteroid3.position = CGPointMake(z, self.view.frame.size.height);


    
    
    
}
-(void)createAsteroidType2 {
    float Yvar2 = arc4random_uniform(self.view.frame.size.width - self.view.frame.size.width/2) + self.view.frame.size.width/2 ;
    float Zvar2 = arc4random_uniform(self.view.frame.size.width);
    
    self.asteroid1.position = CGPointMake(Yvar2, self.view.frame.size.height);
    self.asteroid2.position = CGPointMake(Zvar2, self.view.frame.size.height);
    

    self.asteroid1.hidden = NO;
    self.asteroid2.hidden = NO;
    
    
}


-(void)createsmallAsteroid {
    
    float Yvar2 = arc4random_uniform(self.view.frame.size.width - self.view.frame.size.width/2) + self.view.frame.size.width/2 ;
    float Zvar2 = arc4random_uniform(self.view.frame.size.width);
    float xvar2 = arc4random_uniform(self.view.frame.size.width);
    float var2 = arc4random_uniform(self.view.frame.size.width);

    
    smallAsteroid1.position = CGPointMake(Yvar2, self.view.frame.size.height);
    smallAsteroid2.position = CGPointMake(Zvar2, self.view.frame.size.height);
    smallAsteroid3.position = CGPointMake(xvar2, self.view.frame.size.height);
    smallAsteroid4.position = CGPointMake(var2, self.view.frame.size.height);

    
    smallAsteroid1.hidden = NO;
    smallAsteroid2.hidden = NO;
    smallAsteroid3.hidden = NO;
    smallAsteroid4.hidden = NO;

    
}


-(void)didBeginContact:(SKPhysicsContact*)contact {
    
    SKPhysicsBody* firstBody;
    SKPhysicsBody* secondBody;
  
    if (contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    if ( firstBody.categoryBitMask == plasmaCategory & plasmaWeapon.hidden == NO & contact.bodyB.node.hidden == NO)
    {
       
        AudioServicesPlaySystemSound(ExplosionID);
//        NSLog(@"%@", contact.bodyB.node.name);
        [self fireEmitter2];
        fire2.position = CGPointMake(contact.bodyB.node.position.x, contact.bodyB.node.position.y);
        timer5 = [NSTimer scheduledTimerWithTimeInterval:.2 target:self selector:@selector(fireEmitterRemove) userInfo:nil repeats:NO];
        [self.explosionArray addObject:fire2];
    
     
            plasmaWeapon.hidden = YES;
            [plasmaWeapon removeFromParent];
            [self childNodeWithName:contact.bodyB.node.name].hidden = YES;
    
        
    
        
    }
    
    if(firstBody.categoryBitMask == spaceShipCategory)
    {
        
        if([self childNodeWithName:contact.bodyB.node.name].hidden == NO)
        {

            
             AudioServicesPlaySystemSound(ExplosionID);
            [ self childNodeWithName:contact.bodyB.node.name].hidden = YES;
            self.fire.hidden = YES;
            fire2.hidden = YES;
            self.spaceShip2.hidden = YES;
            [self.spaceShip2 removeFromParent];


            [self fireEmitter2];
            fire2.position = CGPointMake(self.spaceShip2.position.x, self.spaceShip2.position.y);
            fire2.yScale = 2;
            fire2.xScale = 2;
            timer6 = [NSTimer scheduledTimerWithTimeInterval:.3 target:self selector:@selector(GameOver) userInfo:nil repeats:NO];
            [self.explosionArray addObject:fire2];
            
            for( plasmaWeapon in self.shiplaser)
            {
            [plasmaWeapon removeFromParent];
            }
            [self.fire removeFromParent];
        }
    
    }

    
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{


 
    UITouch * pauseTouch = [touches anyObject];
    CGPoint touchlocation = [pauseTouch locationInNode:self];
    SKNode * node = [self nodeAtPoint:touchlocation];
    
    if(![node.name isEqualToString:@"Pause"])
    {
        [self.view addGestureRecognizer:object];
    }
    
    if([node.name isEqualToString:@"Pause"] && self.paused == NO  )
    {
        self.paused = YES;
        [timer3 invalidate];
        [timer4 invalidate];
        [timer7 invalidate];
    }
    else if([node.name isEqualToString:@"Pause"] && self.paused == YES)
    {
       self.paused = NO;
        timer3 = [ NSTimer scheduledTimerWithTimeInterval:.05 target:self selector:@selector(plasmaBombMove) userInfo:nil repeats:YES];
        timer4 =[NSTimer scheduledTimerWithTimeInterval:.05 target:self selector:@selector(MoveAsteroid) userInfo:nil repeats:YES];
         timer7 = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(tick) userInfo:nil repeats:YES];
        [self.view removeGestureRecognizer:object];
    }
    else if ([node.name isEqualToString:@"Play"])
    {
        for(SKNode * node in [self children])
        {
            [node removeFromParent];
            [self.view removeGestureRecognizer:object];
            [self.scoreNum removeFromParent];
            [[self buttonPress] removeFromParent];
            [timer5 invalidate];
            [timer6 invalidate];
            [timer7 invalidate];
            time1 = 0;
        }
        TitleScene * scene = [TitleScene sceneWithSize:self.view.bounds.size];
//        NSLog(@"%f", time2);
//        NSLog(@"%f", scene.HighScoreInt);
       if(time2 > HighScoreTime)
       {
           [[NSUserDefaults standardUserDefaults]setFloat:time2 forKey:@"RayScoreKey"];
        scene.HighScoreInt = time2;
        
       }
       else {
           scene.HighScoreInt = HighScoreTime;
       }
        [self.view presentScene:scene];
    }
    
    
}






-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    UITouch * touch = [touches anyObject];
    CGPoint touchlocation = [ touch locationInNode:self];
    SKPhysicsBody * body = [ self.physicsWorld bodyAtPoint:touchlocation];
    if([body.node.name isEqualToString:@"Space"] && self.paused == NO)
    {
        self.isFingerOnSpaceShip = YES;
        
    }
    
   if (self.isFingerOnSpaceShip) {

            self.spaceShipTouch = [[ event touchesForView:self.view]anyObject];
            self.spaceShip2.position = [self.spaceShipTouch locationInNode:self];
            self.fire.position = CGPointMake(self.spaceShip2.position.x, self.spaceShip2.position.y-30);
            
            

    }
  

    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    self.isFingerOnSpaceShip = NO;
}


-(void)fireEmitter {
    self.fire = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle]pathForResource:@"MyParticle" ofType:@"sks"]];
    self.fire.position = CGPointMake(self.spaceShip2.position.x, self.spaceShip2.position.y
                                -30);
    self.fire.targetNode = self.scene;
    self.fire.xScale = 1.0;
    [self addChild:self.fire];
    
    

}

-(void)fireEmitter2 {
    fire2 = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle]pathForResource:@"asteroidExplosion" ofType:@"sks"]];
    fire2.targetNode = self.scene;
    [self addChild:fire2];
    
}
-(void)fireEmitterRemove {
 
    for(fire2 in self.explosionArray)
    {

    fire2.hidden = YES;
    [fire2 removeFromParent];
    }
    
}

-(void)GameOver {
    
    for(fire2 in self.explosionArray)
    {
        
        fire2.hidden = YES;
        [fire2 removeFromParent];
    }
   
    self.timeobj = time2; 
    [timer2 invalidate];
    [timer3 invalidate];
    [timer4 invalidate];
    [timer7 invalidate];
   
    self.spaceShip2.hidden = YES;
    self.brownAsteroid1.hidden = YES;
    self.brownAsteroid2.hidden = YES;
    self.brownAsteroid3.hidden = YES;
    self.fire.hidden = YES;
    [self.view removeGestureRecognizer:object];
    
    xtime = 1;
    bgImage2.paused = YES;
    self.asteroid1.hidden = YES;
    self.asteroid2.hidden = YES;
    [self.asteroid1 removeFromParent];
    [self.asteroid2 removeFromParent];
    [smallAsteroid1 removeFromParent];
    [smallAsteroid2 removeFromParent];
    [smallAsteroid3 removeFromParent];
    [smallAsteroid4 removeFromParent];
    p.hidden = YES;
    [p removeFromParent];
    [self addChild:[self PlayAgain]];
    
}
-(void)plasmaBombMove {
    
 for( SKSpriteNode * laser in self.shiplaser)
 {
     laser.position = CGPointMake(laser.position.x, laser.position.y + 25);
 }
    if(plasmaWeapon.position.y > self.scene.size.height)
    {
        [plasmaWeapon removeFromParent];
    }

    
    
    
    
}

-(void)plasmaBomb {
    

    if(self.paused == NO)
    {
    
   plasmaWeapon = [SKSpriteNode spriteNodeWithImageNamed:@"plasmaBomb"];

    plasmaWeapon.position = CGPointMake(self.spaceShip2.position.x, self.spaceShip2.position.y +50);
    
    plasmaWeapon.xScale = .1;
    plasmaWeapon.yScale = .1;
  
    
    plasmaWeapon.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:plasmaWeapon.frame.size];
    plasmaWeapon.physicsBody.dynamic = NO;
    plasmaWeapon.physicsBody.categoryBitMask = plasmaCategory;
    
    
    if(plasmaWeapon.position.y > self.scene.size.height)
    {
        [plasmaWeapon removeFromParent];
    }
    
     [self.shiplaser addObject:plasmaWeapon];

   [self addChild:plasmaWeapon];

    }
  
}

-(void)tick {
    time1++;
     time2 = (time1)*10;
    self.scoreNum.text = [NSString stringWithFormat:@"%.01f", time2];
    
}


-(SKSpriteNode*)createBrownAsteroid:(NSInteger)xPosition position:(NSInteger)yPosition
                               name:(NSString*)name{
    
    
     SKSpriteNode * brownAsteroid = [SKSpriteNode spriteNodeWithImageNamed:@"brownAsteroid.png"];
     brownAsteroid.xScale = .1;
    
    
    brownAsteroid.yScale = .1;
    brownAsteroid.name = name;
    brownAsteroid.position = CGPointMake(xPosition, yPosition);
    brownAsteroid.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:brownAsteroid.frame.size.width/2];
    brownAsteroid.physicsBody.affectedByGravity = NO;
    brownAsteroid.physicsBody.friction = .6f;
    brownAsteroid.physicsBody.restitution = 1.0f;
    brownAsteroid.physicsBody.linearDamping = 0.0f;
    brownAsteroid.physicsBody.allowsRotation = YES;
    brownAsteroid.alpha =1;
    
    
    return brownAsteroid;
}




-(SKSpriteNode*)createAsteroids:(NSInteger)xPosition position:(NSInteger)yPosition name:(NSString*)name
{
    
    SKSpriteNode * asteroid = [SKSpriteNode spriteNodeWithImageNamed:@"asteroid.png"];
    
    asteroid.name = name;
    asteroid.position = CGPointMake(xPosition, yPosition);
    asteroid.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:asteroid.frame.size.width/2];
    asteroid.physicsBody.affectedByGravity = NO;
    asteroid.physicsBody.friction = 0.0f;
    asteroid.physicsBody.restitution = 1.0f;
    asteroid.physicsBody.linearDamping = 0.0f;
    asteroid.alpha = 8;
    asteroid.physicsBody.allowsRotation = YES;
    
    return asteroid;
}



-(SKSpriteNode*)createSmallAsteroid:(NSInteger)xPosition position:(NSInteger)yPosition
                               name:(NSString*)name{
    
    
    SKSpriteNode * smallAsteroid = [SKSpriteNode spriteNodeWithImageNamed:@"smallAsteroid.png"];
    smallAsteroid.xScale = .08;
    smallAsteroid.yScale = .08;
    smallAsteroid.name = name;
    smallAsteroid.position = CGPointMake(xPosition, yPosition);
    smallAsteroid.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:smallAsteroid.frame.size.width/2];
    smallAsteroid.physicsBody.affectedByGravity = NO;
    smallAsteroid.physicsBody.friction = .6f;
    smallAsteroid.physicsBody.restitution = 1.0f;
    smallAsteroid.physicsBody.linearDamping = 0.0f;
    smallAsteroid.physicsBody.allowsRotation = YES;
    smallAsteroid.alpha =1;
    
    
    return smallAsteroid;
}



-(void)update:(CFTimeInterval)currentTime {


}



@end
