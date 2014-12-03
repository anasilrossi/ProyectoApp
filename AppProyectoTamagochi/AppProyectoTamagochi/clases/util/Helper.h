//
//  Helper.h
//  AppProyectoTamagochi
//
//  Created by Analia on 12/3/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#ifdef __OBJC__
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Mascotas.h"
#endif

@interface Helper : NSObject

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory;
+ (instancetype) sharedInstance;

@end
