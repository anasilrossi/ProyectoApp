//
//  Mascotas.h
//  AppProyectoTamagochi
//
//  Created by Analia on 12/2/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "animalIdentificador.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreData/CoreData.h>

@interface Mascotas : NSManagedObject 

@property (strong,nonatomic) NSString * animalNombre;
@property (nonatomic,strong) NSNumber * tipoAnimal;
@property (nonatomic,strong) NSNumber * estadoAnimal;
@property (nonatomic,strong) NSNumber *  nivel;
@property (nonatomic,strong) NSNumber *  experiencia;
@property(strong, nonatomic) NSNumber * altitude;
@property(strong, nonatomic) NSNumber * longitud;
@property (nonatomic,strong) NSString * codigoAnimal;
@property (nonatomic,strong) NSNumber *  energia;


- (instancetype) initWithDici:(NSDictionary *) dic;
+(void)borrarTodo;
+(NSArray *)devolverTodo;
-(void)updateCoreData:(Mascotas *)pet;
+(void)insertCoreData:(Mascotas *)pet;


@end
