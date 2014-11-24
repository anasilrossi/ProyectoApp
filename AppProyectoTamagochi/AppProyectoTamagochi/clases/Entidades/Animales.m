//
//  Animales.m
//  TuMascotaVirtual
//
//  Created by Analia on 22/11/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import "Animales.h"

@implementation Animales

#pragma mark - Constructors
-(instancetype) init
{
    self = [super init];
    [self setAnimalNombre:@""];
    [self setAnimalIdentificador:animal_gato];
    
    return self;
}

-(instancetype)initWithName:(NSString *)animalnombre identificador:(animalIdentificador)identificador
{
    self = [super init];
    [self setAnimalIdentificador:animal_gato];
    [self setAnimalNombre:_animalNombre];
      return self;
}

@end
