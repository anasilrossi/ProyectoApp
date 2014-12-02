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
#import "ViewControllerElegida.h"
#import "NetworkManager.h"
#import "Animales.h"
#import <Parse/Parse.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes: (UIUserNotificationTypeAlert |UIUserNotificationTypeBadge | UIUserNotificationTypeSound) categories:nil]];
    }
    else {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                                               UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)]; }
#else
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
#endif
    
    UILocalNotification *localNotif =
    [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (localNotif) {
    }
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    NSUserDefaults * user= [NSUserDefaults standardUserDefaults];
    
    ViewControllerInicio * ControlerInicio =[[ViewControllerInicio alloc] initWithNibName:@"ViewControllerInicio" bundle:nil];
    ViewControllerSeleccion * controlerseleccion =[[ViewControllerSeleccion alloc] initWithNibName:@"ViewControllerSelecion" bundle:nil];
    ViewControllerElegida * controlerelegida =[[ViewControllerElegida alloc] initWithNibName:@"ViewControllerElegida" bundle:nil];
    
    if (![user boolForKey:@"ViewOne"])
    {
        self.window.rootViewController =  [[UINavigationController alloc]initWithRootViewController:ControlerInicio];

    }
   else if (![user boolForKey:@"ViewTwo"])
   {
       self.window.rootViewController =  [[UINavigationController alloc]initWithRootViewController:controlerseleccion];
   }
   else
   {
       self.window.rootViewController =  [[UINavigationController alloc]initWithRootViewController:controlerelegida];
   }
    
    [self.window makeKeyAndVisible];
    
    [Parse setApplicationId:@"guhchukKgURzzZVCHBFOxyD35VHeMQm3EUZEdJvD" clientKey:@"SnnbrQ9yOemJspA7LRt1MCACFFUYNkbQ1k2IM1vH"];
    
    
    
    
    // Override point for customization after application launch.
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"Successfully got a push token: %@", deviceToken);
    //Este token es el que utilizara nuestro servidor para enviarnos pushes remotas :).
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation addUniqueObject:@"PeleaDeMascotas" forKey:@"channels"];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Failed to register for push notifications! Error was: %@", [error localizedDescription]);
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTIFICACION_NIVEL" object:nil userInfo:notification.userInfo];
    
    application.applicationIconBadgeNumber = notification.applicationIconBadgeNumber - 1;
    NSLog(@"llego la notificacion local en fore");
    
}

- (void)application:(UIApplication *)app didReceiveRemoteNotification:(UILocalNotification *)notif {
    UIAlertView * alerta = [[UIAlertView alloc]initWithTitle:@"Alerta" message:@"llego" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
    [alerta show];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    [Animales  saveDataToDisk];
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [Animales saveDataToDisk];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [Animales sharedInstance];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
    [Animales  saveDataToDisk];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
