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

@interface ViewControllerElegida : UIViewController <Foot,UIGestureRecognizerDelegate,UIPageViewControllerDelegate>

@property (strong,nonatomic) NSString * Nombremascota;
@property (assign,nonatomic) animalIdentificador animal;
@property (assign,nonatomic) animalEstado estado ;


@end
