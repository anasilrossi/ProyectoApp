//
//  NSString+CustonString.m
//  AppProyectoTamagochi
//
//  Created by Analia on 25/11/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import "NSString+CustonString.h"

@implementation NSString(CustonString)

-(BOOL)EsVacio
{
    BOOL respuesta ;
    if ([self isEqualToString:@""])
    {
         respuesta = YES;
        //validamos si esta vacio
     }
    else
    {
        respuesta= NO;
    }
    return respuesta;
}

-(BOOL)MayorCuatroLetras
{
    BOOL respuesta;
    if (self.length < 4)
    {
        respuesta=YES;
    }
    else{respuesta=NO;}

    return respuesta;
}

-(BOOL)Sololetras
{
    BOOL respuesta;
    if ([self rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"0123456789-,.:;}{[]^`´+*¨¡?=))(&%$#!><_"]].location != NSNotFound) {
        respuesta=YES;
    }
    else
    {respuesta= NO;}
    return respuesta;
}

@end
