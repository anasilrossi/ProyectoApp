//
//  CellCustomContacto.h
//  AppProyectoTamagochi
//
//  Created by Analia on 12/5/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"

@protocol MyCustomCellDelegate <NSObject>
- (void)llamadas:(NSString *)numero;
-(void)emails:(NSString *)mail;
@end

@interface CellCustomContacto : UITableViewCell
@property (nonatomic, assign) id<MyCustomCellDelegate> delegate;
-(void)configurarCelda:(Contact *)contacto;

@end
