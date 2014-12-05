//
//  TNetworkService.h
//  AppProyectoTamagochi
//
//  Created by Analia on 11/29/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^Success)(NSMutableArray* array);
typedef void (^Failure)(NSError* error);
@interface TNetworkService : UIView
- (void) postEvents:(Success) success failure:(Failure) failure;
- (void) getAllEvents:(Success) success failure:(Failure) failure;
- (void) getOneEvents:(Success) success failure:(Failure) failure codigo:(NSString *)code;
@end
