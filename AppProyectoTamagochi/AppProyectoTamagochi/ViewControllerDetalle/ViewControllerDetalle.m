//
//  ViewControllerDetalle.m
//  AppProyectoTamagochi
//
//  Created by Analia on 12/4/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import "ViewControllerDetalle.h"
#import "Animales.h"
#import "CargarImagenes.h"
@interface ViewControllerDetalle ()
@property (weak, nonatomic) IBOutlet UILabel *nombeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imagenPet;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UILabel *nivelLabel;
@property (nonatomic,strong)Animales  *animalito;

@end

@implementation ViewControllerDetalle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.animalito = [[Animales alloc] init];
    self.animalito =[[Animales sharedInstance]DarMascota];
    self.nombeLabel.text = self.animalito.animalNombre;
    [self.imagenPet setImage:[CargarImagenes Cargarimagen:[self.animalito.tipoAnimal intValue]]];
    int  valor =[self.animalito.energia intValue];
    valor = valor /100;
    [self.progress setProgress:valor animated:YES];
    self.nivelLabel.text =[NSString stringWithFormat:@"Nivel:%@",self.animalito.nivel];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
