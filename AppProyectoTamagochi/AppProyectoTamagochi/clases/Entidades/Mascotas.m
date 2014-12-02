//
//  Mascotas.m
//  AppProyectoTamagochi
//
//  Created by Analia on 12/2/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import "Mascotas.h"

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

@end
