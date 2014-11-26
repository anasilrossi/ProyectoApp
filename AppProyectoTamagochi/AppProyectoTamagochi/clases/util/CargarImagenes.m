//
//  CargarImagenes.m
//  TuMascotaVirtual
//
//  Created by Analia on 22/11/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import "CargarImagenes.h"

@implementation CargarImagenes

+ (UIImage*) Cargarimagen:(animalIdentificador)tipoanimal
{
    NSString* nombreimagen;
    switch (tipoanimal)
    {
        default: //Default value is just for avoid crashes
        case animal_gato:
            nombreimagen = @"gato_comiendo_1";
            break;
        case animal_ciervo:
            nombreimagen = @"ciervo_comiendo_1";
            break;
        case animal_jirafa:
            nombreimagen = @"jirafa_comiendo_1";
            break;
        case animal_leon:
            nombreimagen = @"leon_comiendo_1";
            break;
    }
    UIImage* imagenAnimal = [UIImage imageNamed:nombreimagen];
    return imagenAnimal;
}

+ (UIImage*) CargarimagenCansado:(animalIdentificador)tipoanimal
{
    NSString* nombreimagen;
    switch (tipoanimal)
    {
        default: //Default value is just for avoid crashes
        case animal_gato:
            nombreimagen = @"gato_exhausto_4";
            break;
        case animal_ciervo:
            nombreimagen = @"ciervo_exhausto_4";
            break;
        case animal_jirafa:
            nombreimagen = @"jirafa_exhausto_4";
            break;
        case animal_leon:
            nombreimagen = @"leon_exhausto_4";
            break;
    }
    UIImage* imagenAnimal = [UIImage imageNamed:nombreimagen];
    return imagenAnimal;
}

+ (NSArray*) Cargararray:(animalIdentificador)tipoanimal estado:(animalEstado)estadoAnimal
{
    NSMutableArray* Listaimagenes = [[NSMutableArray alloc] init];
    
    NSString* formato = @"%@_%@_%d";
    NSString* nombreimagen;
    NSString* estado;
    
    switch (tipoanimal)
    {
        
        case animal_gato:
            nombreimagen = @"gato";
            break;
        case animal_jirafa:
            nombreimagen = @"jirafa";
            break;
        case animal_ciervo:
            nombreimagen = @"ciervo";
            break;
        case animal_leon:
            nombreimagen = @"leon";
            break;
    }
    
    switch (estadoAnimal)
    {
        case animal_comiendo:
            estado = @"comiendo";
            break;
        case animal_exhauto:
            estado = @"exhausto";
            break;
        case animal_ejercitando:
            estado = @"ejercicio";
            break;
    }
    const int ammountOfImages = estadoAnimal == animal_ejercitando ? 5 : 4;
    for(int i = 1; i <= ammountOfImages; ++i)
    {
        NSString* nombre = [NSString stringWithFormat:formato, nombreimagen, estado, i];
        [Listaimagenes addObject:[UIImage imageNamed:nombre]];
    }
    
    NSArray* petAnimationImages = [[NSArray alloc] initWithArray:Listaimagenes];
    return petAnimationImages;
}

@end
