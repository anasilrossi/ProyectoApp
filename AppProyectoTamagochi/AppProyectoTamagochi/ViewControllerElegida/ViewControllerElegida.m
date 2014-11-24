//
//  ViewControllerElegida.m
//  AppProyectoTamagochi
//
//  Created by Analia on 19/11/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import <MessageUI/MessageUI.h>
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
-(void)viewDidAppear:(BOOL)animated
{
    UIButton *buttonMail = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    
    [buttonMail addTarget:self action:@selector(senderMail:) forControlEvents:UIControlEventTouchUpInside];
    
    [buttonMail setBackgroundImage:[UIImage imageNamed:@"mail_iphone"] forState:UIControlStateNormal];
    
    UIBarButtonItem* button = [[UIBarButtonItem alloc] initWithCustomView:buttonMail];
    
    self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:button, nil];
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
        [self.ImagenMascota setAnimationRepeatCount:2];
        [self.ImagenMascota setAnimationDuration:0.5];
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

//Realizacion del Weackly


-(IBAction)senderMail:(id)sender
{

    NSString * body = @ "Buenas! Soy <Nombre_de_mi _mascota>, cómo va? Quería comentarte que estuve usando la App <Nombre_de_la_app> para comerme todo y está genial. Bajatela YA!!   Saludos!";
    
    //creacion del msj
    MFMailComposeViewController * composer = [[MFMailComposeViewController alloc]init ];
    
    composer.mailComposeDelegate= self;
    [composer setSubject:@"Que app copada"];
    [composer setMessageBody:body isHTML:NO];
    
    
    //crear present
    [self presentViewController:composer animated:YES completion:nil];

    
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    UIAlertView * alerta = nil;
    switch (result) {
        case MFMailComposeResultCancelled:
            
           alerta = [[UIAlertView alloc] initWithTitle:@"Mail" message:@"El usuario apreto el boton Cancelar" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:@"Cancelar", nil];
            [alerta show];
            break;
        case MFMailComposeResultSaved:
            alerta = [[UIAlertView alloc] initWithTitle:@"Mail" message:@"El usuario apreto el boton guardar" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:@"Cancelar", nil];
            [alerta show];
            break;
            case MFMailComposeResultFailed:
            alerta = [[UIAlertView alloc] initWithTitle:@"Mail" message:@"Hubo un problema" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:@"Cancelar", nil];
            [alerta show];
            break;
            case MFMailComposeResultSent:
            alerta = [[UIAlertView alloc] initWithTitle:@"Mail" message:@"El usuario Envio el mensaje" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:@"Cancelar", nil];
            [alerta show];
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.timer invalidate];
}


@end
