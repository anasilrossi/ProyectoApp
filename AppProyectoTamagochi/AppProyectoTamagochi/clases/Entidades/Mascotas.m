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


-(instancetype)init
{
    NSManagedObjectContext *context = [[Helper sharedInstance] managedObjectContext];
    self = [NSEntityDescription insertNewObjectForEntityForName:@"Mascotas" inManagedObjectContext:context];
    if (self) {
        
    }
    return self;
}

- (instancetype) initWithDici:(NSDictionary *) dic
{
    NSManagedObjectContext *context = [[Helper sharedInstance] managedObjectContext];
    self = (Mascotas*)[NSEntityDescription insertNewObjectForEntityForName:@"Mascotas" inManagedObjectContext:context];
    
    if(self){
        self.animalNombre = [dic valueForKey:@"name"];
        self.nivel = [dic valueForKey:@"level"];
        self.tipoAnimal = [dic valueForKey:@"pet_type"];
        self.codigoAnimal = [dic valueForKey: @"code"];
        self.altitude = [dic valueForKey:@"position_lat"];
        self.longitud =[dic valueForKey:@"position_lon"];
    }
    
    return self;
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
    self.nivel =[pet valueForKey:@"level"];
    self.tipoAnimal = [pet valueForKey:@"pet_type"];
    self.codigoAnimal = [pet valueForKey: @"code"];
    self.altitude = [pet valueForKey:@"position_lat"];
    self.longitud =[pet valueForKey:@"position_lon"];
    
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
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"nivel" ascending:YES];
    
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
