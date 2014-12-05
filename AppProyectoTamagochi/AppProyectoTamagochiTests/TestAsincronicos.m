//
//  TestAsincronicos.m
//  AppProyectoTamagochi
//
//  Created by Analia on 12/5/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "TamagochiNetwork.h"
#import "Animales.h"


@interface TestAsincronicos : XCTestCase

@end

@implementation TestAsincronicos

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testPost
{
    XCTestExpectation *expectation =
    [self expectationWithDescription:@"testPost"];
    
    NSString * saltitud = [NSString stringWithFormat:@"%@",                          [[Animales sharedInstance]altitude]];
    NSString * slongitud = [NSString stringWithFormat:@"%@",[[Animales sharedInstance]altitude]];
    NSNumber * sEnergia = [[Animales sharedInstance]energia ];
    NSNumber * sNivel =[[Animales sharedInstance]nivel] ;
    NSNumber * sExperiencia = [[Animales sharedInstance]experiencia ];
    NSNumber * tipomascota = [[Animales sharedInstance]tipoAnimal];
    
    NSMutableDictionary * datos = [NSMutableDictionary dictionaryWithDictionary:@{ @"code":code,
                                                                                   @"name":[[Animales sharedInstance]animalNombre] ? [[Animales sharedInstance]animalNombre] :@"",
                                                                                   @"energia":sEnergia,
                                                                                   @"level":sNivel,
                                                                                   @"experience":sExperiencia,
                                                                                   @"position_lat":saltitud,
                                                                                   @"position_lon":slongitud,
                                                                                   @"tipomascota":tipomascota}];
    TamagochiNetwork * manager = [TamagochiNetwork sharedInstance];
    [manager POST:@"/pet"
       parameters:datos
          success:^(NSURLSessionDataTask *task, id responseObject) {
              NSDictionary * responseDict = responseObject;
              NSString * valor = [responseDict valueForKey:@"status"];
              if ([valor isEqualToString: @"ok"]) {
                  NSLog(@"Perfecto! JSON: %@", responseObject);
                  [expectation fulfill];
                  
              }
              else
              {
                  UIAlertView * alerta =[[UIAlertView alloc]initWithTitle: @"alerta" message: @"Error " delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles: nil ];
                  [alerta show];
              }
              
          }     failure:^(NSURLSessionDataTask *task, NSError *error) {
              NSLog(@"Error: %@", error);
          }];

    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) { if (error) {
        NSLog(@"Timeout Error: %@", error);
    }
    }];
}

-(void)testGetUna
{
    XCTestExpectation *expectation =
    [self expectationWithDescription:@"testGetUna"];
    
    Animales * animal = [[Animales alloc] init];
    NSString * codigo= [NSString stringWithFormat:@"/pet/AR7666"];
    [[TamagochiNetwork sharedInstance]GET:codigo
                               parameters:nil
                                  success:^(NSURLSessionDataTask *task, id responseObject)
     {
         
         animal.animalNombre=  [responseObject valueForKey:@"name"];
         animal.tipoAnimal=  [responseObject valueForKey:@"pet_type"];
         animal.nivel = [responseObject valueForKey:@"level"];
         animal.energia = [responseObject valueForKey:@"energia"];
         [expectation fulfill];
        
     }
                                  failure:^(NSURLSessionDataTask *task, NSError *error) {
                                      NSLog(@"Error: %@", error);}
     ];
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) { if (error) {
        NSLog(@"Timeout Error: %@", error);}}];
    
}

-(void)testTodas
{
    [[TamagochiNetwork sharedInstance]GET:@"/pet/all"
                               parameters:nil
                                  success:^(NSURLSessionDataTask *task, id responseObject)
     {
         
         NSArray * responseDict = responseObject;
         //[[Animales sharedInstance]decodificardic:responseDict];
         NSLog(@"JSON array: %@", responseDict);
    }
                        failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"Error: %@", error);}
         ];

}

@end
