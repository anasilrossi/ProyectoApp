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
#import "Animales.h"

@interface ViewControllerElegida ()
@property (weak, nonatomic) IBOutlet UIImageView *ImagenMascota;
@property (weak, nonatomic) IBOutlet UILabel *NombreMascota;
@property (weak, nonatomic) IBOutlet UIButton *alimentar;
@property (weak, nonatomic) IBOutlet UIImageView *ImagenComida;
@property (weak, nonatomic) IBOutlet UIProgressView *Progressbar;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *gestoTap;
@property (strong,nonatomic) NSTimer * timer;
@property (weak, nonatomic) IBOutlet UIButton *bEjercitar;
@property (nonatomic) BOOL estadoEjercicio;
@property (nonatomic) CGPoint tapLocation;
@property (nonatomic) CGPoint locacionImagen;
@end

@implementation ViewControllerElegida

- (void)viewDidLoad {
    [super viewDidLoad];
    self.estadoEjercicio=YES;
    self.locacionImagen = self.ImagenComida.center;
    self.Nombremascota = [[Animales sharedInstance] animalNombre];
    self.NombreMascota.text =self.Nombremascota;
    [self setTitle:@"Energia de su mascota"];
    
    UITapGestureRecognizer * recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(darDeComer:)];
    //Le asignamos el delegate
    recognizer.delegate = self;
    //Lo agregamos a la Vista donde debe detectar el tap
    [self.view addGestureRecognizer:recognizer];
    self.animal=[[Animales sharedInstance] tipoAnimal];
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
          self.estado = animal_comiendo;
        [UIView animateWithDuration:0.2
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
        int valor = [[Animales sharedInstance]devolverEnergia];
        if (valor !=100) {
            
            [self.ImagenMascota setAnimationDuration:0.5];
            [self.ImagenMascota setAnimationRepeatCount:2];
            [self.ImagenMascota startAnimating];
            
            float valor =[[Animales sharedInstance] masEnergia ];
            valor = valor / 100;
            [self.Progressbar setProgress:valor animated:YES];
        }
        else
        {
            UIAlertView * alerta = [[UIAlertView alloc]initWithTitle:@"" message:@"Su mascota esta llena,Dele de comer mas tarde" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:@"Cancelar", nil];
            [alerta show];
        }
        
        
        
}


- (IBAction)AlimentarMascota:(id)sender {

    ViewControllerComida * controlcomida = [[ViewControllerComida alloc]initWithNibName:@"ViewControllerComida" bundle:[NSBundle mainBundle] ];
     [controlcomida setDelegate:self];
    
    [self.navigationController pushViewController:controlcomida animated:YES];
    
}


//Ejercitar!
- (IBAction)hacerEjercicio:(id)sender {
    
    if (self.estadoEjercicio) {
        
        //tiempo para ejercitar
        self.timer= [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(disminuirEnergia) userInfo:nil repeats:YES];
        
         self.estado = animal_ejercitando;
        
        [self.ImagenMascota setAnimationImages:[CargarImagenes Cargararray:self.animal estado:self.estado]];
        [self.ImagenMascota setAnimationDuration:0.5];
        [self.ImagenMascota startAnimating];
        [self.bEjercitar setTitle:@"Parar" forState:UIControlStateNormal ];
        [self disminuirEnergia];
        self.estadoEjercicio=NO;
       

    }
    else
    {
        [self.ImagenMascota stopAnimating];
        if(self.timer && [self.timer isValid]) { [self.timer invalidate];
            self.timer = nil; }
        [self.bEjercitar setTitle:@"Ejercitar" forState:UIControlStateNormal ];
        self.estadoEjercicio=YES;
    }
}

-(void) disminuirEnergia
{
    if ([[Animales sharedInstance] puedeejercitar]) {
        float valor =[[Animales sharedInstance] devolverEnergia ];
              valor = valor / 100;
        [self.Progressbar setProgress:valor animated:YES];
   
     [[Animales sharedInstance] menosEnergia];
    }
    else{
        if(self.timer && [self.timer isValid]) { [self.timer invalidate];
            self.timer = nil; }
        [self.ImagenMascota stopAnimating];
        [self.bEjercitar setTitle:@"Ejercitar" forState:UIControlStateNormal ];
        
        UIAlertView * alerta = [[UIAlertView alloc]initWithTitle:@"" message:@"Su mascota se murio" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:@"Cancelar", nil];
        [alerta show];
        
    }

}

-(void) energiaMaxima
{
    [[Animales sharedInstance] masEnergia];
}

//Realizacion del Weackly


-(IBAction)senderMail:(id)sender
{

     NSString * const body = @ "Buenas! Soy <Nombre_de_mi _mascota>, cómo va? Quería comentarte que estuve usando la App <Nombre_de_la_app> para comerme todo y está genial. Bajatela YA!!   Saludos!";
    
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
    if(self.timer && [self.timer isValid]) { [self.timer invalidate];
        self.timer = nil; }
}


@end
