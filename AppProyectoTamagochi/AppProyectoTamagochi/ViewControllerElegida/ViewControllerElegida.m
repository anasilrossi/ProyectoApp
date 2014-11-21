//
//  ViewControllerElegida.m
//  AppProyectoTamagochi
//
//  Created by Analia on 19/11/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import "ViewControllerElegida.h"
#import "ViewControllerComida.h"
#import "Animales.h"

@interface ViewControllerElegida ()
@property (weak, nonatomic) IBOutlet UIImageView *ImagenMascota;
@property (weak, nonatomic) IBOutlet UILabel *NombreMascota;
@property (weak, nonatomic) IBOutlet UIButton *alimentar;
@property (weak, nonatomic) IBOutlet UIImageView *ImagenComida;
@property (nonatomic) CGPoint tapLocation;
@property (nonatomic) CGPoint locacionImagen;
@property (nonatomic) int tagImagen;
@property (nonatomic,strong) Animales * animal;
@property (weak, nonatomic) IBOutlet UIProgressView *Progressbar;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *gestoTap;

@end

@implementation ViewControllerElegida

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //self.tagImagen = self.animal.tagImagen;
    //self.animal = [[Animales alloc ]initWithTag:self.tagImagen];
    self.ImagenMascota.image = [UIImage imageNamed:self.animal.imagenAnimal];
    self.locacionImagen = self.ImagenComida.center;
    self.NombreMascota.text =self.Nombremascota;
    [self setTitle:@"Energia de su mascota"];
    
    UITapGestureRecognizer * recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(darDeComer:)];
    //Le asignamos el delegate
    recognizer.delegate = self;
    //Lo agregamos a la Vista donde debe detectar el tap
    [self.view addGestureRecognizer:recognizer];

    
}
-(void)DevolverComida:(Comidas*)comidas
{
    [self.ImagenComida setImage:[UIImage imageNamed:comidas.imagencomida]];
    [self.ImagenComida setHidden:NO];
    [self.ImagenComida setCenter:self.locacionImagen];
    //CGRect posicionOriginal = self.I
}

-(IBAction)darDeComer:(UITapGestureRecognizer*)sender
    {
         self.tapLocation = [sender locationInView: self.view];
       
        [UIView animateWithDuration:1.0
                              delay:0.0
                            options:UIViewAnimationOptionAllowAnimatedContent
                         animations:^{ [self.ImagenComida setCenter:_tapLocation];}
                         completion:^(BOOL finished) {
                             UIView * vista = [self.view hitTest:_tapLocation withEvent:nil];
                             if ([vista isEqual:self.ImagenMascota]) {
                                 [self.ImagenComida setHidden:YES];
                                 
                             }
                         }];
     
      
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil nombre:(NSString *)nombredemascota imagen:(Animales * )imagenmascota
{
    //Sobreescribo el metodo para pasar el nombre de la mascota y la imagen
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self!=nil) {
        self.Nombremascota = nombredemascota;
        [self.ImagenMascota setImage:[UIImage imageNamed:self.animal.imagenAnimal]];
        self.animal= imagenmascota;
    }
    return self;
}
- (IBAction)AlimentarMascota:(id)sender {
    
   
    ViewControllerComida * controlcomida = [[ViewControllerComida alloc]initWithNibName:@"ViewControllerComida" bundle:[NSBundle mainBundle] ];
     [controlcomida setDelegate:self];
    
    [self.navigationController pushViewController:controlcomida animated:YES];
    
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
