//
//  ViewControllerElegida.h
//  AppProyectoTamagochi
//
//  Created by Analia on 19/11/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerElegida : UIViewController
@property (strong,nonatomic) NSString * Nombremascota;
@property (strong,nonatomic) UIImageView * imagenmascota;
- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil nombre:(NSString *) nombredemascota imagen:(UIImageView *) imagenmascota;

@end
