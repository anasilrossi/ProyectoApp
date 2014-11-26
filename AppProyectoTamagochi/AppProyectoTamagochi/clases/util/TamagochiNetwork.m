//
//  TamagochiNetwork.m
//  AppProyectoTamagochi
//
//  Created by Analia on 11/26/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import "TamagochiNetwork.h"
#import "AFNetworkActivityIndicatorManager.h"

@implementation TamagochiNetwork

+ (instancetype)sharedInstance {
    
    static TamagochiNetwork *_sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        // Network activity indicator manager setup
        
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
        
        // Session configuration setup
        
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        sessionConfiguration.timeoutIntervalForRequest = 20.0;
        sessionConfiguration.timeoutIntervalForResource = 20.0;
        sessionConfiguration.HTTPMaximumConnectionsPerHost = 1;
        [sessionConfiguration setRequestCachePolicy:NSURLRequestReloadIgnoringCacheData];
        
        // Initialize the session
        NSURL  * const url = [NSURL URLWithString:@"http://tamagotchi.herokuapp.com"];
        _sharedInstance = [[TamagochiNetwork alloc] initWithBaseURL: url sessionConfiguration:sessionConfiguration];
        
        //Setup a default JSONSerializer for all request/responses.
        _sharedInstance.requestSerializer = [AFJSONRequestSerializer serializer];
        
    });
    
    return _sharedInstance;
}

@end
