//
//  ViewControllerRanking.h
//  AppProyectoTamagochi
//
//  Created by Analia on 11/29/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Animales.h"
#import <CoreData/CoreData.h>


@interface ViewControllerRanking : UIViewController <UITableViewDataSource,UITabBarDelegate>

@property(assign, nonatomic) CLLocationDistance altitude;
@property(assign, nonatomic) CLLocationDistance longitud;
@end
