//
//  NewGame.h
//  Orfeus_Ios
//
//  Created by Mobile Lab on 8/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface NewGame : CCLayer {
    
    CGPoint playerVelocity;
    CCSprite *bgsprite;
    CCSprite *orfeus;
    bool gameover;
    CCSprite * bullet;
    CCArray * a_bullets;
    CGSize size;
    CCArray *a_monsters;
    CCArray * a_bonus;
    NSString * intro_sound;
}


@end
