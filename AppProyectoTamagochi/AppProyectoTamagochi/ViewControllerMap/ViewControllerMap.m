//
//  ViewControllerMap.m
//  AppProyectoTamagochi
//
//  Created by Analia on 12/1/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import "ViewControllerMap.h"


@interface ViewControllerMap ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ViewControllerMap

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
