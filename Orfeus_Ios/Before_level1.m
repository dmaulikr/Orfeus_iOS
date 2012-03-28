//
//  Before_level1.m
//  Orfeus_Ios
//
//  Created by Mobile Lab on 8/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Before_level1.h"
#import "cocos2d.h"

@implementation Before_level1
-(id) init
{
CCSpriteFrameCache *framecache = [CCSpriteFrameCache sharedSpriteFrameCache];
[framecache addSpriteFramesWithFile:@"orfeu.plist"];

nextlevel  =[CCSprite spriteWithSpriteFrameName: @"orfeu1.png"];
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

//nextlevel.position = ccp (40,size.height-75);
[nextlevel runAction: animate];
[self addChild: nextlevel];
}
@end
