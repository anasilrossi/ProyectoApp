//
//  Animales.m
//  TuMascotaVirtual
//
//  Created by Analia on 22/11/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import "Animales.h"
#import "TamagochiNetwork.h"
#import <Parse/Parse.h>
#import "TNetworkService.h"
@interface Animales ()
@property (nonatomic,strong) NSMutableArray *  respuesta;
@property (nonatomic,strong) Animales *  animal;
@property (nonatomic,strong) TNetworkService * service;
@end

@implementation Animales

NSString  * const  code =@"AR7666";
  __strong static id _sharedObject = nil;

#pragma mark - Constructors

+ (instancetype) sharedInstance
{
    static dispatch_once_t pred = 0;
  
    //Garantiza que lo que se encuentre dentro solo se ejecutará una vez.
    dispatch_once(&pred, ^{
        [Animales loadDataFromDisk];
        if (_sharedObject == nil) {
             _sharedObject = [[self alloc] initEnergia:[NSNumber numberWithInt:100] niveles:[NSNumber numberWithInt:1] experiencia:[NSNumber numberWithInt:0] ];
        }
    
       
    });
    return _sharedObject;
}

-(instancetype) initEnergia: (NSNumber *) cambiarEnergia niveles:(NSNumber*) cambiarNivel experiencia:(NSNumber *)cambiarExperiencia
{
    self = [super init];
    if (self) {
        self.energia =[NSNumber numberWithInt:100];
        self.energia = cambiarEnergia;
        self.nivel = cambiarNivel;
        self.experiencia = cambiarExperiencia;
    }
    return self;
}

-(NSNumber*)menosEnergia
{

    self.energia  = [NSNumber numberWithInt:[self.energia intValue] - 10 ];
    NSLog(@"%@",self.energia);
    return self.energia;
}

-(NSNumber *)masEnergia: (int)valor
{
   self.energia  = [NSNumber numberWithInt:[self.energia intValue] + valor];
    NSLog(@"%@",self.energia);
    return self.energia;
       
}

-(BOOL)puedeejercitar
{
    BOOL consulta ;
    if (self.energia != 0 )
    {
        return  consulta = YES;
    }
    else
    {
        return consulta = NO;
    }
}

-(int)devolverEnergia
    {
    
    return [self.energia intValue];
    }

-(NSNumber *)aumentarExperiencia:(int)valor
{
    if (self.energia!=0) {
        self.experiencia = [NSNumber numberWithInt: valor + [self.experiencia intValue]];
        self.nivel =[self subirNivel:self.experiencia];
       // NSLog([NSString stringWithFormat:@"experiencia:%d nivel:%d ",self.experiencia, self.nivel]);
       
    }
   return self.experiencia;
}

-(NSNumber *)devolverExperiencia
{
    return self.experiencia;
}

-(NSNumber *)devolverNivel
{
    return self.nivel;
}

-(NSNumber *)subirNivel : (NSNumber *)experiencia
{
    int valor = [self.nivel intValue] * [self.nivel intValue];
    int formula = 100 * valor;
    if ([self.experiencia intValue]>= formula)
    {
        int aux1 = [self.nivel intValue]+1;
        self.nivel = [NSNumber numberWithInt:aux1];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"REFRESCAR_NIVEL" object:nil];
         [self updates];
        // Send a notification to all devices subscribed to the "Giants" channel.
        [self PushRemoto];
        int aux= [self.experiencia intValue];
        aux = aux - formula;
        self.experiencia = [NSNumber numberWithInt:aux] ;
    }
    return  self.nivel;
}

-(void)PushRemoto
{
    PFPush *push = [[PFPush alloc] init];
    [push setChannel:@"PeleaDeMascotas"];
    [push setMessage: [NSString stringWithFormat: @"La mascota subio de nivel Level:%@",self.nivel]];
    [push setData:[self devolverMascota]];
    [push sendPushInBackground];
}

-(void)updates
{
    self.service =[[TNetworkService alloc]init] ;
    [self.service postEvents:[self getSucces] failure:[self getFailure]];
}

-(Success)getSucces
{
    return ^(NSMutableArray * array) {
        NSMutableArray * responseDict = array;
        NSString * valor = [responseDict valueForKey:@"status"];
        if ([valor isEqualToString: @"ok"]) {
            NSLog(@"Perfecto! JSON: %@", array);
          
        }
        else
        {
            UIAlertView * alerta =[[UIAlertView alloc]initWithTitle: @"alerta" message: @"Error " delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles: nil ];
            [alerta show];
            
        }
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
     
-(void)decodificardic:(NSDictionary*)diccionario
{
    self.energia = [diccionario valueForKey:@"energy"];
  
    self.experiencia = [diccionario valueForKey:@"experience"] ;
    
    self.nivel=[diccionario valueForKey:@"level"] ;
    
    self.animalNombre =[diccionario valueForKey:@"name"];
    
    self.tipoAnimal = [diccionario valueForKey:@"pet_type"];
 
}

-(NSDictionary *)devolverMascota
{
    NSString * sEnergia = [NSString stringWithFormat:@"%@",self.energia ];
    NSString * sNivel = [NSString stringWithFormat:@"%@",self.nivel ];
    NSString * sExperiencia = [NSString stringWithFormat:@"%@",self.experiencia ];
    NSString * sAnimal = [NSString stringWithFormat:@"%@",self.tipoAnimal];
    NSDictionary * mascota = @{@"name":self.animalNombre,
                                @"energia": sEnergia ,
                                @"level": sNivel,
                                @"experience":sExperiencia,
                                @"Animal":sAnimal,
                                @"Code":@"AR7666",} ;
    return mascota;
}

+(void)saveDataToDisk
{
    NSString *path = [self pathForDataFile];
    NSMutableDictionary *rootObject;
    rootObject = [NSMutableDictionary dictionary];
    
    [rootObject setObject:[Animales sharedInstance]  forKey:@"Animal"];
    BOOL didEncode = [NSKeyedArchiver archiveRootObject: rootObject toFile: path];
    if (didEncode) {
        NSLog(@"Encode ok");
    }
}

+(void)loadDataFromDisk
{
    NSString *path = [self pathForDataFile];
    NSDictionary *rootObject;
    rootObject = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    _sharedObject=[rootObject objectForKey:@"Animal"];
    
}

+ (NSString *) pathForDataFile
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString* directory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSError* error;
    
    directory = [directory stringByExpandingTildeInPath];
    
    if ([fileManager fileExistsAtPath: directory] == NO)
    {
        
        [fileManager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:&error];
    }
    
    NSString *fileName = [directory stringByAppendingString:@"/Tamagochi.fnk"];
    
    return fileName;
}

#pragma mark NSCoder

- (id) initWithCoder: (NSCoder *)coder
{
    
    self = [super init];
    if (self)
    {
        [self setAnimalNombre:[coder decodeObjectForKey:@"name"]]; //Por cada property.
        [self setTipoAnimal :[NSNumber numberWithInt:[coder decodeIntForKey:@"pet_type"]]];
        [self setEstadoAnimal:[NSNumber numberWithInt:[coder decodeIntForKey:@"estado"]]];
        [self setNivel: [NSNumber numberWithInt:[coder decodeIntForKey:@"level"]]];
        [self setExperiencia:[NSNumber numberWithInt: [coder decodeIntForKey:@"experience"]]];
        [self setAltitude:[NSNumber numberWithDouble:[coder decodeDoubleForKey:@"position_lat"]]];
        [self setLongitud:[NSNumber numberWithDouble:[coder decodeDoubleForKey:@"position_lon"]]];
        [self setCodigoAnimal:[coder decodeObjectForKey:@"code"]];
        [self setEnergia:[NSNumber numberWithInt:[coder decodeIntForKey:@"energy"]]];
    }
    return self;
}

- (void) encodeWithCoder: (NSCoder *)coder
{
    [coder encodeObject: self.animalNombre forKey:@"name"];
    [coder encodeInt:((NSNumber *)self.tipoAnimal).intValue forKey:@"pet_type"];
    [coder encodeInt:((NSNumber *)self.estadoAnimal ).intValue forKey:@"estado"];
    [coder encodeInt:((NSNumber *)self.nivel).intValue forKey:@"level"];
    [coder encodeInt:((NSNumber *)self.experiencia).intValue forKey:@"experience"];
    [coder encodeDouble:((NSNumber *)self.altitude ).intValue forKey:@"position_lat"];
    [coder encodeDouble:((NSNumber *)self.longitud ).intValue forKey:@"position_lon"];
    [coder encodeObject:self.codigoAnimal forKey:@"code"];
    [coder encodeInt:((NSNumber *)self.energia).intValue forKey:@"energy"];
}


@end
