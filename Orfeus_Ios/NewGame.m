//
//  NewGame.m
//  Orfeus_Ios
//
//  Created by Mobile Lab on 8/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NewGame.h"
#import "cocos2d.h"
#import "HelloWorldLayer.h"
#import "AppDelegate.h"
#import "GameConfig.h"
#import "RootViewController.h"
#import "Monster.h"
#include "Level2.h"

@implementation NewGame
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	NewGame *layer = [NewGame node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}
-(void) accelerometer:(UIAccelerometer *)accelerometer
        didAccelerate:(UIAcceleration *)acceleration
{
    // NSLog(@"Acceleration is x:%f y:%f z:%f", acceleration.x,acceleration.y, acceleration.z);
    // controls how quickly velocity decelerates (lower = quicker to    change direction)
    float deceleration = 0.4f;
    // determines how sensitive the accelerometer reacts (higher =    more sensitive)
    float sensitivity = 6.0f;
    // how fast the velocity can be at most
    float maxVelocity = 80;
    // adjust velocity based on current accelerometer acceleration
    playerVelocity.y = playerVelocity.y * deceleration + acceleration.y * sensitivity;
    // we must limit the maximum velocity of the player sprite, in both directions
    if (playerVelocity.y > maxVelocity)
    {
        playerVelocity.y = maxVelocity;
    } else
        if (playerVelocity.y < - maxVelocity)
        {
            playerVelocity.y = - maxVelocity;
        }
    
}
-(id) init
{
    self = [super init];
    if (self != nil)
    {
    CCDirector *director = [CCDirector sharedDirector];
	[director setDeviceOrientation:kCCDeviceOrientationLandscapeLeft];
        gameover =NO;
      size = [[CCDirector sharedDirector] winSize];
    bgsprite = [ CCSprite spriteWithFile: @"fundal4_1.jpg" ];
        //[label ]
        bgsprite.position = ccp (bgsprite.contentSize.width/2,bgsprite.contentSize.height/2);
        [self addChild: bgsprite];
        self.isAccelerometerEnabled = YES;
        self.isTouchEnabled =YES;
        
        CCSpriteFrameCache *framecache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [framecache addSpriteFramesWithFile:@"orfeu.plist"];


        orfeus  =[CCSprite spriteWithSpriteFrameName: @"orfeu1.png"];
        CCSpriteFrame *frame1 = [framecache spriteFrameByName:@"orfeu1.png"];
        CCSpriteFrame *frame2 = [framecache spriteFrameByName:@"orfeu2.png"];
        CCSpriteFrame *frame3 = [framecache spriteFrameByName:@"orfeu3.png"];
        CCSpriteFrame *frame4 = [framecache spriteFrameByName:@"orfeu4.png"];
        CCSpriteFrame *frame5;
        CCSpriteFrame *frame6;
        NSMutableArray *frames = [NSMutableArray array];
        [frames addObject:frame1];
        [frames addObject:frame2];
        [frames addObject:frame3];
        [frames addObject:frame4];
        
        CCAnimation * anim= [CCAnimation animationWithName:@"move" delay: 0.1f frames:frames];
        CCAnimate * animate=[CCAnimate  actionWithAnimation: anim];
        //CCRepeatForever * repeat =[ CCRepeatForever actionWithAction:animate];
        
        orfeus.position = ccp (40,size.height-75);
        [orfeus runAction: animate];
        [self addChild: orfeus];
        
        CCSprite *fire1  =[CCSprite spriteWithFile: @"buttomframe.png"];
        CCSpriteFrameCache *framecache1 = [CCSpriteFrameCache sharedSpriteFrameCache];
        [framecache1 addSpriteFramesWithFile:@"buttomframe.plist"];
        CCSpriteFrame *frame11 = [framecache1 spriteFrameByName:@"buttom_2.png"];
        CCSpriteFrame *frame12 = [framecache1 spriteFrameByName:@"buttom_3.png"];
        CCSpriteFrame *frame13 = [framecache1 spriteFrameByName:@"buttom_4.png"];
        CCSpriteFrame *frame14 = [framecache1 spriteFrameByName:@"buttom_5.png"];
        
        //NSMutableArray *frames1=[[[NSMutableArray alloc]init] autorelease];
        NSMutableArray *frames1 = [NSMutableArray array];
        [frames1 addObject:frame11];
        [frames1 addObject:frame12];
        [frames1 addObject:frame13];
        [frames1 addObject:frame14];
        
        CCAnimation * anim1= [CCAnimation animationWithName:@"move" delay: 0.1f frames:frames1];
        CCAnimate * animate1=[CCAnimate  actionWithAnimation: anim1];
        CCRepeatForever * repeat1 =[ CCRepeatForever actionWithAction:animate1];
        
        fire1.position = ccp (fire1.contentSize.width/2-10,size.height-10);
        [fire1 runAction: repeat1];
        
        //[frame1 release];
        [self addChild: fire1];
        
        CCSprite *fire2  =[CCSprite spriteWithFile: @"buttomframe.png"];
        CCSpriteFrameCache *framecache2 = [CCSpriteFrameCache sharedSpriteFrameCache];
        [framecache2 addSpriteFramesWithFile:@"buttomframe.plist"];
        CCSpriteFrame *frame21 = [framecache2 spriteFrameByName:@"buttom_2.png"];
        CCSpriteFrame *frame22 = [framecache2 spriteFrameByName:@"buttom_3.png"];
        CCSpriteFrame *frame23 = [framecache2 spriteFrameByName:@"buttom_4.png"];
        CCSpriteFrame *frame24 = [framecache2 spriteFrameByName:@"buttom_5.png"];
        
        NSMutableArray *frames2 = [NSMutableArray array];
        [frames2 addObject:frame21];
        [frames2 addObject:frame22];
        [frames2 addObject:frame23];
        [frames2 addObject:frame24];
        
        CCAnimation * anim2= [CCAnimation animationWithName:@"move" delay: 0.1f frames:frames2];
        CCAnimate * animate2=[CCAnimate  actionWithAnimation: anim2];
        CCRepeatForever * repeat2 =[ CCRepeatForever actionWithAction:animate2];
        
        fire2.position = ccp (fire2.contentSize.width/2-10,16);
        [fire2 runAction: repeat2];
        [self addChild: fire2];

        a_monsters = [[CCArray alloc] init];
        a_bullets = [[CCArray alloc] init];
        a_bonus = [[CCArray alloc] init];

        int i;
        Monster *monster;
        
            monster =[[Monster alloc]init];
            monster.character=[CCSprite spriteWithFile:@"skeleton_1.png"];   
        monster.bonus = [CCSprite spriteWithFile:@"green_cross.png"];   
    
        framecache =[ CCSpriteFrameCache sharedSpriteFrameCache];
            [ framecache addSpriteFramesWithFile:@"skeleton_1.plist"];
            
            
            // orfeus  =[CCSprite spriteWithSpriteFrameName: @"orfeu1.png"];
            frame1 = [framecache spriteFrameByName:@"Skeleton001.png"];
            frame2 = [framecache spriteFrameByName:@"Skeleton002.png"];
            frame3= [framecache  spriteFrameByName:@"Skeleton003.png"];
            frame4 = [framecache spriteFrameByName:@"Skeleton004.png"];
            
          frames =[NSMutableArray array];
            
            [frames addObject:frame1];
            [frames addObject:frame2];
            [frames addObject:frame3];
            [frames addObject:frame4];
            
            anim= [CCAnimation animationWithName:@"move" delay: 0.6f frames:frames];
            animate=[CCAnimate  actionWithAnimation: anim];
            repeat1 =[ CCRepeatForever actionWithAction: animate];
            monster.character.position = ccp (size.width,size.height*CCRANDOM_0_1()-30);
            [monster.character runAction: repeat1];
            [self addChild: monster.character];           
            [ a_monsters addObject: monster]; 
        
        
        
        monster =[[Monster alloc]init];
        monster.character=[CCSprite spriteWithFile:@"SoldierSkeleton_1.png"];   
        framecache =[ CCSpriteFrameCache sharedSpriteFrameCache];
        [ framecache addSpriteFramesWithFile:@"SoldierSkeleton_1.plist"];
        
        
        // orfeus  =[CCSprite spriteWithSpriteFrameName: @"orfeu1.png"];
        frame1 = [framecache spriteFrameByName:@"SoldierSkeleton.000.png"];
        frame2 = [framecache spriteFrameByName:@"SoldierSkeleton002.png"];
        frame3= [framecache  spriteFrameByName:@"SoldierSkeleton004.png"];
        frame4 = [framecache spriteFrameByName:@"SoldierSkeleton005.png"];
        
        frames =[NSMutableArray array];
        
        [frames addObject:frame1];
        [frames addObject:frame2];
        [frames addObject:frame3];
        [frames addObject:frame4];
        
        anim= [CCAnimation animationWithName:@"move" delay: 0.6f frames:frames];
        animate=[CCAnimate  actionWithAnimation: anim];
        repeat1 =[ CCRepeatForever actionWithAction: animate];
        monster.character.position = ccp (size.width+40,size.height*CCRANDOM_0_1()-30);
        [monster.character runAction: repeat1];
        monster.bonus = [CCSprite spriteWithFile:@"green_cross.png"];   
        [self addChild: monster.character];    
        
        [ a_monsters addObject: monster]; 
        
        monster =[[Monster alloc]init];
        monster.character=[CCSprite spriteWithFile:@"ArcherSkeleton_1.png"];   
        framecache =[ CCSpriteFrameCache sharedSpriteFrameCache];
        [ framecache addSpriteFramesWithFile:@"ArcherSkeleton_1.plist"];
        
        
        // orfeus  =[CCSprite spriteWithSpriteFrameName: @"orfeu1.png"];
        frame1 = [framecache spriteFrameByName:@"ArcherSkeleton000.png"];
        frame2 = [framecache spriteFrameByName:@"ArcherSkeleton001.png"];
        frame3= [framecache  spriteFrameByName:@"ArcherSkeleton002.png"];
        frame4 = [framecache spriteFrameByName:@"ArcherSkeleton003.png"];
        frame5 = [framecache spriteFrameByName:@"ArcherSkeleton004.png"];
        frame6 = [framecache spriteFrameByName:@"ArcherSkeleton005.png"];

        frames =[NSMutableArray array];
        
        [frames addObject:frame1];
        [frames addObject:frame2];
        [frames addObject:frame3];
        [frames addObject:frame4];
        [frames addObject:frame5];
        [frames addObject:frame6];


        
        anim= [CCAnimation animationWithName:@"move" delay: 0.6f frames:frames];
        animate=[CCAnimate  actionWithAnimation: anim];
        repeat1 =[ CCRepeatForever actionWithAction: animate];
        monster.character.position = ccp (size.width+80,size.height*CCRANDOM_0_1()-30);
        [monster.character runAction: repeat1];
        monster.bonus = [CCSprite spriteWithFile:@"green_cross.png"];   
        [self addChild: monster.character];
        
        
        [ a_monsters addObject: monster]; 
        monster =[[Monster alloc]init];
        monster.character=[CCSprite spriteWithFile:@"FlameSkull_1.png"];   
        framecache =[ CCSpriteFrameCache sharedSpriteFrameCache];
        [ framecache addSpriteFramesWithFile:@"FlameSkull_1.plist"];
        
        
        // orfeus  =[CCSprite spriteWithSpriteFrameName: @"orfeu1.png"];
        frame1 = [framecache spriteFrameByName:@"Flameskull000.png"];
        frame2 = [framecache spriteFrameByName:@"Flameskull001.png"];
        frame3= [framecache  spriteFrameByName:@"Flameskull002.png"];
        frame4 = [framecache spriteFrameByName:@"Flameskull003.png"];
        frame5 = [framecache spriteFrameByName:@"Flameskull004.png"];
        frame6 = [framecache spriteFrameByName:@"Flameskull005.png"];
        
        frames =[NSMutableArray array];
        
        [frames addObject:frame1];
        [frames addObject:frame2];
        [frames addObject:frame3];
        [frames addObject:frame4];
        [frames addObject:frame5];
        [frames addObject:frame6]; 
        anim= [CCAnimation animationWithName:@"move" delay: 0.6f frames:frames];
        animate=[CCAnimate  actionWithAnimation: anim];
        repeat1 =[ CCRepeatForever actionWithAction: animate];
        monster.character.position = ccp (size.width+120,size.height*CCRANDOM_0_1()-30);
        [monster.character runAction: repeat1];
        monster.bonus = [CCSprite spriteWithFile:@"green_cross.png"];   
        [self addChild: monster.character];       
        
        [ a_monsters addObject: monster]; 
        
        monster =[[Monster alloc]init];
        monster.character=[CCSprite spriteWithFile:@"SkeletonTier2_1.png"];   
        framecache =[ CCSpriteFrameCache sharedSpriteFrameCache];
        [ framecache addSpriteFramesWithFile:@"SkeletonTier2_1.plist"];
        
        
        // orfeus  =[CCSprite spriteWithSpriteFrameName: @"orfeu1.png"];
        frame1 = [framecache spriteFrameByName:@"SkeletonTier2000.png"];
        frame2 = [framecache spriteFrameByName:@"SkeletonTier2001.png"];
        frame3= [framecache  spriteFrameByName:@"SkeletonTier2002.png"];
        frame4 = [framecache spriteFrameByName:@"SkeletonTier2003.png"];
     
        
        frames =[NSMutableArray array];
        
        [frames addObject:frame1];
        [frames addObject:frame2];
        [frames addObject:frame3];
        [frames addObject:frame4];
        
        anim= [CCAnimation animationWithName:@"move" delay: 0.6f frames:frames];
        animate=[CCAnimate  actionWithAnimation: anim];
        repeat1 =[ CCRepeatForever actionWithAction: animate];
        monster.character.position = ccp (size.width+160,size.height*CCRANDOM_0_1()-30);
        [monster.character runAction: repeat1];
        monster.bonus = [CCSprite spriteWithFile:@"green_cross.png"];   
        [self addChild: monster.character];       
        
        [ a_monsters addObject: monster];
        monster =[[Monster alloc]init];
        monster.character=[CCSprite spriteWithFile:@"SkeletonTier3_1.png"];   
        framecache =[ CCSpriteFrameCache sharedSpriteFrameCache];
        [ framecache addSpriteFramesWithFile:@"SkeletonTier3_1.plist"];
        
        
        // orfeus  =[CCSprite spriteWithSpriteFrameName: @"orfeu1.png"];
        frame1 = [framecache spriteFrameByName:@"SkeletonTier3000.png"];
        frame2 = [framecache spriteFrameByName:@"SkeletonTier3001.png"];
        frame3= [framecache  spriteFrameByName:@"SkeletonTier3002.png"];
        frame4 = [framecache spriteFrameByName:@"SkeletonTier3003.png"];
        
        
        frames =[NSMutableArray array];
        
        [frames addObject:frame1];
        [frames addObject:frame2];
        [frames addObject:frame3];
        [frames addObject:frame4];
        
        anim= [CCAnimation animationWithName:@"move" delay: 0.6f frames:frames];
        animate=[CCAnimate  actionWithAnimation: anim];
        repeat1 =[ CCRepeatForever actionWithAction: animate];
        monster.character.position = ccp (size.width+200,size.height*CCRANDOM_0_1()-30);
        [monster.character runAction: repeat1];
        monster.bonus = [CCSprite spriteWithFile:@"green_cross.png"];   
        [self addChild: monster.character];       
        
        [ a_monsters addObject: monster];


        
        
        

        
    }

    [self scheduleUpdate];

    return self;
}
-(CGPoint) locationFromTouches:(NSSet *)touches {
    UITouch *touch = [touches anyObject]; CGPoint touchLocation = [touch locationInView: [touch view]]; return [[CCDirector sharedDirector] convertToGL:touchLocation];
}
-(void)  ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (gameover == NO)
    {
        CCFadeOut *fadeout;
        CGPoint point =[self locationFromTouches:touches];
        // NSLog(@"another touch x=%f y=%f",point.x, point.y);
        id obj;
        CCSprite * b;
        CCSequence *boom;
        for ( obj in a_bonus)
        {
            //NSLog(@"touch");
            b =(CCSprite *) obj;
            if(point.y>=b.position.y-b.contentSize.height/2-6  && point.y<=b.position.y+b.contentSize.height/2+6 && point.x>=b.position.x-b.contentSize.width/2 -6  && point.x<=b.position.x+b.contentSize.width/2+6)
            {
                NSLog(@"touch");
                fadeout= [CCFadeOut actionWithDuration:1];
              boom = [CCSequence actions: fadeout,nil];
                [ b runAction:boom];
                [a_bonus removeObject: b];  


            }
        
        }
        if(point.y>=50)
        {  
            CCSpriteFrameCache *framecache = [CCSpriteFrameCache sharedSpriteFrameCache];
            [framecache addSpriteFramesWithFile:@"orfeu.plist"];
            
            
            //orfeus  =[CCSprite spriteWithSpriteFrameName: @"orfeu1.png"];
            CCSpriteFrame *frame1 = [framecache spriteFrameByName:@"orfeu1.png"];
            CCSpriteFrame *frame2 = [framecache spriteFrameByName:@"orfeu2.png"];
            CCSpriteFrame *frame3 = [framecache spriteFrameByName:@"orfeu3.png"];
            CCSpriteFrame *frame4 = [framecache spriteFrameByName:@"orfeu4.png"];
            
            NSMutableArray *frames = [NSMutableArray array];
            [frames addObject:frame1];
            [frames addObject:frame2];
            [frames addObject:frame3];
            [frames addObject:frame4];
            
            CCAnimation * anim= [CCAnimation animationWithName:@"move" delay: 0.1f frames:frames];
            CCAnimate * animate=[CCAnimate  actionWithAnimation: anim];
            //CCRepeatForever * repeat =[ CCRepeatForever actionWithAction:animate];
            
          //  orfeus.position = ccp (40,size.height-75);
            [orfeus runAction: animate];
            bullet = [ CCSprite spriteWithFile: @"note2.png" ];
            bullet.position = ccp (orfeus.position.x+10,orfeus.position.y);
            [ a_bullets addObject: bullet ];
            [self addChild: bullet];
            
            CCMoveTo *myaction = [CCMoveTo actionWithDuration: 1 position: ccp(size.width+30, orfeus.position.y)];
            [bullet runAction:myaction];
            
                       
        }
        
    }
}
- (void)restartgame
{
    [[CCDirector sharedDirector] replaceScene: [NewGame scene]];
    
    
}
- (void) quit 
{
    [[CCDirector sharedDirector] replaceScene: [HelloWorldLayer scene]];
    
    
}
- (void) myfunc : (id) monster 
{
//    [self removeChild: monster cleanup: YES];
    
}
- (void) myfunc2 : (id) monster 
{
      [self removeChild: monster cleanup: YES];
    
}
- (void)pause{
    [self unscheduleUpdate];

    [self unscheduleAllSelectors];
    
    [[CCDirector sharedDirector] replaceScene: [Level2 scene]];
}
- (void) update:(ccTime)delta
{

// Keep adding up the playerVelocity to the player's position
CGPoint pos = orfeus.position;
pos.y += playerVelocity.y;
// The Player should also be stopped from going outside the screen
CGSize screenSize = [[CCDirector sharedDirector] winSize];
float imageWidthHalved = orfeus.contentSize.height/2;
float upBorderLimit = imageWidthHalved;
float downBorderLimit = screenSize.height - imageWidthHalved;
double velocity = 10;

// preventing the player sprite from moving outside the screen
if (pos.y < upBorderLimit)
{
    pos.y = upBorderLimit;
    playerVelocity = CGPointZero;
} else
if (pos.y > downBorderLimit)
{
    pos.y = downBorderLimit;
    playerVelocity = CGPointZero;
}

// assigning the modified position back
    orfeus.position = pos;
    CCSprite *bullet, * explosion;
    CCSprite * nextlevel;
    CCSpriteFrame *frame1, *frame2, * frame3, * frame4;
    CCSpriteFrameCache * framecache;
    NSMutableArray * frames;
    CCRepeat * repeat;
    CCAnimation * anim;
    CCAnimate * animate;
    if ([a_monsters count] == 0)     
    {
       //
        [[CCDirector sharedDirector] replaceScene: [Level2 scene]];

               
    }
    for (bullet in a_bullets)
    {           
        if(bullet.position.x>size.width)
        {

            [a_bullets removeObject:bullet];
            [self removeChild:bullet cleanup:YES];
        }
    }
    id obj, obj_bullet;
    CCSprite * monster_sprite;
    Monster * monster;
    for (obj in a_monsters)
    { 
        //obj = [a_asteroids objectAtIndex : i]; 
        monster = (Monster *)  obj;
        monster_sprite= monster.character;
        
    if((monster_sprite.position.x-velocity * delta)>0)
        monster_sprite.position = ccp (monster_sprite.position.x-velocity * delta, monster_sprite.position.y);
    else         
        monster_sprite.position = ccp (size.width-30,monster_sprite.position.y );
        CGRect obj1, obj2, obj3;
        obj1.origin.x=monster_sprite.position.x-monster_sprite.contentSize.width/2;
        obj1.origin.y=monster_sprite.position.y-monster_sprite.contentSize.height/2;
        obj1.size=monster_sprite.contentSize;
        obj3.origin.x=orfeus.position.x-orfeus.contentSize.width/2;
        obj3.origin.y=orfeus.position.y-orfeus.contentSize.height/2;
        obj3.size=orfeus.contentSize;
        if(CGRectIntersectsRect(obj1,obj3))
        {
            //CCSprite *gameoversprite = [ CCSprite spriteWithFile: @"gameover2.png" ];
            //[label ]
            //gameoversprite.position = ccp (gameoversprite.contentSize.width/2,gameoversprite.contentSize.height/2);
            //[self addChild: gameoversprite];
            gameover = YES;
            CCMenuItemImage * yes = [CCMenuItemImage itemFromNormalImage:@"YES.png" 
                                                           selectedImage:@"YES.png" 
                                                           disabledImage:@"YES.png" 
                                                                  target:self 
                                                                selector:@selector(restartgame)];
            CCMenuItemImage * no = [CCMenuItemImage itemFromNormalImage:@"NO.png" 
                                                          selectedImage:@"NO.png" 
                                                          disabledImage:@"NO.png" 
                                                                 target:self 
                                                               selector:@selector(quit)];           
            CCMenu *menu =[CCMenu menuWithItems:yes,no, nil];
            menu.position =  ccp( size.width/2 , size.height/3 );
            [menu alignItemsHorizontally];
            [self addChild:menu];
            
            break;
            
        }
        for( obj_bullet in a_bullets)
        {
            
            bullet= (CCSprite*) obj_bullet;
            obj2.origin.x=bullet.position.x-bullet.contentSize.width/2;
            obj2.origin.y=bullet.position.y-bullet.contentSize.height/2;
            obj2.size=bullet.contentSize;
            if(CGRectIntersectsRect(obj1,obj2))   
            {
                CCLOG(@"collision");
                
             //   [[SimpleAudioEngine sharedEngine] playEffect:@"Explosion.mp3"];            
            //    explosion = [ CCSprite spriteWithFile: @"explosion.png"];
            //    explosion.position = dracula.position;
            //    [self addChild: explosion];                
              
                CCFadeOut *fadeout= [CCFadeOut actionWithDuration:0.12];
                CCFadeIn *fadein= [CCFadeIn actionWithDuration:0.12];
                CCCallFuncN *call =[CCCallFuncN actionWithTarget:self selector :@selector( myfunc2: )];            
                CCSequence *boom = [CCSequence actions: fadeout, fadein, fadeout, fadein, fadeout,fadein, fadeout, call,nil];
                monster.bonus.position=ccp(monster.character.position.x, monster.character.position.y);
                [self addChild:monster.bonus];
                [a_bonus addObject:monster.bonus];
                [ monster_sprite runAction:boom];
                [a_monsters removeObject: monster];  
                

            }
            
            
            
            
        }
       
    }
}

-(void)dealloc
{
    [a_bullets release];
    [super dealloc];
}
    @end
