//
//  AppDelegate.m
//  IDOBluetoothDemo
//
//  Created by hedongyang on 2018/8/31.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "AppDelegate.h"
#import "ScanViewController.h"
#import "FuncViewController.h"
#import "FuncViewModel.h"
#import "UpdateMainViewModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)listenConnectBindState:(NSNotification *)notivication
{
    IDOGetDeviceInfoBluetoothModel * model = (IDOGetDeviceInfoBluetoothModel *)notivication.object;
    //untying a device requires deleting the device information for the corresponding business store
    if (!model.bindState) {
        //if the current device is not bound, the connection can only be scanned through the list
        model = [IDOGetDeviceInfoBluetoothModel currentModel];
        if (!model.bindState) {
            ScanViewController * scanVC  = [[ScanViewController alloc]init];
            UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:scanVC];
            [UIApplication sharedApplication].delegate.window.rootViewController = nav;
        }else {
           //if the current device is in a bound state, an automatic scan connection is started without any additional action
        }
    }else if (model.authCodeError) {
        FuncViewController * funVc = (FuncViewController *)[IDODemoUtility getCurrentVC];
        [funVc showToastWithText:lang(@"auth code error")];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /*
    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(10);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (int i = 0; i < 100; i++)
    {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_group_async(group, queue, ^{
            NSLog(@"%i",i);
            sleep(2);
            dispatch_semaphore_signal(semaphore);
        });
    }
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
*/
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(listenConnectBindState:)
                                                name:IDOBluetoothDeviceBindNotifyName
                                              object:nil];
#ifdef DEBUG
    registrationServices(nil).outputSdkLog(YES).outputProtocolLog(NO).rawDataLog(YES).startScanBule(^(IDOGetDeviceInfoBluetoothModel * _Nullable model) {
        //You can use your own bluetooth management here
       if(__IDO_BIND__)[IDOBluetoothManager startScan];
       else [IDOBluetoothManager refreshDelegate];
    });
#else
    registrationServices(nil).outputSdkLog(YES).outputProtocolLog(YES).rawDataLog(YES).useFunctionTable(NO).startScanBule(^(IDOGetDeviceInfoBluetoothModel * _Nullable model) {
        //You can use your own bluetooth management here
        if(__IDO_BIND__)[IDOBluetoothManager startScan];
        else [IDOBluetoothManager refreshDelegate];
    });
#endif
    
    if (__IDO_BIND__) {
        int mode = (int)[[NSUserDefaults standardUserDefaults]integerForKey:PRODUCTION_MODE_KEY];
        if (mode == 1) {
            FuncViewController * update = [[FuncViewController alloc]init];
            update.model = [UpdateMainViewModel new];
            update.title = lang(@"device update");
            UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:update];
            self.window.rootViewController = nav;
        }else {
            FuncViewController * home = [[FuncViewController alloc]init];
            home.model = [FuncViewModel new];
            home.title = lang(@"function list");
            UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:home];
            self.window.rootViewController = nav;
        }
    } else {
        ScanViewController * scanVC  = [[ScanViewController alloc]init];
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:scanVC];
        self.window.rootViewController = nav;
    }
    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    NSString * docsdirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject];
    if (url != nil) {
        NSString *path = [url absoluteString];
        path = [path stringByRemovingPercentEncoding];
        NSMutableString *string = [[NSMutableString alloc] initWithString:path];
        if ([path hasPrefix:@"file:///private"]) {
            [string replaceOccurrencesOfString:@"file:///private" withString:@"" options:NSCaseInsensitiveSearch  range:NSMakeRange(0, path.length)];
        }
        NSArray  * tempArray  = [string componentsSeparatedByString:@"/"];
        NSString * fileName   = tempArray.lastObject;
        //        NSString * sourceName = options[@"UIApplicationOpenURLOptionsSourceApplicationKey"];
        NSFileManager * fileManager = [NSFileManager defaultManager];
        NSString * filePath = [docsdirPath stringByAppendingPathComponent:fileName];
        if ([fileManager fileExistsAtPath:filePath]) {
            [fileManager removeItemAtPath:filePath error:nil];
        }
        [fileManager copyItemAtPath:string toPath:filePath error:nil];
    }
    return  YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
