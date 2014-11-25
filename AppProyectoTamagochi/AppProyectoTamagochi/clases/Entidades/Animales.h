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
@end
