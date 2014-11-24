//
//  Animales.m
//  TuMascotaVirtual
//
//  Created by Analia on 22/11/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import "Animales.h"

@interface Animales ()

@property (nonatomic,assign) int  energia;
@property (nonatomic,assign) int  nivel;



@end
@implementation Animales

#pragma mark - Constructors

-(instancetype) initEnergia: (int) cambiarEnergia niveles:(int) cambiarNivel
{
    self.energia=100;

    self = [super init];
    if (self!=nil) {
        self.energia = cambiarEnergia;
        self.nivel = cambiarNivel;
    }
    return self;
}

+ (instancetype) sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    //Garantiza que lo que se encuentre dentro solo se ejecutará una vez.
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] initEnergia:100 niveles:1];
    });
    return _sharedObject;
}

-(int)menosEnergia
{
    self.energia = self.energia - 10;
    NSLog(@"%d",self.energia);
    return self.energia;
}
-(int)masEnergia
{
    self.energia = self.energia + 10;
    NSLog(@"%d",self.energia);
    return self.energia;
}

-(BOOL)puedeejercitar
{
    BOOL consulta ;
    if (self.energia != 0 )
    {
        return  consulta = YES;
    }
    else
    {
        return consulta = NO;
    }
}

-(int)devolverEnergia
    {
    
    return self.energia;
    }


@end
