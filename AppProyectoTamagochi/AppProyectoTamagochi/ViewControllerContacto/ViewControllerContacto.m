//
//  ViewControllerContacto.m
//  AppProyectoTamagochi
//
//  Created by Analia on 12/5/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import "ViewControllerContacto.h"
#import "CellCustomContacto.h"

@interface ViewControllerContacto ()
@property (weak, nonatomic) IBOutlet UITableView *tabla_contacto;

@end

@implementation ViewControllerContacto

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Ranking de Mascotas"];
    
    [self.tabla_contacto registerNib:[UINib nibWithNibName:@"CellCustomContacto"
                                               bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"CellCustomContacto"] ;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
     CellCustomContacto * cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (!cell) {
        //Si la celda no existe, la creamos.
        cell = [[CellCustomContacto alloc] init];
    }
    [cell configurarCelda ];
    
    return cell;
}

#pragma mark-UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
