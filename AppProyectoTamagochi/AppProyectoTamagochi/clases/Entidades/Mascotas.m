//
//  Mascotas.m
//  AppProyectoTamagochi
//
//  Created by Analia on 12/2/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import "Mascotas.h"
#import "Animales.h"

@implementation Mascotas

-(instancetype)initwithDici:(NSDictionary *) dic
{
    Mascotas * animal = [super init];
    if(animal){
        animal.animalNombre = [dic valueForKey:@"name"];
        animal.nivel = ((NSNumber *)[dic valueForKey:@"level"]).intValue;
        animal.tipoAnimal = ((NSNumber *)[dic valueForKey:@"pet_type"]).intValue;
        animal.codigoAnimal = [dic valueForKey: @"code"];
        animal.altitude = ((NSNumber *)[dic valueForKey:@"position_lat"]).intValue;
        animal.longitud =((NSNumber *)[dic valueForKey:@"position_lon"]).intValue;
        
    }
    return animal;
}

#pragma mark NSCoder

- (id) initWithCoder: (NSCoder *)coder
{
    if (self = [super init])
    {
        [self setAnimalNombre:[coder decodeObjectForKey:@"name"]]; //Por cada property.
        [self setTipoAnimal :[coder decodeIntForKey:@"pet_type"]];
        [self setEstadoAnimal:[coder decodeIntForKey:@"estado"]];
        [self setNivel: [coder decodeIntForKey:@"level"]];
        [self setExperiencia:[coder decodeIntForKey:@"experience"]];
        [self setAltitude:[coder decodeDoubleForKey:@"position_lat"]];
        [self setLongitud:[coder decodeDoubleForKey:@"position_lon"]];
        [self setCodigoAnimal:[coder decodeObjectForKey:@"code"]];
        [self setEnergia:[coder decodeIntForKey:@"energy"]];
    }
    return self;
}

- (void) encodeWithCoder: (NSCoder *)coder
{
    [coder encodeObject: self.animalNombre forKey:@"name"];
    [coder encodeInt:self.tipoAnimal forKey:@"pet_type"];
    [coder encodeInt:self.estadoAnimal forKey:@"estado"];
    [coder encodeInt:self.nivel forKey:@"level"];
    [coder encodeInt:self.experiencia forKey:@"experience"];
    [coder encodeDouble:self.altitude forKey:@"position_lat"];
    [coder encodeDouble:self.longitud forKey:@"position_lon"];
    [coder encodeObject:self.codigoAnimal forKey:@"code"];
    [coder encodeInt:self.energia forKey:@"energy"];
}



@end
