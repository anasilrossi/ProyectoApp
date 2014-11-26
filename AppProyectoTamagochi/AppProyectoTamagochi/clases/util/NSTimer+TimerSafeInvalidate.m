//
//  NSTimer+TimerSafeInvalidate.m
//  AppProyectoTamagochi
//
//  Created by Analia on 25/11/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import "NSTimer+TimerSafeInvalidate.h"

@implementation NSTimer(TimerSafeInvalidate)


-(void)invalidartimer
{
    if(self && [self isValid]) { [self invalidate];}
    
}

@end
