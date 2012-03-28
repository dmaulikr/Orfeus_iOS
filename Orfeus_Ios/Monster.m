//
//  Monster.m
//  Orfeus_Ios
//
//  Created by Mobile Lab on 8/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Monster.h"


@implementation Monster

@synthesize character;
@synthesize damage;
@synthesize kill_bullets;
@synthesize sound;
@synthesize bonus;


-(void) dealloc
{
    [character release];
    [bonus release];
//    [  framecache  release];
//    [frame1    release];
//    [ frame2   release];
//    [ frame3   release];
//    [ frame4   release];
//    [ array_frame   release];
//    [ anim   release];
//    [ animate   release];
//    [ repeat   release];
    [  sound  release];
    
//    self.character = nil;
    [super dealloc];
}

@end
