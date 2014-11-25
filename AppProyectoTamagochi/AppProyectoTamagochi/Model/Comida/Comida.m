//
//  Comida.m
//  AppProyectoTamagochi
//
//  Created by Analia on 20/11/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import "Comida.h"

@implementation Comidas

- (instancetype) init:(NSString *)nombredelacomida imagen:(NSString *) imagendelacomida valor:(int)valorComida;
{
    self = [super init];
    if (self!=nil) {
        self.nombrecomida = nombredelacomida;
        self.imagencomida = imagendelacomida;
        self.valor = valorComida;
    }
    return self;

}



@end
