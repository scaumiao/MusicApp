//
//  AppDelegate.m
//  MusicApp
//
//  Created by 许汝邈 on 15/9/9.
//  Copyright © 2015年 miao. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
{
     BaseTabBarController *_rootTab;
}
@end

@implementation AppDelegate


    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
    {
        //1.创建Window
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.backgroundColor = [UIColor whiteColor];
        
        //a.初始化一个tabBar控制器
        _rootTab=[[BaseTabBarController alloc]init];
        
        //设置控制器为Window的根控制器
        self.window.rootViewController=_rootTab;
        
        //设置导航条背景图
       // [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabBarbg.png"] forBarMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:211/255.0 green:58/255.0 blue:49/255.0 alpha:1.0f]];
        
        
        
        //b.创建子控制器
        FirstTBViewController *c1=[[FirstTBViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:c1];
    
        c1.tabBarItem.title=@"发现音乐";
        c1.tabBarItem.image=[UIImage imageNamed:@"main_index01.png"];
       
        //c1.tabBarItem.badgeValue=@"123";
        
        MyMusicTBViewController *c2=[[MyMusicTBViewController alloc]init];
        UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:c2];
        c2.view.backgroundColor=[UIColor colorWithRed:214/255.0 green:84/255.0 blue:76/255.0 alpha:1.0f];
        c2.tabBarItem.title=@"我的音乐";
        c2.tabBarItem.image = [UIImage imageNamed:@"main_index02.png"];
        
        
        UIViewController *c3=[[UIViewController alloc]init];
        c3.tabBarItem.title=@"朋友";
        c3.tabBarItem.image = [UIImage imageNamed:@"main_index03"];
        
        UIViewController *c4=[[UIViewController alloc]init];
        c4.tabBarItem.title=@"账号";
        c4.tabBarItem.image=[UIImage imageNamed:@"main_index04"];
        
        
        //c.添加子控制器到ITabBarController中
        //c.1第一种方式
        //    [tb addChildViewController:c1];
        //    [tb addChildViewController:c2];
        
        //c.2第二种方式
        _rootTab.viewControllers=@[nav,nav2,c3,c4];
        //_rootTab.tabBar.tintColor = [UIColor redColor];
        
        //设置tabbar背景颜色为黑色
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 49)];
        backView.backgroundColor = [UIColor blackColor];
        [_rootTab.tabBar insertSubview:backView atIndex:0];
        _rootTab.tabBar.opaque = YES;
        
        
        
        
        
        
        //2.设置Window为主窗口并显示出来
        [self.window makeKeyAndVisible];
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
