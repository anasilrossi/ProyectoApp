//
//  ViewControllerInicio.m
//  AppProyectoTamagochi
//
//  Created by Analia on 18/11/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import "ViewControllerInicio.h"
#import "ViewControllerSeleccion.h"
#import "Animales.h"
#import "NSString+CustonString.h"
#import "NetworkManager.h"

@interface ViewControllerInicio ()
//propiedades
@property (weak, nonatomic) IBOutlet UILabel *LabelBienvenida;
@property (weak, nonatomic) IBOutlet UILabel *LabelMascota;
@property (weak, nonatomic) IBOutlet UITextField *TextFieldNombreMascota;
@property (weak, nonatomic) IBOutlet UIButton *ButtonContinuar1;
@property (weak, nonatomic) IBOutlet UIButton *bPruebaRed;
@end

@implementation ViewControllerInicio

//Sacar el teclado cuanto apretas Return o cualquier parte de la pantalla
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(bool) textFieldShouldReturn:(UITextField *)textField
{
    BOOL retorno = [self.view endEditing:YES];
    return retorno;
}

- (void)viewDidLoad {
    //Lo que tiene que hacer a la hora de cargar la vista
    [super viewDidLoad];
    [self setTitle:@"Bienvenido"];
    //[self.TextFieldNombreMascota setDelegate:self];
        // Do any additional setup after loading the view from its nib.
}

-(void)viewDidDisappear:(BOOL)animated
{
    //lo que hace cuando termina una vista
    [self setTitle:@""];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ContinuarGuardarNombre:(id)sender {
    //boton
    NSString * NombreMascota =[[NSString alloc]initWithString:self.TextFieldNombreMascota.text];
    [[Animales sharedInstance] setAnimalNombre:NombreMascota ];
  
    //consultas
    
    if ([[self.TextFieldNombreMascota text] EsVacio ])
    {
        //validamos si esta vacio
        UIAlertView * alerta = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No ingresaste ningun nombre" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:@"Cancelar", nil];
        [alerta show];
    }
    else if ([[self.TextFieldNombreMascota text] MayorCuatroLetras ])
    {
        //valida la longitud -4
        UIAlertView * alerta = [[UIAlertView alloc] initWithTitle:@"Error" message:@"El nombre tiene que tener mas de 4 letras" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:@"Cancelar", nil];
        [alerta show];
    }
    else if ([[self.TextFieldNombreMascota text] Sololetras])
    {
        //valida que sean solo letras
        UIAlertView * alerta = [[UIAlertView alloc] initWithTitle:@"Error" message:@"el nombre debe tener solo Letras" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:@"Cancelar", nil];
        [alerta show];
    }
    else
    {
      
        NSLog(@"%@",self.TextFieldNombreMascota.text);
        
        ViewControllerSeleccion * controlselecion =[[ViewControllerSeleccion alloc] initWithNibName:@"ViewControllerSeleccion" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:controlselecion animated:YES];
    }
    
}

- (IBAction)accesoNetwork:(id)sender{
    
    [[NetworkManager sharedInstance]GET:(@"/key/value/one/two")
                            parameters:nil
                                success:^(NSURLSessionDataTask *task, id responseObject)
                                    {
                                            NSLog(@"JSON: %@", responseObject);
                                    }
                                failure:^(NSURLSessionDataTask *task, NSError *error) {
                                    NSLog(@"Error: %@", error);}
                                    ];
}



@end
