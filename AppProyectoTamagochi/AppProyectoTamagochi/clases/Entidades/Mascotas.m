//
//  Mascotas.m
//  AppProyectoTamagochi
//
//  Created by Analia on 12/2/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import "Mascotas.h"
#import "Animales.h"
#import "Helper.h"


@implementation Mascotas 
@synthesize animalNombre ,tipoAnimal,estadoAnimal,nivel,experiencia,altitude,longitud,codigoAnimal,energia;


- (instancetype) initWithDici:(NSDictionary *) dic
{
    NSManagedObjectContext *context = [[Helper sharedInstance] managedObjectContext];
    self = (Mascotas*)[NSEntityDescription insertNewObjectForEntityForName:@"Mascotas" inManagedObjectContext:context];
    
    if(self){
        self.animalNombre = [dic valueForKey:@"name"];
        self.nivel = ((NSNumber *)[dic valueForKey:@"level"]).intValue;
        self.tipoAnimal = ((NSNumber *)[dic valueForKey:@"pet_type"]).intValue;
        self.codigoAnimal = [dic valueForKey: @"code"];
        self.altitude = ((NSNumber *)[dic valueForKey:@"position_lat"]).intValue;
        self.longitud =((NSNumber *)[dic valueForKey:@"position_lon"]).intValue;
    }
    
    return self;
}

#pragma mark NSCoder

- (id) initWithCoder: (NSCoder *)coder
{
    if (self = [super init])
    {
        [self setAnimalNombre:[coder decodeObjectForKey:@"name"]]; //Por cada property.
        [self setTipoAnimal :[coder decodeIntForKey:@"pet_type"]];
        [self setEstadoAnimal:[coder decodeIntForKey:@"estado"]];
        [self setNivel: [coder decodeIntForKey:@"level"]];
        [self setExperiencia:[coder decodeIntForKey:@"experience"]];
        [self setAltitude:[coder decodeDoubleForKey:@"position_lat"]];
        [self setLongitud:[coder decodeDoubleForKey:@"position_lon"]];
        [self setCodigoAnimal:[coder decodeObjectForKey:@"code"]];
        [self setEnergia:[coder decodeIntForKey:@"energy"]];
    }
    return self;
}

- (void) encodeWithCoder: (NSCoder *)coder
{
    [coder encodeObject: self.animalNombre forKey:@"name"];
    [coder encodeInt:self.tipoAnimal forKey:@"pet_type"];
    [coder encodeInt:self.estadoAnimal forKey:@"estado"];
    [coder encodeInt:self.nivel forKey:@"level"];
    [coder encodeInt:self.experiencia forKey:@"experience"];
    [coder encodeDouble:self.altitude forKey:@"position_lat"];
    [coder encodeDouble:self.longitud forKey:@"position_lon"];
    [coder encodeObject:self.codigoAnimal forKey:@"code"];
    [coder encodeInt:self.energia forKey:@"energy"];
}

#pragma mark --Insert
+(void)insertCoreData:(Mascotas *)pet
{
    /*Save to Core Data*/
    NSManagedObjectContext * context = [[Helper sharedInstance] managedObjectContext];
    
    
    NSError *localerror;
    if (![context save:&localerror]) { //Guardamos los cambios en el contexto.
        NSLog(@"Error, couldn't save: %@",[localerror localizedDescription]);
        [context rollback];
    }
}

-(void)updateCoreData:(Mascotas *)pet
{
    
    NSManagedObjectContext *context = [[Helper sharedInstance] managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription  entityForName:@"Mascotas" inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    NSError *error;
//    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];

    
    self.animalNombre = [pet valueForKey:@"name"];
    self.nivel = ((NSNumber *)[pet valueForKey:@"level"]).intValue;
    self.tipoAnimal = ((NSNumber *)[pet valueForKey:@"pet_type"]).intValue;
    self.codigoAnimal = [pet valueForKey: @"code"];
    self.altitude = ((NSNumber *)[pet valueForKey:@"position_lat"]).intValue;
    self.longitud =((NSNumber *)[pet valueForKey:@"position_lon"]).intValue;
    
     if([self.managedObjectContext hasChanges] && ![self.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        [context rollback];
     }
}

+(NSArray *)devolverTodo
{
    NSManagedObjectContext *context = [[Helper sharedInstance] managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Mascotas"    inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchLimit:200];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"level" ascending:YES];
    
    [fetchRequest setSortDescriptors:[NSMutableArray arrayWithObject:sortDescriptor]];
    NSError *error;
    NSArray * fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    if (![context save:&error]) { //Guardamos los cambios en el contexto.
        NSLog(@"Error, couldn't save: %@",[error localizedDescription]);
        [context rollback];
    }
    return fetchedObjects;
}
    
+(void)borrarTodo
{
    NSManagedObjectContext *context = [[Helper sharedInstance] managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription                                                                                                entityForName:@"Mascotas" inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    [fetchRequest setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    NSError * error = nil;
    NSArray * mascot = [context executeFetchRequest:fetchRequest error:&error];
    //error handling goes here
    for (NSManagedObject * aux in mascot) {
        [context deleteObject:aux]; }
    NSError *saveError = nil;
    if (![context save:&saveError]) { //Guardamos los cambios en el contexto.
        NSLog(@"Error, couldn't delete: %@", [saveError localizedDescription]);
        [context rollback]; }
}


@end
