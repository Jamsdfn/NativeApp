#import "SceneDelegate.h"
#import "RedViewController.h"
@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // 创建窗口 指定大小
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.windowScene = (UIWindowScene *)scene;
    // 创建一个新的控制器
    UITabBarController *tabBar = [UITabBarController new];
    RedViewController *r1 = [RedViewController new];
    RedViewController *r2 = [RedViewController new];
    RedViewController *r3 = [RedViewController new];
    
    r1.view.backgroundColor = [UIColor redColor];
    r2.view.backgroundColor = [UIColor blueColor];
    r3.view.backgroundColor = [UIColor grayColor];
    //    [tabBar addChildViewController:r1];
    //    [tabBar addChildViewController:r2];
    //    [tabBar addChildViewController:r3];
    tabBar.viewControllers = @[r1, r2, r3];
    self.window.rootViewController = tabBar;
    // 将窗口作为应用程序的主窗口 并 可见
    [self.window makeKeyAndVisible];
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
