//
//  Animales.h
//  TuMascotaVirtual
//
//  Created by Analia on 22/11/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

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
-(int)masEnergia;
-(BOOL)puedeejercitar;
-(int)devolverEnergia;
@end
