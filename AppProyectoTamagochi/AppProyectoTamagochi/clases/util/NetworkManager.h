//
//  NetworkManager.h
//  AppProyectoTamagochi
//
//  Created by Analia on 26/11/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface NetworkManager : AFHTTPSessionManager

+ (instancetype)sharedInstance ;

@end
