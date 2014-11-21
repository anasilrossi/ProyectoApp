//
//  Animales.m
//  AppProyectoTamagochi
//
//  Created by Analia on 21/11/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import "Animales.h"

@implementation Animales

-(id) initWithTag:(int)tag
{
    self = [super init];
    if (self)
    {
        
        switch (tag)
        
        {
            case 0:
            {
                [self setImagenAnimal: @"gato_comiendo_1"];
                [self setTagImagen:tag];
                break;
            }
            case 1:
            {
                [self setImagenAnimal:@"leon_comiendo_1"];
                 [self setTagImagen:tag];
                break;
                
            }
            case 2:
            {
                [self setImagenAnimal:@"jirafa_comiendo_1"];
                 [self setTagImagen:tag];
                break;
            }
            default:
            {
                [self setImagenAnimal:@"ciervo_comiendo_1"];
                 [self setTagImagen:tag];
                break;
            }
        }
 
    }
    return self;
}

-(id) initWithtagArray:(int)tag
{
    self = [super init];
    if (self)
    {
        
        NSArray * array;
        switch (tag)
        
        {
            case 0:
            {
                [self setArraydeimagenes:array];
                array =[[NSArray alloc] initWithObjects:[UIImage imageNamed:@"gato_comiendo_1"],
                                            [UIImage imageNamed:@"gato_comiendo_2"],
                                            [UIImage imageNamed:@"gato_comiendo_3"],
                                            [UIImage imageNamed:@"gato_comiendo_4"],
                                            nil] ;
                
                break;
            }
            case 1:
            {
                [self setArraydeimagenes:array];
                array =[[NSArray alloc] initWithObjects:[UIImage imageNamed:@"leon_comiendo_1"],
                 [UIImage imageNamed:@"leon_comiendo_2"],
                 [UIImage imageNamed:@"leon_comiendo_3"],
                 [UIImage imageNamed:@"leon_comiendo_4"],
                 nil];
                break;
                
            }
            case 2:
            {
                [self setArraydeimagenes:array];
                array =[[NSArray alloc] initWithObjects:[UIImage imageNamed:@"jirafa_comiendo_1"],
                        [UIImage imageNamed:@"jirafa_comiendo_2"],
                        [UIImage imageNamed:@"jirafa_comiendo_3"],
                        [UIImage imageNamed:@"jirafa_comiendo_4"],
                        nil];

                break;
            }
            default:
            {
                [self setArraydeimagenes:array];
                 array =[[NSArray alloc] initWithObjects:[UIImage imageNamed:@"ciervo_comiendo_1"],
                         [UIImage imageNamed:@"ciervo_comiendo_2"],
                         [UIImage imageNamed:@"ciervo_comiendo_3"],
                         [UIImage imageNamed:@"ciervo_comiendo_4"],
                         nil];
                break;
            }
        }
        
    }
    return self;
}

@end
