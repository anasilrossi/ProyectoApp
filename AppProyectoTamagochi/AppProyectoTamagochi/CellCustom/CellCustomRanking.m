//
//  CellCustomRanking.m
//  AppProyectoTamagochi
//
//  Created by Analia on 11/29/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import "CellCustomRanking.h"
#import "CargarImagenes.h"
@interface CellCustomRanking ()

@property (weak, nonatomic) IBOutlet UIImageView *Imagen_Pet;
@property (weak, nonatomic) IBOutlet UILabel *Name_pet;
@property (weak, nonatomic) IBOutlet UILabel *level_pet;

@end

@implementation CellCustomRanking

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configurarCelda:( Animales * )pet
{

    [self.Imagen_Pet setImage:[CargarImagenes Cargarimagen:pet.tipoAnimal]];
    [self.Name_pet setText:pet.animalNombre];
    [self.level_pet setText:[NSString stringWithFormat:@"%d",pet.nivel]];
    
}


@end
