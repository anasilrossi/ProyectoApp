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
    
    animal_gato = 1,
    animal_leon = 3,
    animal_jirafa = 2,
    animal_ciervo =0
} animalIdentificador;

typedef enum
{
    
    animal_estado_primero = 0,
    animal_comiendo ,
    animal_ejercitando,
    animal_exhauto,
    animal_estado_final = animal_exhauto
    
} animalEstado;
#endif
