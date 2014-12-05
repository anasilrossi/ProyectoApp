//
//  TNetworkService.m
//  AppProyectoTamagochi
//
//  Created by Analia on 11/29/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import "TNetworkService.h"
#import "TamagochiNetwork.h"
#import "Animales.h"

@interface TNetworkService()

@property (nonatomic,copy) Success successBlock;
@property (nonatomic,copy) Failure failureBlock;

@end


NSString * const lista_Pet = @"pet/all";


@implementation TNetworkService

-(void)postEvents:(Success)success failure:(Failure)failure
{
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
    
    self.successBlock = success;
    self.failureBlock = failure;
    
     __weak typeof(self) weakself = self;
    TamagochiNetwork * manager = [TamagochiNetwork sharedInstance];
    [manager POST:@"/pet"
       parameters:datos
        success:^(NSURLSessionDataTask *task, id responseObject) {
            
            weakself.successBlock(responseObject);
        }
          failure:^(NSURLSessionDataTask *task, NSError *error) {
              weakself.failureBlock(error);
          }];

}

-(void) getAllEvents:(Success) success failure:(Failure) failure
{
  
   __weak typeof(self) weakself = self;
    weakself.successBlock = success;
    weakself.failureBlock = failure;
    [[TamagochiNetwork sharedInstance]GET:@"/pet/all"
                               parameters:nil
                                  success:^(NSURLSessionDataTask *task, id responseObject)
                                    {
         
                                        weakself.successBlock(responseObject);
                                    }
     
                                  failure:^(NSURLSessionDataTask *task, NSError *error)
                                    {
                                        weakself.failureBlock(error);
                                    }
     ];

}

-(void) getOneEvents:(Success) success failure:(Failure) failure codigo:(NSString *)code
{
    __weak typeof(self) weakself = self;
    weakself.successBlock = success;
    weakself.failureBlock = failure;
    NSString * codigo= [NSString stringWithFormat:@"/pet/%@",code];
    [[TamagochiNetwork sharedInstance]GET:codigo
                               parameters:nil
                                  success:^(NSURLSessionDataTask *task, id responseObject)
                                {
                                    weakself.successBlock(responseObject);
                                }
                                    failure:^(NSURLSessionDataTask *task, NSError *error) {
                                        weakself.failureBlock(error);
                                    }
     ];
}

@end
