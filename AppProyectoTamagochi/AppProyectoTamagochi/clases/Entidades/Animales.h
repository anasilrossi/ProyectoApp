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

@interface Animales : NSObject
@property (strong,nonatomic) NSString * animalNombre;
@property (nonatomic,assign) animalIdentificador tipoAnimal;
@property (nonatomic,assign) animalEstado estadoAnimal;
@property (nonatomic,assign) int  nivel;
@property (nonatomic,strong) NSString *codigoAnimal;
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
//-(instancetype)initWithDic:(NSString *)nombre nivel:(int)nivel tipo:(animalIdentificador)tipo code:(NSString *)codigo;
-(instancetype)initwithDici: (NSDictionary *) dic;
@end
