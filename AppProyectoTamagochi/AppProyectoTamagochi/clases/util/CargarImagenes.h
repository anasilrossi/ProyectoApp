//
//  CargarImagenes.h
//  TuMascotaVirtual
//
//  Created by Analia on 22/11/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "animalIdentificador.h"

@interface CargarImagenes : NSObject
+ (UIImage*) Cargarimagen: (animalIdentificador) tipoanimal;
+ (UIImage*) CargarimagenCansado:(animalIdentificador)tipoanimal;
+ (NSArray*) Cargararray: (animalIdentificador) tipoanimal estado: (animalEstado) estadoAnimal ;


@end
