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

@interface Mascotas : NSManagedObject <NSCoding>

@property (retain,nonatomic) NSString * animalNombre;
@property (nonatomic,assign) animalIdentificador tipoAnimal;
@property (nonatomic,assign) animalEstado estadoAnimal;
@property (nonatomic,assign) int  nivel;
@property (nonatomic,assign) int  experiencia;
@property(assign, nonatomic) CLLocationDistance altitude;
@property(assign, nonatomic) CLLocationDistance longitud;
@property (nonatomic,strong) NSString *codigoAnimal;
@property (nonatomic,assign) int  energia;


- (instancetype) initWithDici:(NSDictionary *) dic;
+(void)borrarTodo;
+(NSArray *)devolverTodo;
-(void)updateCoreData:(Mascotas *)pet;
+(void)insertCoreData:(Mascotas *)pet;
@end
