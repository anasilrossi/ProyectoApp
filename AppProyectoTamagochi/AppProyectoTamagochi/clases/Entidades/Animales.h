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

@interface Animales : NSObject <NSCoding>
extern NSString * const code;

@property (retain,nonatomic) NSString * animalNombre;
@property (nonatomic,retain) NSNumber * tipoAnimal;
@property (nonatomic,retain) NSNumber * estadoAnimal;
@property (nonatomic,retain) NSNumber *  nivel;
@property (nonatomic,retain) NSNumber *  experiencia;
@property(retain, nonatomic) NSNumber * altitude;
@property(retain, nonatomic) NSNumber * longitud;
@property (nonatomic,strong) NSString * codigoAnimal;
@property (nonatomic,retain) NSNumber *  energia;

//Constructor
+ (instancetype) sharedInstance;

//metodos propios
-(NSNumber *)menosEnergia;
-(NSNumber *)masEnergia: (int)valor;
-(BOOL)puedeejercitar;
-(NSNumber *)devolverEnergia;
-(NSNumber *)aumentarExperiencia:(int)valor;
-(NSNumber *)subirNivel : (NSNumber *)experiencia;
-(NSNumber *)devolverExperiencia;
-(NSNumber *)devolverNivel;
-(void)decodificardic:(NSDictionary*)diccionario;
-(NSDictionary *)devolverMascota;
-(void)PushRemoto;
-(void)update;
+(void)saveDataToDisk;

@end
