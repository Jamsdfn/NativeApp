#import "SceneDelegate.h"
#import "TabBarController.h"
#import "GuideController.h"
@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // 创建 window
    self.window = [[UIWindow alloc] initWithFrame:KScreenSize];
    // 设置 scene
    self.window.windowScene = (UIWindowScene*)scene;
    
    self.window.rootViewController = [self pickRootController];
    // window 显示
    [self.window makeKeyAndVisible];
    // 保存当前版本到沙盒中
    [self saveAppVersion];
}

// 判断应该显示那个控制器
- (UIViewController*)pickRootController{
    if ([[self loadOldVersion] isEqualToString:[self loadInfoVersion]]){
        // 显示默认的控制器
         return [[TabBarController alloc] init];
    } else {
        // 显示新特性控制器
        return [[GuideController alloc] init];
    }
}

// 把当前的版本号保存到沙盒中
- (void)saveAppVersion{
    NSString *infoVersion = [self loadInfoVersion];
    // 往沙盒中存的版本号
    [[NSUserDefaults standardUserDefaults] setObject:infoVersion forKey:@"oldVersion"];
}

- (NSString*)loadOldVersion{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"oldVersion"];
}

- (NSString*)loadInfoVersion{
    NSDictionary *info = [NSBundle mainBundle].infoDictionary;
    return info[@"CFBundleShortVersionString"];
}

- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
