//
//  Comida.h
//  AppProyectoTamagochi
//
//  Created by Analia on 20/11/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Comidas : NSObject

//nombres
@property (strong,nonatomic) NSString * nombrecomida;

//imagenes
@property (strong,nonatomic)  NSString * imagencomida;


- (instancetype) init:(NSString *)nombredelacomida imagen:(NSString *) imagendelacomida;


@end
