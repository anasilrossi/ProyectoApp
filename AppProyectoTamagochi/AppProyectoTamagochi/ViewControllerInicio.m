//
//  ViewControllerInicio.m
//  AppProyectoTamagochi
//
//  Created by Analia on 18/11/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import "ViewControllerInicio.h"
#import "ViewControllerSeleccion.h"

@interface ViewControllerInicio ()
@property (weak, nonatomic) IBOutlet UILabel *LabelBienvenida;
@property (weak, nonatomic) IBOutlet UILabel *LabelMascota;
@property (weak, nonatomic) IBOutlet UITextField *TextFieldNombreMascota;
@property (weak, nonatomic) IBOutlet UIButton *ButtonContinuar1;

@end

@implementation ViewControllerInicio

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)ContinuarGuardarNombre:(id)sender {

    NSString * NombreMascota =[[NSString alloc]initWithFormat:@"%@",self.TextFieldNombreMascota.text];
    NSLog(@"%@",NombreMascota);
    
    ViewControllerSeleccion * controlselecion =[[ViewControllerSeleccion alloc] initWithNibName:@"ViewControllerSeleccion" bundle:[NSBundle mainBundle] nombre:NombreMascota];
    [self.navigationController pushViewController:controlselecion animated:YES];

    
    
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
