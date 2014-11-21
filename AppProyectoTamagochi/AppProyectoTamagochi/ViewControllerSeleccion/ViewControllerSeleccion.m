//
//  ViewControllerSeleccion.m
//  AppProyectoTamagochi
//
//  Created by Analia on 18/11/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import "ViewControllerSeleccion.h"
#import "ViewControllerElegida.h"
@interface ViewControllerSeleccion ()

@property (weak, nonatomic) IBOutlet UILabel *LabelTitulo;
@property (weak, nonatomic) IBOutlet UIButton *ButtonGato;
@property (weak, nonatomic) IBOutlet UIButton *ButtonLeon;
@property (weak, nonatomic) IBOutlet UIButton *Buttonjirafa;
@property (weak, nonatomic) IBOutlet UIButton *ButtonCiervo;

@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *ImagenElegida;
@property (weak, nonatomic) IBOutlet UIButton *Continuar;

@end

@implementation ViewControllerSeleccion

- (void)viewDidLoad {
    //lo que carga cuando cuando arranca
    [super viewDidLoad];
    self.LabelTitulo.text=[NSString stringWithFormat: @"El nombre de tu mascota es %@",self.Nombremascota];
    self.ScrollView.contentSize = CGSizeMake(580, 129) ;
    [self setTitle:@"Seleccione su mascota"];
    
    self.ImagenElegida.image = [UIImage imageNamed:@"gato_comiendo_1"];
    
    // Do any additional setup after loading the view from its nib.
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
    
    ViewControllerElegida * controlelegida = [[ViewControllerElegida alloc] initWithNibName:@"ViewControllerElegida" bundle:[NSBundle mainBundle] nombre:self.Nombremascota imagen:self.ImagenElegida];
    [self.navigationController pushViewController:controlelegida animated:YES];
    
}

-(IBAction)ButtonAnimal:(UIButton *)sender
{
    switch (sender.tag)
    
    {
        case 0:
            
            self.ImagenElegida.image = [UIImage imageNamed:@"gato_comiendo_1"];
            
            break;
            
        case 1:
            
            self.ImagenElegida.image = [UIImage imageNamed:@"leon_comiendo_1"];
            
            break;
        case 2:
            self.ImagenElegida.image = [UIImage imageNamed:@"jirafa_comiendo_1"];

            break;
            
        default:
            
          self.ImagenElegida.image = [UIImage imageNamed:@"ciervo_comiendo_1"];
            
            break;
            
    }
    
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
