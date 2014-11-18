//
//  ViewControllerInicio.m
//  AppProyectoTamagochi
//
//  Created by Analia on 18/11/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import "ViewControllerInicio.h"

@interface ViewControllerInicio ()
@property (weak, nonatomic) IBOutlet UILabel *LabelBienvenida;
@property (weak, nonatomic) IBOutlet UILabel *LabelMascota;
@property (weak, nonatomic) IBOutlet UITextField *TextFieldNombreMascota;
@property (weak, nonatomic) IBOutlet UIButton *ButtonContinuar1;
@property (strong,nonatomic) NSString * Nombremascota;
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
    
    
}
- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil nombre:(NSString *) nombredemascota
    {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
        if (self!=nil) {
            self.Nombremascota = nombredemascota;
        }
    return self;
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
