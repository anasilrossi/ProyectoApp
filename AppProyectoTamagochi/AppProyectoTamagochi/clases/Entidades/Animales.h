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
@property (assign,nonatomic) animalIdentificador animalIdentificador;

//Constructor
-(instancetype) init;
-(instancetype)initWithName:(NSString *)animalnombre identificador:(animalIdentificador)identificador;


@end
