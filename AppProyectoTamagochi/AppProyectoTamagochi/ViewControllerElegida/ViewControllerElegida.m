//
//  ViewControllerElegida.m
//  AppProyectoTamagochi
//
//  Created by Analia on 19/11/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import "ViewControllerElegida.h"
#import "ViewControllerComida.h"
#import "animalIdentificador.h"
#import "CargarImagenes.h"

@interface ViewControllerElegida ()
@property (weak, nonatomic) IBOutlet UIImageView *ImagenMascota;
@property (weak, nonatomic) IBOutlet UILabel *NombreMascota;
@property (weak, nonatomic) IBOutlet UIButton *alimentar;
@property (weak, nonatomic) IBOutlet UIImageView *ImagenComida;
@property (nonatomic) CGPoint tapLocation;
@property (nonatomic) CGPoint locacionImagen;
@property (nonatomic) int tagImagen;
@property (strong , nonatomic) IBOutlet UIProgressView * threadProgressView;
@property (weak, nonatomic) IBOutlet UIProgressView *Progressbar;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *gestoTap;
@property (strong,nonatomic) NSTimer * timer;
@end

@implementation ViewControllerElegida

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locacionImagen = self.ImagenComida.center;
    self.NombreMascota.text =self.Nombremascota;
    [self setTitle:@"Energia de su mascota"];
    
    UITapGestureRecognizer * recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(darDeComer:)];
    //Le asignamos el delegate
    recognizer.delegate = self;
    //Lo agregamos a la Vista donde debe detectar el tap
    [self.view addGestureRecognizer:recognizer];
     self.ImagenMascota.image = [CargarImagenes Cargarimagen:self.animal];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)DevolverComida:(Comidas*)comidas
{
    //devuelve la comida en la pantalla
    [self.ImagenComida setImage:[UIImage imageNamed:comidas.imagencomida]];
    [self.ImagenComida setHidden:NO];
    [self.ImagenComida setCenter:self.locacionImagen];
}

-(IBAction)darDeComer:(UITapGestureRecognizer*)sender
    {
         self.tapLocation = [sender locationInView: self.view];
       
        [UIView animateWithDuration:0.1
                              delay:0.0
                            options:UIViewAnimationOptionAllowAnimatedContent
                         animations:^{ [self.ImagenComida setCenter:_tapLocation];}
                         completion:^(BOOL finished) {
                             UIView * vista = [self.view hitTest:_tapLocation withEvent:nil];
                             if ([vista isEqual:self.ImagenMascota]) {
                                 [self.ImagenComida setHidden:YES];
                                 [self.ImagenComida startAnimating];
                                 
                             }
                         }];
        [self.ImagenMascota setAnimationImages:[CargarImagenes Cargararray:self.animal estado:self.estado]];
        [self.ImagenMascota startAnimating];
        //[self CargarProgress];
        
}

-(void)CargarProgress
{
    //manejo del tiempo
    self.threadProgressView.progress = 0.0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(CargarProgress) userInfo:nil repeats:NO];
    
    if (self.threadProgressView.progress < 1)
    {
        self.threadProgressView.progress += 0.5;
        [self.ImagenMascota stopAnimating];
        
    }
    else
    {
        [self.ImagenMascota stopAnimating];
        [self.timer invalidate];
        
    }

}
-(instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil nombre:(NSString *)nombredemascota imagen:(animalIdentificador)imagenmascota
{
    //Sobreescribo el metodo para pasar el nombre de la mascota y la imagen
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self!=nil) {
        self.Nombremascota = nombredemascota;
        self.ImagenMascota.image = [CargarImagenes Cargarimagen:imagenmascota];
//        self.ImagenMascota.image = [CargarImagenes Cargarimagen:self.animal];
         self.animal= imagenmascota;
        self.estado = animal_comiendo;
    }
    return self;
}
- (IBAction)AlimentarMascota:(id)sender {

    ViewControllerComida * controlcomida = [[ViewControllerComida alloc]initWithNibName:@"ViewControllerComida" bundle:[NSBundle mainBundle] ];
     [controlcomida setDelegate:self];
    
    [self.navigationController pushViewController:controlcomida animated:YES];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.timer invalidate];
}

@end
