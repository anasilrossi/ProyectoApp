//
//  ViewControllerComida.m
//  AppProyectoTamagochi
//
//  Created by Analia on 20/11/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import "ViewControllerComida.h"
#import "Comida.h"
#import "CellCustom.h"

@interface ViewControllerComida ()
@property (nonatomic) NSUInteger * cantidad;
@property (weak, nonatomic) IBOutlet UITableView * tableview;
@property (weak, nonatomic) Comidas * guardarcomida;
@property (strong,nonatomic) NSMutableArray *ComidasArray;

@end

@implementation ViewControllerComida

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Alimenta a tu mascota"];
    
    [_tableview registerNib:[UINib nibWithNibName:@"CellCustom"
                                          bundle:[NSBundle mainBundle]]
                            forCellReuseIdentifier:@"CellCustom"] ;
  
    
     self.ComidasArray = [[NSMutableArray alloc]init];

     [self.ComidasArray addObject:[[Comidas alloc]init:@"Pastel" imagen:@"comida_0"]];
    
     [self.ComidasArray addObject:[[Comidas alloc]init:@"Tarta" imagen:@"comida_1"]];
    
     [self.ComidasArray addObject:[[Comidas alloc]init:@"Helado" imagen:@"comida_2"]];
    
     [self.ComidasArray addObject:[[Comidas alloc]init:@"Pollo" imagen:@"comida_3"]];
    
     [self.ComidasArray addObject:[[Comidas alloc]init:@"Hamburguesa" imagen:@"comida_4"]];
    
     [self.ComidasArray addObject:[[Comidas alloc]init:@"Pescado" imagen:@"comida_5"]];
    
     [self.ComidasArray addObject:[[Comidas alloc]init:@"Fruta" imagen:@"comida_6"]];
    
     [self.ComidasArray addObject:[[Comidas alloc]init:@"Salchicha" imagen:@"comida_7"]];
    
     [self.ComidasArray addObject:[[Comidas alloc]init:@"Pan" imagen:@"comida_8"]];
    
      //self.cantidad =[self.ComidasArray count];
    
      [_tableview reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.ComidasArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"CellCustom";
    //Intentamos recuperar una celda ya creada.
    CellCustom * cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (!cell) {
        //Si la celda no existe, la creamos.
        cell = [[CellCustom alloc] init];
    }
    [cell configurarCelda:[self.ComidasArray objectAtIndex:indexPath.row]];
  
   
    return cell;
}
#pragma mark-UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     self.guardarcomida=[self.ComidasArray objectAtIndex:indexPath.row];
  
    [self DevolverComida:self.guardarcomida];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark-foot
-(void)DevolverComida:(Comidas*)comidas
{
    if ([self.delegate respondsToSelector:@selector( DevolverComida:)]) {
        [self.delegate DevolverComida:self.guardarcomida];
    }
  

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.f;
}

@end


