//
//  ViewControllerContacto.m
//  AppProyectoTamagochi
//
//  Created by Analia on 12/5/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import "ViewControllerContacto.h"
#import "Contact.h"
#import "CellCustomContacto.h"

@interface ViewControllerContacto ()

@property (weak, nonatomic) IBOutlet UITableView *tabla_contacto;
@property (strong,nonatomic) NSNumber * cantidad;
@property (strong,nonatomic) Contact * obj;
@property (strong,nonatomic)NSMutableArray * arrayContactos;
@end

@implementation ViewControllerContacto
ABAddressBookRef addressBook ;


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
    addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    
    // Comprobamos el estado de permisos de usuario
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
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
    CFArrayRef all = ABAddressBookCopyArrayOfAllPeople(addressBook);
    
    // Obtenemos el total de contactos encontrados
    CFIndex n = ABAddressBookGetPersonCount(addressBook);
    
    self.cantidad= [NSNumber numberWithLong:n];
    
    
    // Recorremos todos los contactos
    for( int i = 0 ; i < n ; i++ )
    {
        // Obtenemos el contacto
        ABRecordRef ref = CFArrayGetValueAtIndex(all, i);
        // Obtenemos el nombre del contacto
        NSString * firstName = (__bridge NSString *)ABRecordCopyValue(ref, kABPersonFirstNameProperty);
        ABMultiValueRef phones = ABRecordCopyValue(ref, kABPersonPhoneProperty);
        NSString * phoneNumber = (__bridge NSString *) ABMultiValueCopyValueAtIndex(phones, 0);
        ABMultiValueRef emailProperty = ABRecordCopyValue(ref, kABPersonEmailProperty);
        NSString * emails = (__bridge NSString*)ABMultiValueCopyValueAtIndex(emailProperty,0);
        
        if(phoneNumber != nil && emails != nil)
        {
            
            self.obj = [[Contact alloc]init];
            self.obj.name = firstName;
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
        cell = [[CellCustomContacto alloc] init];
    }
    [cell configurarCelda:[self.arrayContactos objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark-UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Contact * cont = [self.arrayContactos objectAtIndex:indexPath.row];
    NSString * phoneNumber = cont.phone;
    NSURL *cleanPhoneNumber = [NSURL URLWithString:[NSString stringWithFormat:@"%@", phoneNumber]];
    [[UIApplication sharedApplication] openURL:cleanPhoneNumber];
    UIAlertView * alerta = [[UIAlertView alloc]initWithTitle:@"Tel" message:[NSString stringWithFormat:@"Comprate un device, con este simulador barato no podes hacer llamadas.El numero es: %@",phoneNumber] delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:@"Cancelar", nil];[alerta show];
}


@end
