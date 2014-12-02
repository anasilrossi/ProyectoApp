//
//  CustomAnnotation.h
//  AppProyectoTamagochi
//
//  Created by Analia on 12/2/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "Mascotas.h"
@interface CustomAnnotation : MKAnnotationView <MKAnnotation>
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *subtitle;
@property (nonatomic ,strong)UIImage * imagen;

-(instancetype) initWithPet :(Mascotas *)pet;
@end
