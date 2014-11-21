//
//  CellCustom.m
//  AppProyectoTamagochi
//
//  Created by Analia on 20/11/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import "CellCustom.h"


@interface CellCustom ()
@property (weak,nonatomic) IBOutlet UIImageView * imagencomida;
@property (weak,nonatomic) IBOutlet UILabel * nombrecomida;

@end
@implementation CellCustom


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)configurarCelda:(Comidas * )comida
{
    [self.imagencomida setImage:[UIImage imageNamed:[comida imagencomida]]];
    [self.nombrecomida setText:[comida nombrecomida]];

}


@end
