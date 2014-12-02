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
#import "Comida.h"
#import "NSTimer+TimerSafeInvalidate.h"
#import "ViewControllerRanking.h"


@interface ViewControllerElegida ()
@property (weak, nonatomic) IBOutlet UIImageView *ImagenMascota;
@property (weak, nonatomic) IBOutlet UILabel *NombreMascota;
@property (weak, nonatomic) IBOutlet UIButton *alimentar;
@property (weak, nonatomic) IBOutlet UIImageView *ImagenComida;
@property (weak, nonatomic) IBOutlet UIProgressView *Progressbar;
@property (weak, nonatomic) IBOutlet UIButton *bEjercitar;
@property (strong,nonatomic) NSTimer * timer;
@property (nonatomic) BOOL estadoEjercicio;
@property (nonatomic) CGPoint tapLocation;
@property (nonatomic) CGPoint locacionImagen;
@property (assign,nonatomic) int valor;
@property (strong,nonatomic) Comidas * comidaActual;
@property (nonatomic, retain) CLLocation *  locacion  ;
@property (nonatomic, retain) CLLocationManager * locationManager;
@property (weak, nonatomic) IBOutlet UIButton *PRUEBA;
@property (weak, nonatomic) IBOutlet UIButton *bRanking;


@end

@implementation ViewControllerElegida

- (void)viewDidLoad {
    [super viewDidLoad];
    [Animales sharedInstance];
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
    self.ImagenComida.image = nil;
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
    
    float valor =[[Animales sharedInstance] devolverEnergia];
    valor = valor / 100;
    [self.Progressbar setProgress:valor animated:YES];
    
   
}

-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refrescarNivel)
                                                 name:@"REFRESCAR_NIVEL"
                                               object:nil];
     [self locacionMascota];
}

-(void)refrescarNivel
{
   // int valor =[[Animales sharedInstance] devolverNivel];
    [self pushLocal];
    /*
    NSString * mensaje = [NSString stringWithFormat: @"Su mascota llego a nivel %d",valor];
    UIAlertView * alerta =[[UIAlertView alloc] initWithTitle:@"Mascota Virtual" message:mensaje delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
    [alerta show];
     */
}

-(void)pushLocal
{
    UILocalNotification *localNotification =[[UILocalNotification alloc]init];
    
    // Notification details
    localNotification.fireDate = [[NSDate alloc]init];
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.repeatCalendar = [NSCalendar currentCalendar];
    localNotification.alertBody = @"Nivel";
    localNotification.alertAction = @"Subio Nivel";
    localNotification.userInfo = [[Animales sharedInstance] devolverMascota];
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.applicationIconBadgeNumber = 1;
    
    // Schedule the notification
    [[UIApplication sharedApplication]scheduleLocalNotification:localNotification];
}

-(void)DevolverComida:(Comidas*)comidas
{
    //devuelve la comida en la pantalla
    self.comidaActual = comidas;
    [self.ImagenComida setImage:[UIImage imageNamed:self.comidaActual.imagencomida]];
    [self.ImagenComida setHidden:NO];
    [self.ImagenComida setCenter:self.locacionImagen];
    [self.ImagenMascota setImage:[CargarImagenes Cargarimagen:self.animal]];
    
}

-(IBAction)darDeComer:(UITapGestureRecognizer*)sender
    {
        if (self.ImagenComida.image != nil)
        {
        [self.ImagenMascota setImage:[CargarImagenes Cargarimagen:self.animal]];
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
                                 self.ImagenComida.image= nil;
                                 [self.ImagenComida startAnimating];
                                 }
                         }];
        [self.ImagenMascota setAnimationImages:[CargarImagenes Cargararray:self.animal estado:self.estado]];

        int valor = [[Animales sharedInstance]devolverEnergia];
        if (valor !=100) {
            [self.ImagenMascota setAnimationDuration:0.5];
            [self.ImagenMascota setAnimationRepeatCount:2];
            [self.ImagenMascota startAnimating];
            
            int valor =[[Animales sharedInstance] masEnergia:self.comidaActual.valor];
          
            [self.Progressbar setProgress:valor/100.0f animated:YES];
        }
        else
        {
            UIAlertView * alerta = [[UIAlertView alloc]initWithTitle:@"" message:@"Su mascota esta llena,Dele de comer mas tarde" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:@"Cancelar", nil];
            [alerta show];
        }
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
        [self.ImagenMascota setAnimationRepeatCount:20];
        [self.ImagenMascota startAnimating];
        [self.bEjercitar setTitle:@"Parar" forState:UIControlStateNormal ];
        [self disminuirEnergia];
        self.estadoEjercicio=NO;
    }
    else
    {
        [self.ImagenMascota stopAnimating];
        [self.timer invalidartimer];
        [self.bEjercitar setTitle:@"Ejercitar" forState:UIControlStateNormal ];
        self.estadoEjercicio=YES;
    }
}

-(void) disminuirEnergia
{
    [[Animales sharedInstance] aumentarExperiencia:15];
   
    if ([[Animales sharedInstance] puedeejercitar]) {
        [[Animales sharedInstance] menosEnergia];
        float valor =[[Animales sharedInstance] devolverEnergia ];
              valor = valor / 100;
        [self.Progressbar setProgress:valor animated:YES];
        

    }
    else{
        [self.timer invalidartimer];
        [self.ImagenMascota stopAnimating];
        [self.bEjercitar setTitle:@"Ejercitar" forState:UIControlStateNormal ];
        self.estadoEjercicio=YES;
        [self exauto];
        }
}

-(void) exauto
{
    self.estado = animal_exhauto;
    [self.ImagenMascota stopAnimating ];
    [self.ImagenMascota setAnimationImages:[CargarImagenes Cargararray:self.animal estado:self.estado]];
    [self.ImagenMascota setAnimationDuration:1];
    [self.ImagenMascota setAnimationRepeatCount:1];
    [self.ImagenMascota setImage:[CargarImagenes CargarimagenCansado:self.animal]];
    [self.ImagenMascota startAnimating];
    
}


- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
   
    NSDate* eventDate = newLocation.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 120.0) // Updates de menos de 2 min.
    {
        [self.locationManager stopUpdatingLocation]; // Detener el tracking y utilizar la location
        self.locacion = newLocation;
        
        [[Animales sharedInstance]setAltitude: self.locacion.coordinate.latitude];
        [[Animales sharedInstance]setLongitud: self.locacion.coordinate.longitude];
        [[Animales sharedInstance]update];
    }
}

-(void)locacionMascota
{
    if (nil == self.locationManager)
    self.locationManager =[[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer; // Presición
    self.locationManager.distanceFilter = 10; // Distancia mínima de updates
    [self.locationManager startUpdatingLocation];
    
}



//Realizacion del WeeklyTwo


- (IBAction)ranking_pet:(id)sender {
    
    ViewControllerRanking * controlranking = [[ViewControllerRanking alloc]initWithNibName:@"ViewControllerRanking" bundle:[NSBundle mainBundle] ];
    [self.navigationController pushViewController:controlranking animated:YES];
    
}

//Realizacion del WeeklyOne


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
    [self.timer invalidartimer];
}


@end
