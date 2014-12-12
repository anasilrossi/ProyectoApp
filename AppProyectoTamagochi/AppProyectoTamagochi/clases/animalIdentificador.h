//
//  animalIdentificador.h
//  TuMascotaVirtual
//
//  Created by Analia on 22/11/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#ifndef TuMascotaVirtual_animalIdentificador_h
#define TuMascotaVirtual_animalIdentificador_h
typedef enum
{
    
    animal_ciervo = 0,
    animal_gato ,
    animal_leon ,
    animal_jirafa
} animalIdentificador;

typedef enum
{
    
    animal_estado_primero = 0,
    animal_comiendo ,
    animal_ejercitando,
    animal_exhauto,
    animal_sucio,
    animal_limpio,
    animal_estado_final = animal_exhauto
    
} animalEstado;
#endif
