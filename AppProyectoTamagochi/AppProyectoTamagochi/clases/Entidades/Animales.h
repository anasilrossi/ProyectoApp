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

@property (strong,nonatomic) NSString * animalNombre;
@property (nonatomic,strong) NSNumber * tipoAnimal;
@property (nonatomic,strong) NSNumber * estadoAnimal;
@property (nonatomic,strong) NSNumber *  nivel;
@property (nonatomic,strong) NSNumber *  experiencia;
@property(strong, nonatomic) NSNumber * altitude;
@property(strong, nonatomic) NSNumber * longitud;
@property (nonatomic,strong) NSString * codigoAnimal;
@property (nonatomic,strong) NSNumber *  energia;


//Constructor
+ (instancetype) sharedInstance;

//metodos propios
-(NSNumber *)menosEnergia;
-(NSNumber *)masEnergia: (int)valor;
-(BOOL)puedeejercitar;
-(int)devolverEnergia;
-(NSNumber *)aumentarExperiencia:(int)valor;
-(NSNumber *)subirNivel : (NSNumber *)experiencia;
-(NSNumber *)devolverExperiencia;
-(NSNumber *)devolverNivel;
-(void)decodificardic:(NSDictionary*)diccionario;
-(NSDictionary *)devolverMascota;
-(void)PushRemoto;
-(void)updates;
+(void)saveDataToDisk;


@end
