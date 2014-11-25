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
@property (nonatomic,assign) int  experiencia;



@end
@implementation Animales

#pragma mark - Constructors

-(instancetype) initEnergia: (int) cambiarEnergia niveles:(int) cambiarNivel experiencia:(int)cambiarExperiencia
{
    self.energia=100;

    self = [super init];
    if (self!=nil) {
        self.energia = cambiarEnergia;
        self.nivel = cambiarNivel;
        self.experiencia = cambiarExperiencia;
    }
    return self;
}

+ (instancetype) sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    //Garantiza que lo que se encuentre dentro solo se ejecutará una vez.
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] initEnergia:100 niveles:1 experiencia:0];
    });
    return _sharedObject;
}

-(int)menosEnergia
{
    self.energia = self.energia - 10;
    NSLog(@"%d",self.energia);
    return self.energia;
}

-(int)masEnergia: (int)valor
{
   self.energia  = MIN(100, self.energia + valor);
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

-(int)aumentarExperiencia:(int)valor
{
    if (self.energia!=0) {
        self.experiencia += valor;
        self.nivel =[self subirNivel:self.experiencia];
        NSLog([NSString stringWithFormat:@"experiencia:%d nivel:%d ",self.experiencia, self.nivel]);
    }
   return self.experiencia;
}

-(int)devolverExperiencia
{
    return self.experiencia;
}

-(int)subirNivel : (int)experiencia
{
    int valor = self.nivel * self.nivel;
    int formula = 100 * valor;
   
    if (self.experiencia >= formula)
    {
        self.nivel +=1;
        NSString * mensaje = [NSString stringWithFormat: @"Su mascota llego a nivel %d",self.nivel];
        UIAlertView * alerta =[[UIAlertView alloc] initWithTitle:@"Mascota Virtual" message:mensaje delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:@"Cancelar", nil];
        [alerta show];
        
    }
    return  self.nivel;
}

@end
