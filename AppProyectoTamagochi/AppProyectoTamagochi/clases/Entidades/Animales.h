//
//  Animales.h
//  TuMascotaVirtual
//
//  Created by Analia on 22/11/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "animalIdentificador.h"
#import <CoreLocation/CoreLocation.h>
#import "Mascotas.h"

@interface Animales : Mascotas
extern NSString * const code;

//Constructor
+ (instancetype) sharedInstance;

//metodos propios
-(int)menosEnergia;
-(int)masEnergia: (int)valor;
-(BOOL)puedeejercitar;
-(int)devolverEnergia;
-(int)aumentarExperiencia:(int)valor;
-(int)subirNivel : (int)experiencia;
-(int)devolverExperiencia;
-(int)devolverNivel;
-(void)decodificardic:(NSDictionary*)diccionario;
-(NSDictionary *)devolverMascota;
-(void)PushRemoto;
-(void)update;
+(void)saveDataToDisk;

@end
