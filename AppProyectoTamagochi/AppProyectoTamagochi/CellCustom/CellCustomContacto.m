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
@property(strong,nonatomic) NSString * telefono;
@property(strong,nonatomic) NSString * email;
@end

@implementation CellCustomContacto


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configurarCelda:(Contact *)contacto
{
    self.nombreContacto.text= contacto.name;
    self.telefonoContacto.text =contacto.phone;
    self.telefono= contacto.phone;
    self.emailContacto.text = contacto.email;
    self.email=contacto.email;
}
- (IBAction)llamadas:(id)sender {
    [self.delegate llamadas:self.telefono];
}

- (IBAction)emails:(id)sender {
    [self.delegate emails:self.email];
}

@end
