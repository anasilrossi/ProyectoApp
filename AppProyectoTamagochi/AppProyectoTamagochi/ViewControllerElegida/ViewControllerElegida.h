//
//  ViewControllerElegida.h
//  AppProyectoTamagochi
//
//  Created by Analia on 19/11/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewControllerComida.h"
#import "animalIdentificador.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>

@interface ViewControllerElegida : UIViewController <Foot,UIGestureRecognizerDelegate, CLLocationManagerDelegate>

@property (strong,nonatomic) NSString * Nombremascota;
@property (strong,nonatomic) NSNumber * animal;
@property (strong,nonatomic) NSNumber * estado ;


@end
