//
//  AppDelegate.m
//  AppProyectoTamagochi
//
//  Created by Analia on 18/11/14.
//  Copyright (c) 2014 Analia. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewControllerInicio.h"
#import "ViewControllerSeleccion.h"
#import "NetworkManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    
    ViewControllerInicio * ControlerInicio =[[ViewControllerInicio alloc] initWithNibName:@"ViewControllerInicio" bundle:nil];
   
   
    self.window.rootViewController =  [[UINavigationController alloc]initWithRootViewController:ControlerInicio];
    
    [self.window makeKeyAndVisible];
    
    [[NetworkManager sharedInstance]GET:(@"/key/value/one/two")
                             parameters:nil
                                success:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([responseObject isKindOfClass:[NSArray class]]) {
             NSArray *responseArray = responseObject;
              NSLog(@"JSON array: %@", responseArray);
             /* do something with responseArray */
         } else if ([responseObject isKindOfClass:[NSDictionary class]]) {
             NSDictionary *responseDict = responseObject;
             NSString * valor = [responseDict valueForKey:@"key"];
            UIAlertView *alerta= [[UIAlertView alloc]initWithTitle: @"alerta" message: valor delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles: nil ];
            [alerta show];
//             [responseDict valueForKey:@"key"]
              NSLog(@"JSON diccionario: %@", responseDict);
             /* do something with responseDict */
         }
     }
            failure:^(NSURLSessionDataTask *task, NSError *error) {
                                    NSLog(@"Error: %@", error);}
     ];

    
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
