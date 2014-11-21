//
//  Animales.h
//  AppProyectoTamagochi
//
//  Created by Analia on 21/11/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    Gato,Leon,Jirafa,Ciervo
        } EnumVarType;

@interface Animales : NSObject

@property (strong,nonatomic) NSString * imagenAnimal;
@property (strong,nonatomic) NSArray * arraydeimagenes;
@property (nonatomic) int tagImagen;
-(id) initWithTag:(int)tag;

@end
