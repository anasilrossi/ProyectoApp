//
//  ViewControllerComida.h
//  AppProyectoTamagochi
//
//  Created by Analia on 20/11/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comida.h"

@protocol Foot <NSObject>

-(void)DevolverComida:(Comidas*)comidas;


@end
@interface ViewControllerComida : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak)id<Foot> delegate;
@end
