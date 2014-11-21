//
//  ViewControllerSeleccion.m
//  AppProyectoTamagochi
//
//  Created by Analia on 18/11/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import "ViewControllerSeleccion.h"
#import "ViewControllerElegida.h"
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
@property (nonatomic) int tagImagen;
@property (strong,nonatomic) Animales *animal;
@end

@implementation ViewControllerSeleccion

- (void)viewDidLoad {
    //lo que carga cuando cuando arranca
    [super viewDidLoad];
    self.LabelTitulo.text=[NSString stringWithFormat: @"El nombre de tu mascota es %@",self.Nombremascota];
    self.ScrollView.contentSize = CGSizeMake(580, 129) ;
    [self setTitle:@"Seleccione su mascota"];
    self.ImagenElegida.image = [UIImage imageNamed:@"gato_comiendo_1"];
 
   
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil nombre:(NSString *)nombredemascota 
{
    //Sobreescribo el metodo para pasar el nombre de la mascota y la imagen
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self!=nil) {
        self.Nombremascota = nombredemascota;
        
    }
    return self;
}
- (IBAction)Continuar:(id)sender {
    
    ViewControllerElegida * controlelegida = [[ViewControllerElegida alloc]initWithNibName:@"ViewControllerElegida" bundle:[NSBundle mainBundle] nombre:self.Nombremascota imagen:self.animal];
    [self.navigationController pushViewController:controlelegida animated:YES];
    
}

-(IBAction)ButtonAnimal:(UIButton *)sender
{
    self.animal = [[Animales alloc ]initWithTag:sender.tag];
    [self.ImagenElegida setImage:[UIImage imageNamed:self.animal.imagenAnimal]];
    self.tagImagen = sender.tag ;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
