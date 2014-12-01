//
//  Animales.m
//  TuMascotaVirtual
//
//  Created by Analia on 22/11/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import "Animales.h"
#import "TamagochiNetwork.h"
#import <Parse/Parse.h>
@interface Animales ()


@end

@implementation Animales

#pragma mark - Constructors

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

-(int)devolverNivel
{
    return self.nivel;
}

-(int)subirNivel : (int)experiencia
{
    int valor = self.nivel * self.nivel;
    int formula = 100 * valor;
    if (self.experiencia >= formula)
    {
        self.nivel +=1;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"REFRESCAR_NIVEL" object:nil];
         [self update];
        // Send a notification to all devices subscribed to the "Giants" channel.
        [self PushRemoto];
        self.experiencia=0;
    }
    return  self.nivel;
}
-(void)PushRemoto
{
    PFPush *push = [[PFPush alloc] init];
    [push setChannel:@"PeleaDeMascotas"];
    [push setMessage: [NSString stringWithFormat: @"La mascota subio de nivel Level:%d",self.nivel]];
    [push setData:[self devolverMascota]];
    [push sendPushInBackground];
}

-(void)update
{
    NSString const * code =@"AR7666";
    NSString * sEnergia = [NSString stringWithFormat:@"%d",self.energia ];
    NSString * sNivel = [NSString stringWithFormat:@"%d",self.nivel ];
    NSString * sExperiencia = [NSString stringWithFormat:@"%d",self.experiencia ];
    NSString * saltitud = [NSString stringWithFormat:@"%f",self.altitude];
    NSString * slongitud = [NSString stringWithFormat:@"%f",self.longitud];
    NSMutableDictionary * datos = [NSMutableDictionary dictionaryWithDictionary:@{ @"code":code,
                                                                                   @"name":self.animalNombre,
                                                                                   @"energia":sEnergia,
                                                                                   @"level":sNivel,
                                                                                   @"experience":sExperiencia,
                                                                                   @"position_lat":saltitud,
                                                                                   @"position_lon":slongitud}];
    TamagochiNetwork * manager = [TamagochiNetwork sharedInstance];
    [manager POST:@"/pet"
       parameters:datos
          success:^(NSURLSessionDataTask *task, id responseObject) {
              NSDictionary * responseDict = responseObject;
              NSString * valor = [responseDict valueForKey:@"status"];
              if ([valor isEqualToString: @"ok"]) {
                  NSLog(@"Perfecto! JSON: %@", responseObject);
                  UIAlertView * alerta =[[UIAlertView alloc]initWithTitle: @"alerta" message: @"Perfecto subido al servidor" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles: nil ];
                  [alerta show];

              }
              else
              {
                  UIAlertView * alerta =[[UIAlertView alloc]initWithTitle: @"alerta" message: @"Error " delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles: nil ];
                  [alerta show];
              }
              
    }     failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}
-(void)decodificardic:(NSDictionary*)diccionario
{
    self.energia = [[diccionario valueForKey:@"energy"] intValue];
  
    self.experiencia = [[diccionario valueForKey:@"experience"] intValue];
    
    self.nivel=[[diccionario valueForKey:@"level"] intValue];
    
    self.animalNombre =[diccionario valueForKey:@"name"];
 
}

-(NSDictionary *)devolverMascota
{
    NSString * sEnergia = [NSString stringWithFormat:@"%d",self.energia ];
    NSString * sNivel = [NSString stringWithFormat:@"%d",self.nivel ];
    NSString * sExperiencia = [NSString stringWithFormat:@"%d",self.experiencia ];
    NSString * sAnimal = [NSString stringWithFormat:@"%d",self.tipoAnimal];
    NSDictionary * mascota = @{@"name":self.animalNombre,
                                @"energia": sEnergia ,
                                @"level": sNivel,
                                @"experience":sExperiencia,
                                @"Animal":sAnimal,
                                @"Code":@"AR7666",} ;
    return mascota;
}

@end
