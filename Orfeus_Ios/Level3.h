//
//  Level3.h
//  Orfeus_Ios
//
//  Created by Mobile Lab on 8/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface Level3 : CCLayer {
 
    CGPoint playerVelocity;
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
