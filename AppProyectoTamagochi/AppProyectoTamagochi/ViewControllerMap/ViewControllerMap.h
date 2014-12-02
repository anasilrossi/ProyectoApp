//
//  ViewControllerMap.h
//  AppProyectoTamagochi
//
//  Created by Analia on 12/1/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ViewControllerRanking.h"
#import "CustomAnnotation.h"

@interface ViewControllerMap : UIViewController <MKMapViewDelegate>
 @property (strong,nonatomic) Mascotas * mascotaActual;
@end
