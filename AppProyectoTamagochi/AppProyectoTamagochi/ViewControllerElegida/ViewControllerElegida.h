//
//  ViewControllerElegida.h
//  AppProyectoTamagochi
//
//  Created by Analia on 19/11/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewControllerComida.h"
#import "Animales.h"

@interface ViewControllerElegida : UIViewController <Foot,UIGestureRecognizerDelegate>

@property (strong,nonatomic) NSString * Nombremascota;
@property (strong,nonatomic) UIImageView * Imagen;

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil nombre:(NSString *) nombredemascota imagen:(Animales *) imagenmascota;

@end
