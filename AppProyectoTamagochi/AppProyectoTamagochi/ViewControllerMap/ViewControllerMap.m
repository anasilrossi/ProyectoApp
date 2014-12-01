//
//  ViewControllerMap.m
//  AppProyectoTamagochi
//
//  Created by Analia on 12/1/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import "ViewControllerMap.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewControllerMap ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@end

@implementation ViewControllerMap

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.mapView setDelegate:self];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)devolverLocalizacion:(Animales*)mascota
{
    self.coordinate = CLLocationCoordinate2DMake(mascota.altitude, mascota.altitude);
}

-(void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
    
    MKCoordinateRegion region;
    region.center = self.coordinate;
    region.span.latitudeDelta = 0.1;
    region.span.longitudeDelta = 0.1;
    [mapView setRegion:region animated:YES];
}


@end
