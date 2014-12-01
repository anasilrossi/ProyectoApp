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
@interface ViewControllerRanking ()
@property (weak, nonatomic) IBOutlet UITableView *table_pet;
@property(strong,nonatomic)NSMutableArray * array_pet;
@property(strong,nonatomic)NSArray * sortedArray;
@end

@implementation ViewControllerRanking

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"Ranking de Mascotas"];
    
    [self.table_pet registerNib:[UINib nibWithNibName:@"CellCustomRanking"
                                           bundle:[NSBundle mainBundle]]
     forCellReuseIdentifier:@"CellCustomRanking"] ;
    [self listaMascota];
    self.sortedArray = [[NSArray alloc] init];
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
    __weak ViewControllerRanking * weakself = self;
    [[TamagochiNetwork sharedInstance]GET:@"/pet/all"
                               parameters:nil
                                  success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSArray * responseDict = responseObject;
         //[[Animales sharedInstance]decodificardic:responseDict];
         NSLog(@"JSON array: %@", responseDict);
         weakself.array_pet = [[NSMutableArray alloc]init];
         for (NSDictionary * dic in responseObject) {
             
             Animales * masc =[[Animales alloc]initwithDici:dic];
             [weakself.array_pet addObject:masc];
             
            }
         [self Ordenar];
         [weakself.table_pet reloadData];
         
     }
                                  failure:^(NSURLSessionDataTask *task, NSError *error) {
                                      NSString * errores = error;
                                      UIAlertView * alerta = [[UIAlertView alloc]initWithTitle:@"" message:errores delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
                                      [alerta show];}
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
    
    
    self.sortedArray = [self.array_pet sortedArrayUsingComparator:^NSComparisonResult(Animales * a, Animales * b)
                   {
                       NSNumber *first = [NSNumber numberWithInt:a.nivel];
                       NSNumber *second = [NSNumber numberWithInt:b.nivel];
                       return [second compare:first];
                   }];
    return self.sortedArray;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
