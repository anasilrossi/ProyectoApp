//
//  CustomAnnotation.m
//  AppProyectoTamagochi
//
//  Created by Analia on 12/2/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import "CustomAnnotation.h"
#import <CoreLocation/CoreLocation.h>
#import "animalIdentificador.h"
#import "CargarImagenes.h"
@implementation CustomAnnotation

-(instancetype) initWithPet :(Mascotas *)pet
{
    if (self = [super init]){
        
        _coordinate = CLLocationCoordinate2DMake(pet.altitude, pet.longitud);
        _title = pet.animalNombre;
        _subtitle = [NSString stringWithFormat:@"%d",pet.nivel];
        animalIdentificador animal = pet.tipoAnimal;
        
        self.imagen = [CargarImagenes Cargarimagen:animal];

        
    }
    return self;
}

@end
