//
//  TamagochiNetwork.h
//  AppProyectoTamagochi
//
//  Created by Analia on 11/26/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface TamagochiNetwork : AFHTTPSessionManager

+ (instancetype)sharedInstance ;

@end
