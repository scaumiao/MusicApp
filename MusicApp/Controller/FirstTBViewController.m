//
//  FirstTBViewController.m
//  MusicApp
//
//  Created by 许汝邈 on 15/9/13.
//  Copyright © 2015年 miao. All rights reserved.
//

#import "FirstTBViewController.h"

@interface FirstTBViewController ()<UISearchBarDelegate,UISearchResultsUpdating>

@end

@implementation FirstTBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _firstTBView = [[FirstTBView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width , self.view.frame.size.height)];
    _firstTBView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_firstTBView];
    
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(selectLeftAction:)];
    self.navigationItem.leftBarButtonItem = leftButton;
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd  target:self action:@selector(selectRightAction:)];
    
    
    self.navigationItem.rightBarButtonItem = rightButton;
    self.navigationItem.leftBarButtonItem = leftButton;
 
    
    //导航条的搜索条
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0.0f,0.0f,220.0f,44.0f)];
    _searchBar.delegate = self;
    [_searchBar setTintColor:[UIColor redColor]];
    [_searchBar setPlaceholder:@"搜索音乐、歌词、电台"];
    _searchBar.backgroundColor = [UIColor colorWithRed:214/255.0 green:84/255.0 blue:76/255.0 alpha:1.0f];
    
    _searchBar.backgroundImage = [self imageWithColor:[UIColor clearColor] size:_searchBar.bounds.size];
    
    
    
    
    //将搜索条放在一个UIView上
    UIView *searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 768, 44)];
    searchView.backgroundColor = [UIColor blueColor];
    [searchView addSubview:_searchBar];
    self.navigationItem.titleView = searchView;
    self.navigationItem.titleView.backgroundColor = [UIColor whiteColor];
    
    
    
    
    //self.title = @"发现音乐";
   
    
    
    //搜索框
    /*
    _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    
    _searchController.searchResultsUpdater = self;
    
    _searchController.dimsBackgroundDuringPresentation = NO;
    
    _searchController.hidesNavigationBarDuringPresentation = NO;
    
    _searchController.searchBar.frame = CGRectMake(100, 30, 100, 44.0);
    
    _searchController.searchBar.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_searchController.searchBar];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(100, 20, 100, 44.0)];
    
    [self.view addSubview:_searchBar];
     */
    [_searchBar endEditing:NO];
    
     [self setUpForDismissKeyboard];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)selectLeftAction:(id)sender
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你点击了导航栏左按钮" delegate:self  cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];
}
-(void)selectRightAction:(id)sender
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你点击了导航栏右按钮" delegate:self  cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];
}




-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *searchString = [self.searchController.searchBar text];
    
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    
   
}



#pragma -mark 取消searchbar背景色
//网上搜索的方法

- (UIImage *)imageWithColor:(UIColor *)color
                       size:(CGSize)size


{


    CGRect rect = CGRectMake(0, 0, size.width, size.height);


    UIGraphicsBeginImageContext(rect.size);


    CGContextRef context = UIGraphicsGetCurrentContext();



    CGContextSetFillColorWithColor(context,[color CGColor]);


    CGContextFillRect(context,rect);




    UIImage *image  = UIGraphicsGetImageFromCurrentImageContext();


    UIGraphicsEndImageContext();



    return image;


}

#pragma -mark 隐藏键盘
- (void)setUpForDismissKeyboard {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singleTapGR =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tapAnywhereToDismissKeyboard:)];
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    [nc addObserverForName:UIKeyboardWillShowNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [self.view addGestureRecognizer:singleTapGR];
                }];
    [nc addObserverForName:UIKeyboardWillHideNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [self.view removeGestureRecognizer:singleTapGR];
                }];
}

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    //此method会将self.view里所有的subview的first responder都resign掉
    [_searchBar endEditing:YES];
}

@end
