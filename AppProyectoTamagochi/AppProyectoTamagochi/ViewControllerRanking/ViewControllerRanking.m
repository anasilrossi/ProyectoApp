//
//  ViewControllerRanking.m
//  AppProyectoTamagochi
//
//  Created by Analia on 11/29/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import "ViewControllerRanking.h"
#import "Animales.h"
#import "CellCustomRanking.h"
#import "ViewControllerElegida.h"
#import "TamagochiNetwork.h"
#import "ViewControllerMap.h"
#import "Helper.h"
#import "Mascotas.h"
#import "NSTimer+TimerSafeInvalidate.h"

@interface ViewControllerRanking ()
@property (weak, nonatomic) IBOutlet UITableView *table_pet;
@property(strong,nonatomic)NSMutableArray * array_pet;
@property(strong,nonatomic)NSArray * sortedArray;
@property(strong,nonatomic)Mascotas *masc;
@property (strong,nonatomic) NSTimer * timer;
@end

@implementation ViewControllerRanking

- (void)viewDidLoad {
    [super viewDidLoad];
    self.array_pet = [NSMutableArray new];

    [self setTitle:@"Ranking de Mascotas"];
    
    [self.table_pet registerNib:[UINib nibWithNibName:@"CellCustomRanking"
                                           bundle:[NSBundle mainBundle]]
     forCellReuseIdentifier:@"CellCustomRanking"] ;
    self.sortedArray = [[NSArray alloc] init];
    [self listaMascota];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.sortedArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"CellCustomRanking";
    //Intentamos recuperar una celda ya creada.
    CellCustomRanking * cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (!cell) {
        //Si la celda no existe, la creamos.
        cell = [[CellCustomRanking alloc] init];
    }
    [cell configurarCelda:[self.sortedArray objectAtIndex:indexPath.row]];
   NSString * codigo = [[NSString alloc]init];
    
    codigo = [((Animales *)self.sortedArray[indexPath.row]) codigoAnimal];
    [cell configurarColor:codigo];
    
    return cell;
}

-(void)listaMascota
{
    if (self.array_pet.count) {
        [self.array_pet removeAllObjects];
    }
    [self.array_pet addObjectsFromArray:[Mascotas devolverTodo]];
    [self Ordenar];
    [self.table_pet reloadData];
   self.timer =[NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(get) userInfo:nil repeats:NO];
    
}

-(void)get
{
    __weak ViewControllerRanking * weakself = self;
    [[TamagochiNetwork sharedInstance]GET:@"/pet/all"
                               parameters:nil
                                  success:^(NSURLSessionDataTask *task, id responseObject)
     {
         
         NSArray * responseDict = responseObject;
         //[[Animales sharedInstance]decodificardic:responseDict];
         NSLog(@"JSON array: %@", responseDict);
         weakself.array_pet = [[NSMutableArray alloc]init];
         [Mascotas borrarTodo];
         for (NSDictionary * dic in responseObject) {
             
             Mascotas* mascota =[[Mascotas alloc]initWithDici:dic];
             [Mascotas insertCoreData:mascota];
             [weakself.array_pet addObject:mascota];
             
            [self.timer invalidartimer];
             
         }
         [self Ordenar];
         [weakself.table_pet reloadData];
         
       
     }
     
                                  failure:^(NSURLSessionDataTask *task, NSError *error) {
                                      NSString * errores = [error localizedDescription];
                                      UIAlertView * alerta =[[UIAlertView alloc]initWithTitle:@"Error" message:errores delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:  nil ];[alerta show];
                                  }
     ];
    
 
}

-(NSArray *)Ordenar
{
    /*encontrado en Internet!
    NSArray *sortedArray;
    sortedArray = [drinkDetails sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSDate *first = [(Person*)a birthDate];
        NSDate *second = [(Person*)b birthDate];
        return [first compare:second];
    }]
     */
    
    
    self.sortedArray = [self.array_pet sortedArrayUsingComparator:^NSComparisonResult(Mascotas * a, Mascotas * b)
                   {
                       NSNumber *first = [NSNumber numberWithInt:a.nivel];
                       NSNumber *second = [NSNumber numberWithInt:b.nivel];
                       return [second compare:first];
                   }];
    return self.sortedArray;

}

#pragma mark-UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Mascotas * mascotaElegida =[[Mascotas alloc] init];

   mascotaElegida=[self.sortedArray objectAtIndex:indexPath.row];
    
    ViewControllerMap * controlmap = [[ViewControllerMap alloc]initWithNibName:@"ViewControllerMap" bundle:[NSBundle mainBundle] ];
    [controlmap setMascotaActual:mascotaElegida];
    [self.navigationController pushViewController:controlmap animated:YES];
}


-(void)viewWillDisappear:(BOOL)animated
{
   // [self.timer invalidartimer];
}

@end
