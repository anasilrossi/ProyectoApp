//
//  ViewControllerMap.m
//  AppProyectoTamagochi
//
//  Created by Analia on 12/1/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import "ViewControllerMap.h"
#import "ViewControllerRanking.h"
#import "CargarImagenes.h"

#import <CoreLocation/CoreLocation.h>

@interface ViewControllerMap ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, assign) CLLocationCoordinate2D locacion;

@end

@implementation ViewControllerMap

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.mapView setDelegate:self];
       [self.mapView addAnnotation:[[CustomAnnotation alloc]initWithPet:self.mascotaActual]];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
    self.locacion = CLLocationCoordinate2DMake([self.mascotaActual.altitude intValue], [self.mascotaActual.longitud intValue]);
    
    MKCoordinateRegion region;
    region.center = self.locacion;
    region.span.latitudeDelta = 0.1;
    region.span.longitudeDelta = 0.1;
    

    [mapView setRegion:region animated:YES];
}

- (MKAnnotationView *) mapView: (MKMapView *) mapView viewForAnnotation: (id) annotation {
    
    CustomAnnotation *  anotacion = (CustomAnnotation*)annotation;
    
    static NSString *dqref = @"MyAnnotation";
    MKAnnotationView * aView = [mapView dequeueReusableAnnotationViewWithIdentifier:dqref];
    if (nil == aView) {
    
        aView = [[MKAnnotationView alloc] initWithAnnotation:anotacion reuseIdentifier:@"pinView"];
    }
    
    
    
    //\\-------------------------------------------------------------------------------///
    // Configuramos la vista del mapa
    //\\-------------------------------------------------------------------------------///
    aView.canShowCallout = YES;
    aView.enabled = YES;
    aView.centerOffset = CGPointMake(0, -20);
    
    aView.draggable = YES;
    
    
    
    aView.image = anotacion.imagen;
    
    
    
    //\\-------------------------------------------------------------------------------///
    // Establecemos el tamaño óptimo para el Pin
    //\\-------------------------------------------------------------------------------///
    CGRect frame = aView.frame;
    frame.size.width = 47;
    frame.size.height = 55;
    aView.frame = frame;
    
    
    return aView;
    
    
    
}

@end
