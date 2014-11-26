//
//  NetworkManager.m
//  AppProyectoTamagochi
//
//  Created by Analia on 26/11/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import "NetworkManager.h"
#import "AFNetworkActivityIndicatorManager.h"

@implementation NetworkManager 

+ (instancetype)sharedInstance {
    
    static NetworkManager *_sharedInstance = nil;
    
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
        NSURL const * url = [NSURL URLWithString:@"http://echo.jsontest.com"];
        _sharedInstance = [[NetworkManager alloc] initWithBaseURL: url sessionConfiguration:sessionConfiguration];
        
        //Setup a default JSONSerializer for all request/responses.
        _sharedInstance.requestSerializer = [AFJSONRequestSerializer serializer];
       
    });
    
    return _sharedInstance;
}

@end
