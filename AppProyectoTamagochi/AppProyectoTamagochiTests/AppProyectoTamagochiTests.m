//
//  AppProyectoTamagochiTests.m
//  AppProyectoTamagochiTests
//
//  Created by Analia on 18/11/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Animales.h"

@interface AppProyectoTamagochiTests : XCTestCase

@end

@implementation AppProyectoTamagochiTests

- (void)setUp {
    [super setUp];
    [[Animales sharedInstance]setEnergia:[NSNumber numberWithInt:100]];
    [[Animales sharedInstance]setExperiencia:0];
    [[Animales sharedInstance] setNivel:[NSNumber numberWithInt: 1]];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}



-(void)test1verificarEnergia
{
    XCTAssertTrue([[Animales sharedInstance] puedeejercitar],@"No Puede Ejercitar");
    XCTAssertTrue([[Animales sharedInstance]menosEnergia] == [NSNumber numberWithInt: 90],@"No esta restando bien");
    
}

-(void)test2VerificarExperiencia
{
   
         XCTAssertTrue([[Animales sharedInstance] aumentarExperiencia:15] == [NSNumber numberWithInt: 15],@"Experincia cargada mal" );
    
}


@end
