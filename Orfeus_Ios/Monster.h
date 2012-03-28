//
//  Monster.h
//  Orfeus_Ios
//
//  Created by Mobile Lab on 8/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface Monster : NSObject {
    CCSprite  * character;
    CCSprite * bonus;
//    CCSpriteFrameCache *framecache;
//    CCSpriteFrame *frame1;
//    CCSpriteFrame *frame2;
//    CCSpriteFrame *frame3;
//    CCSpriteFrame *frame4;
//    NSMutableArray *array_frame;    
//    CCAnimation * anim;
//    CCRepeatForever * repeat;
//    CCAnimate * animate;
    int damage;
    int kill_bullets;
    NSString *sound;
    
    
}

@property (retain) CCSprite *character;
//@property (retain)CCSpriteFrame *frame1;
//@property (retain)CCSpriteFrame *frame2;
//@property (retain)CCSpriteFrame *frame3;
//@property (retain)CCSpriteFrame *frame4;
//@property (retain) NSMutableArray *array_frame;
//@property (retain)  CCAnimation * anim;
//@property (retain)    CCRepeatForever * repeat;
//
//@property (retain)    CCAnimate * animate;

@property    int damage;
@property (retain)   CCSprite * bonus;
//@property (retain)     CCSpriteFrameCache *framecache;

//
@property      int kill_bullets;

@property (retain)    NSString *sound;


@end
