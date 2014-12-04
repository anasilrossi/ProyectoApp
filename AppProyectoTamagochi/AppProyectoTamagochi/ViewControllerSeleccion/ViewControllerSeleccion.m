//
//  ViewControllerSeleccion.m
//  AppProyectoTamagochi
//
//  Created by Analia on 18/11/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import "ViewControllerSeleccion.h"
#import "ViewControllerElegida.h"
#import "animalIdentificador.h"
#import "CargarImagenes.h"
#import "Animales.h"

@interface ViewControllerSeleccion ()

@property (weak, nonatomic) IBOutlet UILabel *LabelTitulo;
@property (weak, nonatomic) IBOutlet UIButton *ButtonGato;
@property (weak, nonatomic) IBOutlet UIButton *ButtonLeon;
@property (weak, nonatomic) IBOutlet UIButton *Buttonjirafa;
@property (weak, nonatomic) IBOutlet UIButton *ButtonCiervo;
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *ImagenElegida;
@property (weak, nonatomic) IBOutlet UIButton *Continuar;
@property (nonatomic) NSNumber * animal;
@property (nonatomic,strong)NSUserDefaults * user;

@end

@implementation ViewControllerSeleccion

- (void)viewDidLoad {
    //lo que carga cuando cuando arranca
    [super viewDidLoad];
    self.Nombremascota =[[Animales sharedInstance] animalNombre];
    self.LabelTitulo.text=[NSString stringWithFormat: @"El nombre de tu mascota es %@",self.Nombremascota];
    self.ScrollView.contentSize = CGSizeMake(420, 186) ;
    [self setTitle:@"Seleccione su mascota"];
    self.ImagenElegida.image = [UIImage imageNamed:@"gato_comiendo_1"];
    
}

- (IBAction)Continuar:(id)sender {
    //vamos a la otra vista
  ViewControllerElegida * controlelegida = [[ViewControllerElegida alloc]initWithNibName:@"ViewControllerElegida" bundle:[NSBundle mainBundle]];
    self.user =[NSUserDefaults standardUserDefaults];
    [self.user setBool:YES forKey:@"ViewTwo"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.navigationController pushViewController:controlelegida animated:YES];
}

-(IBAction)mascotaElegida:(id)sender
{
    self.animal = [NSNumber numberWithInt:[sender tag]];
    self.ImagenElegida.image = [CargarImagenes Cargarimagen:[self.animal intValue]];
    [[Animales sharedInstance] setTipoAnimal:self.animal];

}

@end
