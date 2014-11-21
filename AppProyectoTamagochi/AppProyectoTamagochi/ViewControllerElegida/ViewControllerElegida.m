//
//  ViewControllerElegida.m
//  AppProyectoTamagochi
//
//  Created by Analia on 19/11/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import "ViewControllerElegida.h"
#import "ViewControllerComida.h"

@interface ViewControllerElegida ()
@property (weak, nonatomic) IBOutlet UIImageView *ImagenMascota;
@property (weak, nonatomic) IBOutlet UILabel *NombreMascota;
@property (weak, nonatomic) IBOutlet UIButton *alimentar;
@property (weak, nonatomic) IBOutlet UIImageView *ImagenComida;

@property (weak, nonatomic) IBOutlet UIProgressView *Progressbar;
@end

@implementation ViewControllerElegida

- (void)viewDidLoad {
    [super viewDidLoad];
  self.ImagenMascota.image = self.Imagen.image;
  
    self.NombreMascota.text =self.Nombremascota;
    [self setTitle:@"Energia de su mascota"];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)DevolverComida:(Comidas*)comidas
{
    [self.ImagenComida setImage:[UIImage imageNamed:comidas.imagencomida]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil nombre:(NSString *)nombredemascota imagen:(UIImageView *)imagenmascota
{
    //Sobreescribo el metodo para pasar el nombre de la mascota y la imagen
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self!=nil) {
        self.Nombremascota = nombredemascota;
        self.Imagen = imagenmascota;
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
