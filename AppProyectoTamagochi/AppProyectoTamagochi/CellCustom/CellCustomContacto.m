//
//  CellCustomContacto.m
//  AppProyectoTamagochi
//
//  Created by Analia on 12/5/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import "CellCustomContacto.h"
@interface CellCustomContacto ()

@property (weak, nonatomic) IBOutlet UILabel *nombreContacto;
@property (weak, nonatomic) IBOutlet UILabel *telefonoContacto;
@property (weak, nonatomic) IBOutlet UILabel *emailContacto;
@property (weak, nonatomic) IBOutlet UIButton *llamarContacto;
@property (weak, nonatomic) IBOutlet UIButton *mailContacto;

@end

@implementation CellCustomContacto


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configurarCelda
{
    
}

@end
