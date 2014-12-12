//
//  ViewControllerContacto.m
//  AppProyectoTamagochi
//
//  Created by Analia on 12/5/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import "ViewControllerContacto.h"
#import "Contact.h"
#import "Animales.h"


@interface ViewControllerContacto ()

@property (weak, nonatomic) IBOutlet UITableView *tabla_contacto;
@property (strong,nonatomic) NSNumber * cantidad;
@property (strong,nonatomic) Contact * obj;
@property (strong,nonatomic)NSMutableArray * arrayContactos;
@property (assign,nonatomic)ABAddressBookRef addressBook ;
@end

@implementation ViewControllerContacto



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Ranking de Mascotas"];
    
    [self.tabla_contacto registerNib:[UINib nibWithNibName:@"CellCustomContacto"
                                               bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"CellCustomContacto"] ;
   [self permisosContactos];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)permisosContactos
{
    // Solicitamos al usuario acceso a los contactos (no funciona en el Simulador)
    CFErrorRef* error ;
    self.addressBook = ABAddressBookCreateWithOptions(NULL, error);
    
    // Comprobamos el estado de permisos de usuario
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
        ABAddressBookRequestAccessWithCompletion(self.addressBook, ^(bool granted, CFErrorRef error) {
            // Es la primera vez que accedemos a dichos contactos
            NSLog(@"Primer vez");
            [self obtenerContactos];
        });
        
    }
    else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
        // El usuario ya nos había autorizado previamente el acceso
        NSLog(@"Segundas veces");
        [self obtenerContactos];
    }
    else if (error)
    {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"No se pudo traer los contactos!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
    else {
        // El usuario ya nos había denegado previamente el acceso
        NSLog(@"Permiso denegado");
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Permiso denegado!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
    
}

-(void)obtenerContactos
{
    
    self.arrayContactos = [[NSMutableArray alloc]init];
    
    // Obtenemos todos los contactos del usuario en base a la referencia obtenida
    CFArrayRef all = ABAddressBookCopyArrayOfAllPeople(self.addressBook);
    
    // Obtenemos el total de contactos encontrados
    CFIndex n = ABAddressBookGetPersonCount(self.addressBook);
    
    self.cantidad= [NSNumber numberWithLong:n];
    
    
    // Recorremos todos los contactos
    for( int i = 0 ; i < n ; i++ )
    {
        // Obtenemos el contacto
        ABRecordRef ref = CFArrayGetValueAtIndex(all, i);
        // Obtenemos la info del contacto
        
        ABMultiValueRef phones = ABRecordCopyValue(ref, kABPersonPhoneProperty);
        NSString * phoneNumber = (__bridge NSString *) ABMultiValueCopyValueAtIndex(phones, 0);
        
        ABMultiValueRef emailProperty = ABRecordCopyValue(ref, kABPersonEmailProperty);
        NSString * emails = (__bridge NSString*)ABMultiValueCopyValueAtIndex(emailProperty,0);
        
        if(phoneNumber != nil || emails != nil)
        {
            
            self.obj = [[Contact alloc]init];
            self.obj.name = (__bridge NSString *)ABRecordCopyValue(ref, kABPersonFirstNameProperty);;
            self.obj.phone = phoneNumber;
            self.obj.email = emails;
            [self.arrayContactos addObject:self.obj];
        }
       
    }
     [self.tabla_contacto reloadData];
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.cantidad intValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"CellCustomContacto";
    //Intentamos recuperar una celda ya creada.
     CellCustomContacto * cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (!cell) {
        //Si la celda no existe, la creamos.
        cell=[[CellCustomContacto alloc]init];
    }
    cell.delegate = self;
    [cell configurarCelda:[self.arrayContactos objectAtIndex:indexPath.row]];
    return cell;
}


- (void)llamadas:(NSString *)numero
{
    if (self.puedeLlamar) {
        NSString * phoneNumber = self.obj.phone;
        NSURL *cleanPhoneNumber = [NSURL URLWithString:[NSString stringWithFormat:@"%@", phoneNumber]];
        [[UIApplication sharedApplication] openURL:cleanPhoneNumber];

    }
    else
    {
       UIAlertView * alerta = [[UIAlertView alloc]initWithTitle:@"Tel" message:@"Comprate un device, con este simulador barato no podes hacer llamadas." delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:@"Cancelar", nil];[alerta show];
    }
}

-(BOOL)puedeLlamar {
    
    return [[UIApplication sharedApplication]
            
            canOpenURL:[NSURL URLWithString:@"tel://"]];
    
}

-(void)emails:(NSString *)mail
{
    NSString * name = [[Animales sharedInstance] animalNombre];
     NSString * const body = [NSString stringWithFormat:@ "Buenas! Soy %@, cómo va? Quería comentarte que estuve usando la App Tamagochi para comerme todo y está genial. Bajatela YA!!   Saludos!",name ];
     
     //creacion del msj
     MFMailComposeViewController * composer = [[MFMailComposeViewController alloc]init ];
     
     composer.mailComposeDelegate= self;
     [composer setSubject:@"Que app copada"];
     [composer setMessageBody:body isHTML:NO];
    [composer setToRecipients:[NSArray arrayWithObject:mail]];
     
     
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


@end
