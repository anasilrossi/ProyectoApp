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

@property (retain,nonatomic) NSString * animalNombre;
@property (nonatomic,retain) NSNumber * tipoAnimal;
@property (nonatomic,retain) NSNumber * estadoAnimal;
@property (nonatomic,retain) NSNumber *  nivel;
@property (nonatomic,retain) NSNumber *  experiencia;
@property(retain, nonatomic) NSNumber * altitude;
@property(retain, nonatomic) NSNumber * longitud;
@property (nonatomic,strong) NSString * codigoAnimal;
@property (nonatomic,retain) NSNumber *  energia;


- (instancetype) initWithDici:(NSDictionary *) dic;
+(void)borrarTodo;
+(NSArray *)devolverTodo;
-(void)updateCoreData:(Mascotas *)pet;
+(void)insertCoreData:(Mascotas *)pet;
@end
