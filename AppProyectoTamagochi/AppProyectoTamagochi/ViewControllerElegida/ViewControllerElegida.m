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
#import "ViewControllerContacto.h"
#import "TNetworkService.h"
#import <AudioToolbox/AudioToolbox.h>


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
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGPoint locacionImagen;
@property (assign,nonatomic) int valor;
@property (strong,nonatomic) Comidas * comidaActual;
@property (nonatomic, retain) CLLocation *  locacion  ;
@property (nonatomic, retain) CLLocationManager * locationManager;
@property (weak, nonatomic) IBOutlet UIButton *PRUEBA;
@property (weak, nonatomic) IBOutlet UIButton *bRanking;
@property (weak, nonatomic) IBOutlet UILabel *nivelLabel;
@property (weak, nonatomic) IBOutlet UILabel *experienciaLabel;
@property (nonatomic,strong) TNetworkService * service;
@property(nonatomic,strong) NSTimer *tiempoSucio;
@property (weak, nonatomic) IBOutlet UIImageView *suciedadImagen;
@property (weak, nonatomic) IBOutlet UIImageView *suciedad2Imagen;
@property (weak, nonatomic) IBOutlet UIImageView *jabonButton;

@end

@implementation ViewControllerElegida

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Energia de su mascota"];
    
    UITapGestureRecognizer * recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(darDeComer:)];
    //Le asignamos el delegate
    recognizer.delegate = self;
    //Lo agregamos a la Vista donde debe detectar el tap
    [self.view addGestureRecognizer:recognizer];
    
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(limpiar:)];
    
    panRecognizer.delegate= self;

    [self.view addGestureRecognizer:panRecognizer];


    
    self.ImagenComida.image = nil;
    self.service =[[TNetworkService alloc]init];
    [self.service getOneEvents:[self getSucces] failure:[self getFailure] codigo:code];
    self.tiempoSucio= [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(cambiarEstado) userInfo:nil repeats:YES];
    self.origin = self.jabonButton.center;
}

-(Success)getSucces
{
    return ^(NSMutableArray * array) {
        
        ViewControllerElegida * __weak weakself = self;
        [Animales sharedInstance];
        weakself.estadoEjercicio=YES;
        weakself.locacionImagen = weakself.ImagenComida.center;
        weakself.NombreMascota.text =[array valueForKey:@"name"];;
        weakself.animal=[array valueForKey:@"pet_type"];
        weakself.ImagenMascota.image = [CargarImagenes Cargarimagen:[weakself.animal intValue]];
        int valor =((NSNumber *)[array valueForKey:@"energia"]).intValue;
        [weakself.Progressbar setProgress:valor/100.0f animated:YES];
        weakself.nivelLabel.text=[NSString stringWithFormat:@"Nivel:%@",[array valueForKey:@"level"]];
        weakself.experienciaLabel.text=[NSString stringWithFormat:@"Experiencia:%@",[array valueForKey:@"experience"]];

        
        self.service=nil;
    };
}

-(Failure)getFailure
{
    return ^(NSError *error) {
        NSLog(@"Error: %@", error);
        self.service=nil;
    };
}

-(void)cambiarEstado
{
    if (animal_limpio) {
        [UIView animateWithDuration:12
                              delay:0.0
                            options:UIViewAnimationOptionAllowAnimatedContent
                         animations:^{ self.suciedadImagen.alpha = 1;
                                       self.suciedad2Imagen.alpha=1;}
                         completion:^(BOOL finished) {
                             [[Animales sharedInstance] setTipoAnimal:[NSNumber numberWithInt:animal_sucio]];
                             NSLog(@"sucioooo");
                         }];
    }

}

-(IBAction)limpiar:(UIPanGestureRecognizer *) recognizer
{
    
    self.origin = [recognizer locationInView:self.view];
    UIView * vistaImagen = [self.view hitTest:self.origin withEvent:nil];
   // CGPoint centroImagen = self.suciedadImagen.center;
    CGPoint centroImagen2 = self.suciedad2Imagen.center;
    if ([self.suciedadImagen isEqual:vistaImagen]) {
    [UIView animateWithDuration:12
                          delay:0.0
                        options:UIViewAnimationOptionAllowAnimatedContent
                     animations:^{ [self.jabonButton setCenter:self.origin];}
                     completion:^(BOOL finished) {
                             self.suciedadImagen.alpha=0;
                         self.suciedadImagen.hidden= YES;}
     
                     ];

    }
    else if(CGPointEqualToPoint (centroImagen2 ,self.origin))
    {
        [UIView animateWithDuration:12
                              delay:0.0
                            options:UIViewAnimationOptionAllowAnimatedContent
                         animations:^{ [self.jabonButton setCenter:self.origin];}
                         completion:^(BOOL finished) {
                             self.suciedad2Imagen.alpha=0;}
         
         ];

    }
    else
    {
        [self.jabonButton setCenter:self.origin];
    }
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    UIButton *buttonMail = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    
    [buttonMail addTarget:self action:@selector(senderMail:) forControlEvents:UIControlEventTouchUpInside];
    
    [buttonMail setBackgroundImage:[UIImage imageNamed:@"mail_iphone"] forState:UIControlStateNormal];
    

    UIBarButtonItem* button = [[UIBarButtonItem alloc] initWithCustomView:buttonMail];
    
    self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:button, nil];
    
    
   
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refrescarNivel)
                                                 name:@"PUSHLOCAL"
                                               object:nil];
     [self locacionMascota];
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
    [self.ImagenMascota setImage:[CargarImagenes Cargarimagen:[self.animal intValue]]];
    
}

-(IBAction)darDeComer:(UITapGestureRecognizer*)sender
    {
        if (self.ImagenComida.image != nil)
        {
        [self.ImagenMascota setImage:[CargarImagenes Cargarimagen:[self.animal intValue]]];
         self.tapLocation = [sender locationInView: self.view];
        self.estado  = [NSNumber numberWithInt: animal_comiendo];
            
            //********************************************************
            //Animacion de llevar la comida
            //////////////////////////////////////////////////////////
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
            //********************************************************
            //Animacion mascota comiendo
            //////////////////////////////////////////////////////////
        [self.ImagenMascota setAnimationImages:[CargarImagenes Cargararray:[self.animal intValue] estado:[self.estado intValue]]];

       int  valor = [[Animales sharedInstance]devolverEnergia];
        if (valor  !=100) {
            [self.ImagenMascota setAnimationDuration:0.5];
            [self.ImagenMascota setAnimationRepeatCount:2];
            [self.ImagenMascota startAnimating];
            
            //********************************************************
            //Sonido De comer
            //////////////////////////////////////////////////////////
            NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"Eating-Sound" ofType:@"wav"];
            SystemSoundID soundID;
            AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath], &soundID);
            AudioServicesPlaySystemSound (soundID);
            
            //********************************************************
            //Aumentar Progressbar
            //////////////////////////////////////////////////////////
            NSNumber * valor =[[Animales sharedInstance] masEnergia:self.comidaActual.valor];
          
            [self.Progressbar setProgress:[valor intValue]/100.0f animated:YES];
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
        self.estado = [NSNumber numberWithInt:animal_ejercitando];
        [self.ImagenMascota setAnimationImages:[CargarImagenes Cargararray:[self.animal intValue] estado:[self.estado intValue]]];
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
        int  valor =[[Animales sharedInstance] devolverEnergia] ;
        [self.Progressbar setProgress:valor/100.0f animated:YES];
         self.nivelLabel.text=[NSString stringWithFormat:@"Nivel:%@",[[Animales sharedInstance]devolverNivel]];
         self.experienciaLabel.text=[NSString stringWithFormat:@"Experiencia:%@",[[Animales sharedInstance]devolverExperiencia]];
        

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
    self.estado = [NSNumber numberWithInt:animal_exhauto];
    [self.ImagenMascota stopAnimating ];
    [self.ImagenMascota setAnimationImages:[CargarImagenes Cargararray:[self.animal intValue] estado:[self.estado intValue]]];
    [self.ImagenMascota setAnimationDuration:1];
    [self.ImagenMascota setAnimationRepeatCount:1];
    [self.ImagenMascota setImage:[CargarImagenes CargarimagenCansado:[self.animal intValue]]];
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
        
        [[Animales sharedInstance]setAltitude:[NSNumber numberWithDouble: self.locacion.coordinate.latitude ]];
        [[Animales sharedInstance]setLongitud:[NSNumber numberWithDouble: self.locacion.coordinate.longitude]];
        [[Animales sharedInstance]updates];
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
    ViewControllerContacto * controlcontac = [[ViewControllerContacto alloc]initWithNibName:@"ViewControllerContacto" bundle:[NSBundle mainBundle] ];
    [self.navigationController pushViewController:controlcontac animated:YES];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.timer invalidartimer];
    [self.tiempoSucio invalidartimer];
     [super viewWillDisappear:YES];
    
}


@end
