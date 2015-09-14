//
//  BaseTabBarController.m
//  MusicApp
//
//  Created by 许汝邈 on 15/9/13.
//  Copyright © 2015年 miao. All rights reserved.
//

#import "BaseTabBarController.h"

@interface BaseTabBarController ()<UITabBarControllerDelegate>
{
    UIImageView *_imageView1;
}
@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.tabBar.translucent = YES;
    self.tabBar.tintColor = [UIColor whiteColor];
    
    self.delegate = self;
    
    _imageView1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tabBarbg.png"]];
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    _imageView1.frame = CGRectMake(0, 0, w/4, 49);
    [self.tabBar addSubview:_imageView1];
    
    
    
    
}


-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    NSInteger a = tabBarController.selectedIndex;
    NSLog(@"a = %ld",a);
    _imageView1.frame = CGRectMake(a* w/4, 0, w/4, 49);
    
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
