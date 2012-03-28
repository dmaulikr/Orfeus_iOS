//
//  HelloWorldLayer.m
//  Orfeus_Ios
//
//  Created by Mobile Lab on 8/3/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "NewGame.h"
#import "Level2.h"
#import "Level3.h"
#import "Level4.h"
#import "Level5.h"
#import "SimpleAudioEngine.h"
//[[SimpleAudioEngine haredengine] playBackgroundMusic : @ "" loop : YES]

// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (void) onNewGame: (id) sender
{
//    [[CCDirector sharedDirector] replaceScene: [HelloWorldLayer scene]];
    [[CCDirector sharedDirector] replaceScene: [NewGame scene]];

}
// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        CGSize size = [[CCDirector sharedDirector] winSize];
        self.isAccelerometerEnabled = YES;
        self.isTouchEnabled =YES;
        CCSprite *orfeusgrey  =[CCSprite spriteWithFile: @"orfeusgreyframe2.png"];
        CCSpriteFrameCache *framecache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [framecache addSpriteFramesWithFile:@"orfeusgreyframe2.plist"];
        CCSpriteFrame *frame1 = [framecache spriteFrameByName:@"orfeusgrey2.png"];
        CCSpriteFrame *frame2 = [framecache spriteFrameByName:@"orfeusgrey3.png"];
        CCSpriteFrame *frame3 = [framecache spriteFrameByName:@"orfeusgrey4.png"];
        CCSpriteFrame *frame4 = [framecache spriteFrameByName:@"orfeusgrey5.png"];

        NSMutableArray *frames=[[NSMutableArray alloc]init];
        [frames addObject:frame1];
        [frames addObject:frame2];
        [frames addObject:frame3];
        [frames addObject:frame4];
        
        CCAnimation * anim= [CCAnimation animationWithName:@"move" delay: 0.1f frames:frames];
        CCAnimate * animate=[CCAnimate  actionWithAnimation: anim];
       CCRepeatForever * repeat =[ CCRepeatForever actionWithAction:animate];
        
        orfeusgrey.position = ccp (size.width/2,size.height-80);
        [orfeusgrey runAction:repeat];
        [self addChild: orfeusgrey];
        CCMenuItemImage * startNew = [CCMenuItemImage itemFromNormalImage:@"newgame.png" 
                                                            selectedImage:@"newgame.png" 
                                                            disabledImage:@"newgame.png" 
                                                                   target:self 
                                                                 selector:@selector(onNewGame:)];
        CCMenuItemImage * highscores = [CCMenuItemImage itemFromNormalImage:@"highscores.png" 
                                                              selectedImage:@"highscores.png" 
                                                              disabledImage:@"highhcores.png" 
                                                                     target:self 
                                                                   selector:@selector(onNewGame:)];
        CCMenuItemImage * help = [CCMenuItemImage itemFromNormalImage:@"help.png" 
                                                           selectedImage:@"help.png" 
                                                           disabledImage:@"help.png" 
                                                                  target:self 
                                                                selector:@selector(onNewGame:)];
        CCMenuItemImage * settings = [CCMenuItemImage itemFromNormalImage:@"settings.png" 
                                                           selectedImage:@"settings.png" 
                                                           disabledImage:@"settings.png" 
                                                                  target:self 
                                                                selector:@selector(onNewGame:)];
        
        CCMenu *mainmenu =[CCMenu menuWithItems:startNew,highscores,help,settings, nil];
        
        mainmenu.position =  ccp( size.width/2 , size.height/3 *1.1);
        [mainmenu alignItemsVertically];
        [self addChild:mainmenu];
        
    }
	return self;
}
// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
